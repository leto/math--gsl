package Math::GSL::Spline::Test;
use base 'Test::Class';
use Test::More 'no_plan';
use Math::GSL qw/:all/;
use Math::GSL::Spline qw/:all/;
use Math::GSL::Errno qw/:all/;
use Math::GSL::Interp qw/:all/;
use Test::Exception;
use Data::Dumper;
use strict;
use warnings;

BEGIN{ gsl_set_error_handler_off() };

sub make_fixture : Test(setup) {
    my $self = shift;
    $self->{spline} = gsl_spline_alloc($gsl_interp_linear,100);
}

sub teardown : Test(teardown) {
}
sub TEST_FREE : Test {
    my $self = shift;
    gsl_spline_free($self->{spline});
    ok(!$@ && !$! && !$?,'gsl_spline_free');
}
sub TEST_MIN_SIZE : Test {
    my $self = shift;
    cmp_ok(2,'==',gsl_spline_min_size($self->{spline}),'min_size');
}
sub TEST_NAME : Test {
        my $self = shift;
        my $spline = $self->{spline};
        cmp_ok('linear', 'eq' , gsl_spline_name($spline));
}
sub TEST_ALLOC : Tests {
    isa_ok(gsl_spline_alloc($_,100), 'Math::GSL::Spline') for (
               $gsl_interp_linear,
               $gsl_interp_polynomial,
               $gsl_interp_cspline,
               $gsl_interp_cspline_periodic,
               $gsl_interp_akima,
               $gsl_interp_akima_periodic);
}


1;
