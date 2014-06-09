#!/usr/bin/perl -w
# This has been heavily modified from the Device::Cdio Build.PL
# Jonathan "Duke" Leto <jonathan@leto.net>

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



our $MIN_GSL_VERSION = "1.11";

my $gsl_conf;

$gsl_conf = check_gsl_version();
$gsl_conf = check_gsl_version_pkgconfig() if not $gsl_conf;

my $ccflags = $gsl_conf->{gsl_cflags};
my $ldflags = $gsl_conf->{gsl_libs};

# In case GSL in installed in the system-wide directory, $ccflags is
# empty (because pkg-config remove -I/usr/include), but swig needs it

my $swig_flags = '';
$swig_flags = ' -I/usr/include' if $ccflags =~ /^\s*$/;

$ccflags .= " $Config{ccflags}"; # we need this for some Linuxes

## Swig produces a number of GCC warnings. Turn them off if we can.
$ccflags .= try_cflags("-Wall");
#$ccflags .= try_cflags("-Wno-strict-aliasing");
$ccflags .= try_cflags("-Wno-unused-function");
$ccflags .= try_cflags("-Wno-unused-value");
$ccflags .= try_cflags("-Wno-unused-function");
$ccflags .= try_cflags("-Wno-unused-variable");
$ccflags .= try_cflags("-g");

$swig_flags = "$gsl_conf->{gsl_cflags} $swig_flags";

if ( GSLBuilder::is_cygwin()  && $Config{shrpenv} =~ m{\Aenv LD_RUN_PATH=(.*)\Z} ) {
    $ldflags .= " -L$1 -lperl";
    # Should we check the 32-ness?
    $swig_flags = '-DNEED_LONG';
} elsif (GSLBuilder::is_darwin()) {
    $ldflags .= ' -bundle -flat_namespace ';
}

if ($Config{archname} =~ /x86_64|amd64/ ) {
    $ldflags .= ' -fPIC  -fno-omit-frame-pointer ';
    $ccflags .= ' -fPIC  -fno-omit-frame-pointer ';
}

my @Subsystems = grep { ! /^Test$/ } GSLBuilder::subsystems();

my $cleanup = qq{
                 xs/*_wrap*.c core *.core swig/system.i swig/renames.i
                 swig/*.o Makefile Math-GSL-* tmp* pod2ht*.tmp _build pm
                 lib/Math/GSL/[A-z]+/* blib *.so *.orig
                } . join " ", map { catfile( (qw/lib Math GSL/, "$_.pm") ) } @Subsystems;


$ldflags = '-shared ' . $ldflags unless GSLBuilder::is_darwin();

my $ver2func = do(catfile(qw/inc ver2func/));

unless (GSLBuilder::is_release()) {
    my $swig_ver = swig_version();
    if ((split(/\./, $swig_ver))[0] < 2) {
        print "
***
*** You need to have SWIG 2.X or greater installed. (You have $swig_ver).
*** Get SWIG at http://www.swig.org/\n";
        exit 0;
    }
}

$ccflags = "$ccflags " . ($ENV{CC_FLAGS}||''),

print "\nConfigured with flags...\n";
print "  linker: $ldflags\n";
print "  compiler: $ccflags\n";

print "  swig: $swig_flags\n" unless GSLBuilder::is_release();

print "\n";

my $builder = GSLBuilder->new(
    module_name         => 'Math::GSL',
    add_to_cleanup      => [ $cleanup ],
    dist_abstract       => 'Interface to the GNU Scientific Library using SWIG',
    dist_author         => 'Jonathan Leto <jonathan@leto.net>',
    dist_version_from   => catfile(qw/lib Math GSL.pm/),
    include_dirs	    => [],
    extra_linker_flags  => $ldflags,
    extra_compiler_flags=> $ccflags,
    swig_flags          => $swig_flags,
    license             => 'gpl',
    meta_merge     => {
        resources => {
            repository  => 'http://github.com/leto/math--gsl/tree/master'
        },
    },
    build_requires => {
        'Test::Most'      =>    '0.31',
        'Test::Exception' =>    '0.21',
        'Test::Class'     =>    '0.12',
    },
    requires => {
        'PkgConfig'       => '0.07720',
        'Scalar::Util'    => 0,
        version           => '0.77',
        perl              => '5.8.0',
    },
    sign                  => 0,
    configure_requires => {
        'PkgConfig'       => '0.07720',
        'Module::Build'   => '0.38',
    },
    swig_source           => [
                                map { [ catfile("swig", "$_.i"), [ catfile("pod", "$_.pod")] ] } @Subsystems ,
                             ],
    ver2func => $ver2func,
    current_version => $gsl_conf->{gsl_version},
);

$builder->add_build_element('swig');

$builder->create_build_script();

print "Have a great day!\n";


### aux functions

sub swig_version {
    my $swig = GSLBuilder::swig_binary_name();

    my $cmd = "$swig -version";
    my $out = `$cmd`;

    if ($?) {
        die "Can't run [$cmd] : $out";
    }
    if ($out =~ /swig\s+version\s+([\d\.]+)\n/i) {
        return $1;
    } else {
        die "Can't parse SWIG version from this output:\n$out";
    }
}

sub modify_env {
    $ENV{PKG_CONFIG_PATH} ||= '';

    # TODO: What about windows and darwin?
    my @guess = qw(/usr/pkgconfig /usr/lib/pkgconfig /usr/local/lib/pkgconfig
    	           /usr/local/pkgconfig /usr/libdata/pkgconfig
    	           /usr/local/libdata/pkgconfig /opt/pkgconfig);

    $ENV{PKG_CONFIG_PATH} = join(":", @guess) . $ENV{PKG_CONFIG_PATH};
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

sub try_cflags {
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

sub check_gsl_version_pkgconfig {

    eval { require PkgConfig };
    if ($@) {
        print "\nI see that you are a CPANTester, you really should install PkgConfig !\n"
            if $ENV{AUTOMATED_TESTING};
        print "\nPkgConfig is currently needed to find GSL for the compilation of this module.\n";
        exit 0;
    }

	modify_env();
	print "\nAsking PkgConfig with ENV{PKG_CONFIG_PATH}=" . ($ENV{PKG_CONFIG_PATH} || '') . "\n\n";
	my $gsl_pkgcfg = PkgConfig->find ('gsl');

	if ($gsl_pkgcfg->errmsg) {
		my $errmsg = $gsl_pkgcfg->errmsg;
		print "
***
*** PkgConfig failed with error message: $errmsg
*** Probably you need to install GSL?
*** Get GSL at http://www.gnu.org/software/gsl\n";
		exit 0;
	}

	my $gsl_version = $gsl_pkgcfg->pkg_version;
	if (GSLBuilder::cmp_versions($gsl_version, $MIN_GSL_VERSION) == -1) {
	            printf "
*** 
*** You need to have GSL %s or greater installed. (You have $gsl_version).
*** Get GSL at http://www.gnu.org/software/gsl\n", $MIN_GSL_VERSION;
	            exit 0;
	        }

	return {
		gsl_version => $gsl_version,
		gsl_prefix  => $gsl_pkgcfg->get_var("prefix"),
		gsl_libs    => join (" ", $gsl_pkgcfg->get_ldflags),
		gsl_cflags  => join (" ", $gsl_pkgcfg->get_cflags),
	};
}

sub check_gsl_version {

	print "\nChecking for GSL using gsl-config\n";

	chomp(my $gsl_version = qx{gsl-config --version});
	chomp(my $gsl_prefix  = qx{gsl-config --prefix});
	chomp(my $gsl_cflags  = qx{gsl-config --cflags});
	chomp(my $gsl_libs    = qx{gsl-config --libs});

	my $path_system = catfile(qw/swig system.i/);

	open my $fh, ">", "$path_system" or die "Could not create $path_system : $!";

	my $current_version;

	if (defined $gsl_version) {
	    if ($gsl_version =~ m{\A(\d+(?:\.\d+)+)}) {
	        $current_version = $1;
	        my @current = split /\./, $current_version;
	        print $fh "#define GSL_MAJOR_VERSION $current[0]\n";
	        print $fh "#define GSL_MINOR_VERSION $current[1]\n";

	        if (GSLBuilder::cmp_versions($current_version, $MIN_GSL_VERSION) == -1) {
	            printf "
*** 
*** You need to have GSL %s or greater installed. (You have $gsl_version).
*** Get GSL at http://www.gnu.org/software/gsl\n", $MIN_GSL_VERSION;
	            exit 0;
	        } else {
	            print "Found GSL $gsl_version (via gsl-config) installed in $gsl_prefix, CFLAGS=$gsl_cflags, $gsl_libs\n";
	            return {
	            	gsl_version => $current_version,
	            	gsl_prefix  => $gsl_prefix,
	            	gsl_libs    => $gsl_libs,
	            	gsl_cflags  => $gsl_cflags,
	            };
	        }
	    } else {
	        print "
*** 
*** Can't parse GSL version $gsl_version.
*** Trying with PkgConfig.
	";
		return undef;
	    }
	} else {
	    print "
*** 
*** Can't find GSL with gsl-config. 
*** Trying with PkgConfig.
	";
	    return undef;
	}
	close $fh or die "Could not close $path_system : $!";
}