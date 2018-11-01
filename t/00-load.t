use Test::More;
use Config;
use File::Spec::Functions;
use lib 'inc';
use Ver2Func;
use strict;
use warnings;

my $gsl_version;
BEGIN {
    use_ok( 'Math::GSL', qw/gsl_version/ );

    $gsl_version = gsl_version();
    map { use_ok("Math::GSL::$_") } Ver2Func->new( $gsl_version )->subsystems;
}

my $arch        = $Config{archname};
diag( "Testing Math::GSL $Math::GSL::VERSION with GSL $gsl_version on $arch, Perl ($^X) $]" );

done_testing;
