#!/usr/bin/perl -w
# $Id: Build.PL,v 1.25 2006/08/05 08:48:12 rocky Exp $
#    Copyright (C) 2006 Rocky Bernstein <rocky@cpan.org>
#
#    This program is free software; you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation; either version 2 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program; if not, write to the Free Software
#    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
use strict;
use warnings;
use Module::Build;
use ExtUtils::PkgConfig;
use Config;
use Data::Dumper;
use File::Fu;

my $code = <<'EOC';
use Config;
use File::Copy;
use File::Fu;

sub process_swig_files {
    my $self = shift;
    my $p = $self->{properties};
    return unless $p->{swig_source};
    my $files_ref = $p->{swig_source};
    foreach my $file (@$files_ref) {
	$self->process_swig($file->[0], $file->[1]);
    }
}

# Check check dependencies for $main_swig_file. These are the
# %includes. If needed, arrange to run swig on $main_swig_file to
# produce a xxx_wrap.c C file.

sub process_swig {
  my ($self, $main_swig_file, $deps_ref) = @_;
  my ($cf, $p) = ($self->{config}, $self->{properties}); # For convenience

  # File name. e.g, perlcdio.swg -> perlcdio_wrap.c
  (my $file_base = $main_swig_file) =~ s/\.[^.]+$//;
  my $c_file = "${file_base}_wrap.c";

  if ($p->{swig_installed}) {
      # .swg -> .c
      $self->add_to_cleanup($c_file);
      
      # print "+++ c_file: $c_file, file: $main_swig_file ", `pwd`, "\n";
      # If any of the swig files that the main swig depends is newer 
      # then rebuild.
      foreach my $depends_on ($main_swig_file, @$deps_ref) {
	  unless ($self->up_to_date($depends_on, $c_file)) {
	      $self->compile_swig($main_swig_file, $c_file);
	      # Only need to build $c_file once no matter how many 
	      # includes there are.
	      last;
	  }
      }
  }
  
  # .c -> .o
  my $obj_file = $self->compile_c($c_file);
  $self->add_to_cleanup($obj_file);

  # The .so files don't go in blib/lib/, they go in blib/arch/auto/.
  # Unfortunately we have to pre-compute the whole path.
  my $archdir;
  {
    my @dirs = File::Spec->splitdir($file_base);
    $archdir = File::Spec->catdir($self->blib,'arch', @dirs[1..$#dirs]);
  }
  
  # .o -> .so
  $self->link_c($archdir, $file_base, $obj_file);
}

# Invoke swig with -perl -outdir and other options.
sub compile_swig {
    my ($self, $file, $c_file) = @_;
    my ($cf, $p) = ($self->{config}, $self->{properties}); # For convenience
    
    # File name, minus the suffix
    (my $file_base = $file) =~ s/\.[^.]+$//;
    
    my @swig;
    if (defined($p->{swig})) {
	    @swig = $self->split_like_shell($p->{swig});
    } else {
	    @swig = ('swig');
    }
    if (defined($p->{swig_flags})) {
	    @swig_flags = $self->split_like_shell($p->{swig_flags});
    } else {
	    @swig_flags = ();
    }
   
    push @swig_flags, $self->split_like_shell( qq{-module Math::GSL::$file_base} );

    my $blib_lib =  File::Spec->catfile('blib','lib');
    #my $blib_lib = 'blib/lib';

    mkdir File::Spec->catfile($blib_lib, 'Math/GSL');

    print "+++swig -o $c_file -outdir $blib_lib -perl5 @swig_flags $file\n"; 
    $self->do_system(@swig, '-o', $c_file, '-outdir', $blib_lib . '/Math/GSL/',
		     '-perl5', @swig_flags, $file)
	or die "error building $c_file file from '$file'";
    
    my $pm_file = "${file_base}.pm";
    my $from = File::Spec->catfile($blib_lib, $pm_file);
    my $to   = File::Spec->catfile("lib", $pm_file);

    print "Copying from: $from, to: $to; it makes the CPAN indexer happy.\n";
    copy($from,$to);
    return $c_file;
}

# From Base.pm but modified for a SWIG conventions.
# We just pass a $obj_file parameter
# SWIG objects have a get created with _wrap added. For example
# perlcdio.swg produces perlcdio_wrap.c, and perlcdio_wrap.o.
# But the shared object is still perlcdio.so.
# Also we modified the die to report the full file name.
sub link_c {
  my ($self, $to, $file_base, $obj_file) = @_;
  my ($cf, $p) = ($self->{config}, $self->{properties}); # For convenience

  my $lib_file = File::Spec->catfile($to, File::Basename::basename("$file_base.so"));

  $self->add_to_cleanup($lib_file);
  my $objects = $p->{objects} || [];
  
  unless ($self->up_to_date([$obj_file, @$objects], $lib_file)) {
    my @linker_flags = $self->split_like_shell($p->{extra_linker_flags});
    my @lddlflags = $self->split_like_shell($cf->{lddlflags}); 
    my @shrp = $self->split_like_shell($cf->{shrpenv});
    my @ld = $self->split_like_shell($cf->{ld}) || "gcc";
    $self->do_system(@shrp, @ld, @lddlflags, @user_libs, '-o', $lib_file,
		     $obj_file, @$objects, @linker_flags)
      or die "error building $lib_file file from '$obj_file'";
  }
  
  return $lib_file;
}

# From Base.pm but modified to put package cflags *after* 
# installed c flags so warning-removal will have an effect.

sub compile_c {
  my ($self, $file) = @_;
  my ($cf, $p) = ($self->{config}, $self->{properties}); # For convenience
  
  # File name, minus the suffix
  (my $file_base = $file) =~ s/\.[^.]+$//;
  my $obj_file = "$file_base.so";
  $self->add_to_cleanup($obj_file);
  return $obj_file if $self->up_to_date($file, $obj_file);


  $cf->{installarchlib} = $Config{archlib};

  my @include_dirs = @{$p->{include_dirs}} 
			? map {"-I$_"} (@{$p->{include_dirs}}, File::Spec->catdir($cf->{installarchlib}, 'CORE'))
			: map {"-I$_"} ( File::Spec->catdir($cf->{installarchlib}, 'CORE') ) ;

  my @extra_compiler_flags = #split / /, q{-shared -Wall -fpic -Dbool=char -I/usr/local/include/};
   $self->split_like_shell($p->{extra_compiler_flags});

  my @cccdlflags = $self->split_like_shell($cf->{cccdlflags});

  my @ccflags = split / /, $self->split_like_shell($cf->{ccflags});
  my @optimize = $self->split_like_shell($cf->{optimize});

  # Whoah! There seems to be a bug in gcc 4.1.0 and optimization
  # and swig. I'm not sure who's at fault. But for now the simplest
  # thing is to turn off all optimization. For the kinds of things that
  # SWIG does - do conversions between parameters and transfers calls
  # I doubt optimization makes much of a difference. But if it does,
  # it can be added back via @extra_compiler_flags.

  my @flags = (@include_dirs, @cccdlflags, '-c', @ccflags,
               @extra_compiler_flags, 
       );
  
  my @cc = $self->split_like_shell($cf->{cc});
  @cc = "gcc" unless @cc;
  
  $self->do_system(@cc, @flags, '-o', $obj_file, $file)
    or die "error building $cf->{obj_ext} file from '$file'";

  return $obj_file;
}

EOC


sub try_compile {
    my ($c, %args) = @_;

    my $ok = 0;
    my $tmp = "tmp$$";
    local(*TMPC);

    my $obj_ext = $Config{obj_ext} || ".o";
    unlink("$tmp.c", "$tmp$obj_ext");

    if (open(TMPC, ">", "$tmp.c")) {
	print TMPC $c;
	close(TMPC);

	my $cccmd = $args{cccmd};
	my $errornull;
	my $ccflags =  $Config{'ccflags'};
    $ccflags .= " $args{ccflags}" if $args{ccflags};

    if ($args{silent} ) {
	    $errornull = "2>/dev/null" unless defined $errornull;
	} else {
	    $errornull = '';
	}

    $cccmd = "$Config{'cc'} -o $tmp $ccflags $tmp.c $errornull"
	    unless defined $cccmd;

	printf "cccmd = $cccmd\n" if $args{verbose};
	my $res = system($cccmd);
	$ok = defined($res) && $res == 0;

	if ( !$ok ) {
	    my $errno = $? >> 8;
	    local $! = $errno;
	    print "
		
*** The test compile of '$tmp.c' failed: status $?
*** (the status means: errno = $errno or '$!')
*** DO NOT PANIC: this just means that *some* you may get some innocuous
*** compiler warnings.
";
	}
	unlink("$tmp.c");

    }
    return $ok;
}

sub try_cflags ($) {
    my ($ccflags) = @_;
    my $c_prog = "int main () { return 0; }\n";
    print "Checking if $Config{cc} supports \"$ccflags\"...";
    my $result = try_compile($c_prog, ccflags=>$ccflags);
    if ($result) {
	print "yes\n";
	return " $ccflags";
    }
    print "no\n";
    return '';
	
}

my %gsl_pkgcfg = ExtUtils::PkgConfig->find ('gsl');

use constant MIN_GSL_VERSION => "1.10";
my $gv = $gsl_pkgcfg{'modversion'};

if (defined $gv) {
  if ($gv =~ m{\A(\d+(?:\.\d+)+)}) {
    my @current= split /\./, $1;
    my @min= split /\./, MIN_GSL_VERSION;
    unless ($current[0] >= $min[0] && $current[1] >= $min[1]) {
	    printf "
*** 
*** You need to have gsl %s or greater installed. (You have $gv).
*** Get gsl at http://www.gnu.org/software/gsl
", MIN_GSL_VERSION;
	    exit 1;
	} else {
	    print "Good, I found gsl version $gv installed.\n";
	    
	}
    } else {
	print "
*** 
*** Can't parse gsl version $gv.
*** Will continue and keep my fingers crossed for luck.
";
    }
} else {
    print "
*** 
*** Can't find gsl configuration info. Is gsl installed?
*** Get gsl at http://www.gnu.org/software/gsl
";
    exit 1;
}

print "Checking for SWIG...";
my @swig_version = `swig -version 2>&1`;
my $swig_installed = 0;
if ($?) {
    my $errno = $? >> 8;
    print "
*** I don't see SWIG installed. I'll use the SWIG-generated file
*** that comes with the distribution. If you want SWIG, get it
*** from http://www.swig.org
"; 
    print "*** Output was:
	@swig_version
" if @swig_version;
} else {
    $swig_installed = 1;
    print "ok\n";
}

my $ccflags = $gsl_pkgcfg{cflags};

## Swig produces a number of GCC warnings. Turn them off if we can.
$ccflags .= try_cflags("-Wno-strict-aliasing");
$ccflags .= try_cflags("-Wno-unused-function");
$ccflags .= try_cflags("-Wno-unused-value");
$ccflags .= try_cflags("-Wno-unused-function");
$ccflags .= try_cflags("-Wno-unused-variable");

my $ldflags = "$gsl_pkgcfg{libs} -gsl";
my $swig_flags='-Wall';
if ('cygwin' eq $Config{osname} && 
    $Config{shrpenv} =~ m{\Aenv LD_RUN_PATH=(.*)\Z} ) {
    $ldflags .= " -L$1 -lperl";
    # Should we check the 32-ness?
    $swig_flags = '-DNEED_LONG';
} elsif ('darwin' eq $Config{osname}) {
    $ldflags .= " -bundle -flat_namespace";
}

my $class = Module::Build->subclass( code => $code );

my $builder = $class->new( 
    module_name         => 'Math::GSL',
    add_to_cleanup      => [ q{*.core Math-GSL-* tmp* *_wrap.c *.pm pod2ht*.tmp _build *.so} ],
    create_makefile_pl  => 'passthrough',
    dist_abstract       => 'Interface to the GNU Scientific Library using SWIG',
    dist_author         => 'Jonathan Leto <jonathan@leto.net>',
    dist_version_from   => 'lib/Math/GSL.pm',
    include_dirs	    => q{},
    extra_linker_flags  => '-shared -I./lib -I../lib -I/usr/local/include/ ' . $ldflags,
    extra_compiler_flags=> q{-shared -Wall -fpic -Dbool=char -I/usr/local/include/ } . $ccflags,
    swig_flags          => $swig_flags, 
    swig_installed      => $swig_installed,
    license             => 'gpl',
    requires => {
	    'ExtUtils::PkgConfig'   =>  '1.03',
        'Scalar::Util'          =>       0,
        'Test::More'            =>       0,
        'Test::Class'           =>       0,
        version                 =>       0,
    	perl 			        => '5.8.6',
    },
    sign                  => 1,
    swig_source           => [  
                                map { [ "$_.i" ] } 
                                qw/ 
                                    CDF Complex Const Deriv 
                                    Errno Fit Machine Poly PowInt
                                    Randist RNG SF Types
                                  / 
                             ],
);

$builder->add_build_element('swig');
$builder->create_build_script();
