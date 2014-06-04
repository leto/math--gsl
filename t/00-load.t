use Test::More tests => 53;
use Config;
use File::Spec::Functions;
use lib 'inc';
use GSLBuilder;
use strict;
use warnings;


BEGIN {
    use_ok( 'Math::GSL', qw/gsl_version/ );
    map { use_ok("Math::GSL::$_") } GSLBuilder::subsystems();
}

my $arch        = $Config{archname};
my $gsl_version = gsl_version();
diag( "Testing Math::GSL $Math::GSL::VERSION with GSL $gsl_version on $arch, Perl ($^X) $]" );
