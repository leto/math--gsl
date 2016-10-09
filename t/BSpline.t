package Math::GSL::BSpline::Test;
use Math::GSL::Test qw/:all/;
use base q{Test::Class};
use Test::Most;
use Math::GSL          qw/:all/;
use Math::GSL::BSpline qw/:all/;
use Math::GSL::Errno   qw/:all/;
use Data::Dumper;
use strict;
use warnings;

BEGIN { gsl_set_error_handler_off() }

sub make_fixture : Test(setup) {
}
sub teardown : Test(teardown) {
}


sub BASIC : Tests {
    my $bspline = gsl_bspline_alloc(4,10);
    ok(defined $bspline, 'gsl_bspline_alloc');

    my $status  = gsl_bspline_knots_uniform(0,5, $bspline);
    ok_status($status);

    my $ncoeffs = gsl_bspline_ncoeffs($bspline);
    cmp_ok($ncoeffs, '==', 12, 'ncoeffs');

    lives_ok {
        gsl_bspline_free($bspline);
    };
}

Test::Class->runtests;
