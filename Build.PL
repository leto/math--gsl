#!/usr/bin/perl -w
# This has been heavily modified from the Device::Cdio Build.PL 
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
use lib 'inc';
use GSLBuilder;
use File::Spec::Functions qw/:ALL/;

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
*** DO NOT PANIC: this just means that you may get some innocuous
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

my $path_system = File::Spec->catfile('swig', 'system.i');
open my $fh, ">", "$path_system" or die "Could not create system.i : $!";

if (defined $gv) {
  if ($gv =~ m{\A(\d+(?:\.\d+)+)}) {
    my @current= split /\./, $1;
    print $fh "#define GSL_MAJOR_VERSION $current[0]\n";
    print $fh "#define GSL_MINOR_VERSION $current[1]\n";

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

close $fh;

my $ccflags = $gsl_pkgcfg{cflags};
# In case GSL in installed in the system-wide directory, $ccflags is
# empty (because pkg-config remove -I/usr/include), but swig needs it

my $swig_flags = '';
if ($ccflags =~ /^\s*$/ ) {
    $swig_flags =' -I/usr/include';
}

## Swig produces a number of GCC warnings. Turn them off if we can.
$ccflags .= try_cflags("-Wall");
#$ccflags .= try_cflags("-Wno-strict-aliasing");
$ccflags .= try_cflags("-Wno-unused-function");
$ccflags .= try_cflags("-Wno-unused-value");
$ccflags .= try_cflags("-Wno-unused-function");
$ccflags .= try_cflags("-Wno-unused-variable");
$ccflags .= try_cflags("-g");


my $ldflags    = "$gsl_pkgcfg{libs} -gsl";
$swig_flags = "$gsl_pkgcfg{cflags} $swig_flags";

if ( $^O eq 'cygwin'  && $Config{shrpenv} =~ m{\Aenv LD_RUN_PATH=(.*)\Z} ) {
    $ldflags .= " -L$1 -lperl";
    # Should we check the 32-ness?
    $swig_flags = '-DNEED_LONG';
} elsif ( $^O eq 'darwin' ) {
    $ldflags .= ' -bundle -flat_namespace ';
}

if ($Config{archname} =~ /x86_64|amd64/ ) {
    $ldflags .= ' -fPIC  -fno-omit-frame-pointer ';
    $ccflags .= ' -fPIC  -fno-omit-frame-pointer ';
}

my @Subsystems = grep { ! /^Test$/ } GSLBuilder::subsystems;

# BSplines appeared in 1.9
if ($current_minor_version < 9 ) {
   @Subsystems = grep { ! /BSpline/ } @Subsystems;
}
my $cleanup = qq{
                 xs/*_wrap.c core *.core swig/system.i
                 swig/*.o Makefile Math-GSL-* tmp* pod2ht*.tmp _build 
                 lib/Math/GSL/[A-z]+/* blib *.so *.orig 
                 } . join " ", map { catfile( (qw( lib Math GSL ), "$_.pm") ) } @Subsystems;

my $builder = GSLBuilder->new( 
    module_name         => 'Math::GSL',
    add_to_cleanup      => [ $cleanup ],
    create_makefile_pl  => 'passthrough',
    dist_abstract       => 'Interface to the GNU Scientific Library using SWIG',
    dist_author         => 'Jonathan Leto <jonathan@leto.net>',
    dist_version_from   => 'lib/Math/GSL.pm',
    include_dirs	    => [],
    extra_linker_flags  => '-shared ' . $ldflags,
    extra_compiler_flags=> "$ccflags " . ($ENV{CC_FLAGS}||''),
    swig_flags          => $swig_flags, 
    license             => 'gpl',
    requires => {
        'ExtUtils::PkgConfig'   => '1.03',
        'Scalar::Util'          =>       0,
        'Test::More'            =>       0,
        'Test::Exception'       =>    0.21,
        'Test::Class'           =>    0.12,
        version                 =>       0,
        perl                    =>  '5.8.0',
    },
    sign                  => 0,
    configure_requires => {
        'ExtUtils::PkgConfig' => '1.03',
    },
    swig_source           => [  
                                map { [ "swig/$_.i", "pod/$_.pod" ] } @Subsystems ,
                             ],
);
$builder->add_build_element('swig');
$builder->create_build_script();
print "Have a great day!\n";
