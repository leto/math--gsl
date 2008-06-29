package Math::GSL::Histogram::Test;
use base q{Test::Class};
use Test::More;
use Math::GSL qw/:all/;
use Math::GSL::Histogram qw/:all/;
use Math::GSL::Errno qw/:all/;
use Data::Dumper;
use strict;

BEGIN{ gsl_set_error_handler_off(); }

sub make_fixture : Test(setup) {
}
sub teardown : Test(teardown) {
}

sub ALLOC_FREE : Tests {
    my $H = gsl_histogram_alloc( 100 );
    isa_ok($H, 'Math::GSL::Histogram' );
    gsl_histogram_free($H);
    ok(!$@, 'gsl_histogram_free');
}

42;
