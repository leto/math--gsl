use Test::More;
use Config;
use File::Spec::Functions;
use lib 'inc';
use GSLBuilder;
use strict;
use warnings;


BEGIN {
    use_ok( 'Math::GSL', qw/gsl_version/ );
    map { use_ok("Math::GSL::$_") } GSLBuilder::subsystems();
    my $major = $Math::GSL::Version::GSL_MAJOR_VERSION;
    my $minor = $Math::GSL::Version::GSL_MINOR_VERSION;
    if ($major >= 2 && $minor >= 1) {
        use_ok("Math::GSL::Multilarge");
    }
    if ($major >= 2) {
        use_ok("Math::GSL::Multifit");
    }
}

my $arch        = $Config{archname};
my $gsl_version = gsl_version();
diag( "Testing Math::GSL $Math::GSL::VERSION with GSL $gsl_version on $arch, Perl ($^X) $]" );

done_testing;
