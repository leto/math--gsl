package Math::GSL::Sys::Test;
use base q{Test::Class};
use Test::More tests => 17;
use Math::GSL::Sys  qw/:all/;
use Math::GSL::Errno  qw/:all/;
use Math::GSL::Test qw/:all/;
use Data::Dumper;
use strict;

BEGIN { gsl_set_error_handler_off() }

sub make_fixture : Test(setup) {
}

sub teardown : Test(teardown) {
}

sub SANITY : Tests {
    ok( gsl_isnan(gsl_nan()), 'I like nan');
    ok(!gsl_isnan(0.0), '0 is a number');
    ok(!gsl_isnan(1.0), '1 is a number');
    ok(!gsl_isnan(-1.0), '-1 is a number');
    ok( gsl_isnan(gsl_log1p(-1)), 'ln(0)=nan');
    ok(!gsl_isnan(gsl_posinf()), 'posinf is a number');
    ok( gsl_isinf(gsl_posinf()),'posinf is inf' );
    ok( gsl_isinf(gsl_neginf()),'neginf is inf' );
    ok(!gsl_isinf(gsl_nan()),'nan is not inf' );
    ok( gsl_isinf($GSL_POSINF), 'GSL_POSINF' );
    ok( gsl_isinf($GSL_NEGINF), 'GSL_NEGINF' );
    ok( gsl_finite(0.0), '0 is finite' );
    ok( gsl_finite(1.0), '1 is finite' );
    ok( gsl_finite(-1.0), '-1 is finite' );
    ok(!gsl_finite(gsl_nan()), 'nan is not finite' );
    ok(!gsl_finite(gsl_posinf()),'posinf is not finite' );
    ok(!gsl_finite(gsl_neginf()),'neginf is not finite' );
}

Test::Class->runtests;
