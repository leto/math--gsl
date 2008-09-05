#!/usr/bin/perl -w

# This script has been heavily modified from the Device::Cdio Build.PL 
# Jonathan Leto <jonathan@leto.net>
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
use Config;
use Data::Dumper;
use Module::Build;

BEGIN {
    eval { require ExtUtils::PkgConfig };
    if ($@) {
        print "\nI see that you are a CPANTester, you really should install ExtUtils::PkgConfig !\n"
            if $ENV{AUTOMATED_TESTING};
        print <<EXIT;
ExtUtils::PkgConfig is currently needed to find GSL for the compilation of this module.
It may be bundled with Math::GSL in the future.
EXIT
        exit 0;
    }
}

my $code = <<'EOC';
use Config;
use File::Copy;
use File::Spec::Functions qw/:ALL/;

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

      # .swg -> .c
      $self->add_to_cleanup($c_file);
      
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
  
  # .c -> .o
  my $obj_file = $self->compile_c($c_file);
  $self->add_to_cleanup($obj_file);

  # The .so files don't go in blib/lib/, they go in blib/arch/auto/.
  # Unfortunately we have to pre-compute the whole path.
  my $archdir;
  {
    my @dirs = splitdir($file_base);
    $archdir = catdir($self->blib,'arch', @dirs[1..$#dirs]);
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
   
    my $blib_lib =  catfile(qw/blib lib/);

    mkdir catfile($blib_lib, qw/Math GSL/);
    my $outdir  = catfile($blib_lib, qw/Math GSL/);
    my $pm_file = "${file_base}.pm";
    my $from    = catfile($blib_lib, qw/Math GSL/, $pm_file);
    my $to      = catfile(qw/lib Math GSL/,$pm_file);
    chmod 0644, $from, $to;

    $self->do_system(@swig, '-o', $c_file,
                     '-outdir', $outdir, 
		             '-perl5', @swig_flags, $file)
	or die "error building $c_file file from '$file'";
    

    print "Copying from: $from, to: $to; it makes the CPAN indexer happy.\n";
    copy($from,$to);
    return $c_file;
}
sub is_windows { $^O =~ /MSWin32/i }

# Windows fixes courtesy of <sisyphus@cpan.org>
sub link_c {
  my ($self, $to, $file_base, $obj_file) = @_;
  my ($cf, $p) = ($self->{config}, $self->{properties}); # For convenience

  my $lib_file = catfile($to, File::Basename::basename("$file_base.$Config{dlext}"));

  $self->add_to_cleanup($lib_file);
  my $objects = $p->{objects} || [];
  
  unless ($self->up_to_date([$obj_file, @$objects], $lib_file)) {
    my @linker_flags = $self->split_like_shell($p->{extra_linker_flags});

    push @linker_flags, $Config{archlib} . '/CORE/' . $Config{libperl} if is_windows();

    my @lddlflags = $self->split_like_shell($cf->{lddlflags}); 
    my @shrp = $self->split_like_shell($cf->{shrpenv});
    my @ld = $self->split_like_shell($cf->{ld}) || "gcc";

    # Strip binaries if we are compiling on windows
    push @ld, "-s" if (is_windows() && $Config{cc} eq 'gcc');

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
  my $obj_file = $file_base . $Config{_o};

  $self->add_to_cleanup($obj_file);
  return $obj_file if $self->up_to_date($file, $obj_file);


  $cf->{installarchlib} = $Config{archlib};

  my @include_dirs = @{$p->{include_dirs}} 
			? map {"-I$_"} (@{$p->{include_dirs}}, catdir($cf->{installarchlib}, 'CORE'))
			: map {"-I$_"} ( catdir($cf->{installarchlib}, 'CORE') ) ;

  my @extra_compiler_flags = $self->split_like_shell($p->{extra_compiler_flags});

  my @cccdlflags = $self->split_like_shell($cf->{cccdlflags});

  my @ccflags  = $self->split_like_shell($cf->{ccflags});
  push @ccflags, $self->split_like_shell($Config{cppflags});

  my @optimize = $self->split_like_shell($cf->{optimize});

  # Whoah! There seems to be a bug in gcc 4.1.0 and optimization
  # and swig. I'm not sure who's at fault. But for now the simplest
  # thing is to turn off all optimization. For the kinds of things that
  # SWIG does - do conversions between parameters and transfers calls
  # I doubt optimization makes much of a difference. But if it does,
  # it can be added back via @extra_compiler_flags.

  my @flags = (@include_dirs, @cccdlflags, '-c', @ccflags, @extra_compiler_flags, );
  
  my @cc = $self->split_like_shell($cf->{cc});
  @cc = "gcc" unless @cc;
  
  $self->do_system(@cc, @flags, '-o', $obj_file, $file)
    or die "error building $Config{_o} file from '$file'";

  return $obj_file;
}

EOC


sub try_compile {
    my ($c, %args) = @_;

    my $ok = 0;
    my $tmp = "tmp$$";
    local(*TMPC);

    my $obj_ext = $Config{_o} || ".o";
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

print "Checking for GSL..";
my %gsl_pkgcfg = ExtUtils::PkgConfig->find ('gsl');

my $MIN_GSL_VERSION = "1.8";
my $gv = $gsl_pkgcfg{'modversion'};
my $current_minor_version;

if (defined $gv) {
  if ($gv =~ m{\A(\d+(?:\.\d+)+)}) {
    my @current= split /\./, $1;
    my @min= split /\./, $MIN_GSL_VERSION;
    $current_minor_version = $current[1];
    unless ($current[0] >= $min[0] && $current[1] >= $min[1]) {
	    printf "
*** 
*** You need to have GSL %s or greater installed. (You have $gv).
*** Get GSL at http://www.gnu.org/software/gsl\n", $MIN_GSL_VERSION;
	    exit 1;
	} else {
	    print "Found GSL version $gv\n";
	    
	}
    } else {
	print "
*** 
*** Can't parse GSL version $gv.
*** Will continue and keep my fingers crossed for luck.
";
    }
} else {
    print "
*** 
*** Can't find GSL configuration info. Is GSL installed?
*** Get GSL at http://www.gnu.org/software/gsl
";
    exit 1;
}


my $ccflags = $gsl_pkgcfg{cflags};

## Swig produces a number of GCC warnings. Turn them off if we can.
$ccflags .= try_cflags("-Wno-strict-aliasing");
$ccflags .= try_cflags("-Wno-unused-function");
$ccflags .= try_cflags("-Wno-unused-value");
$ccflags .= try_cflags("-Wno-unused-function");
$ccflags .= try_cflags("-Wno-unused-variable");

my $ldflags = "$gsl_pkgcfg{libs} -gsl";
my $swig_flags='-Wall ' . $gsl_pkgcfg{cflags};

if ('cygwin' eq $Config{osname} && 
    $Config{shrpenv} =~ m{\Aenv LD_RUN_PATH=(.*)\Z} ) {
    $ldflags .= " -L$1 -lperl";
    # Should we check the 32-ness?
    $swig_flags = '-DNEED_LONG';
} elsif ('darwin' eq $Config{osname}) {
    $ldflags .= " -bundle -flat_namespace";
}

my $class = Module::Build->subclass( code => $code );
my @Subsystems = sort qw/
            BLAS         Diff          Machine    Statistics
            Eigen        Matrix        Poly       Wavelet2D
            BSpline      Errno         PowInt     Wavelet
            CBLAS        FFT           Min          
            CDF          Fit           QRNG
            Chebyshev    Monte         RNG
            Heapsort     Multifit      Randist      Sum
            Combination  Histogram     Multimin     Roots      
            Complex      Histogram2D   Multiroots   SF         
            Const        Siman         IEEEUtils    Sys
            Integration  NTuple        Sort                  
            DHT          Interp        ODEIV        Vector
            Deriv        Linalg        Permutation  Spline
/;

# BSplines appeared in 1.9
if ($current_minor_version < 9 ) {
   @Subsystems = grep { ! /BSpline/ } @Subsystems;
}
my $cleanup = qq{core *.core Makefile Math-GSL-* tmp* pod2ht*.tmp _build blib *.so *.orig };

my $builder = $class->new( 
    module_name         => 'Math::GSL',
    add_to_cleanup      => [ $cleanup ],
    create_makefile_pl  => 'passthrough',
    dist_abstract       => 'Interface to the GNU Scientific Library using SWIG',
    dist_author         => 'Jonathan Leto <jonathan@leto.net>',
    dist_version_from   => 'lib/Math/GSL.pm',
    include_dirs	    => q{},
    extra_linker_flags  => '-shared -I./lib -I../lib ' . $ldflags,
    extra_compiler_flags=> q{-shared -fpic } . $ccflags,
    swig_flags          => $swig_flags, 
    license             => 'gpl',
    requires => {
        'ExtUtils::PkgConfig'   =>  '1.03',
        'Scalar::Util'          =>       0,
        'Test::More'            =>       0,
        'Test::Exception'       =>    0.21,
        'Test::Class'           =>    0.12,
        version                 =>       0,
    	perl 			        =>  '5.8.0',
    },
    sign                  => 0,
    swig_source           => [  
                                map { [ "$_.i" ] } @Subsystems
                             ],
);
$builder->add_build_element('swig');
$builder->create_build_script();
print "Have a great day!\n";
