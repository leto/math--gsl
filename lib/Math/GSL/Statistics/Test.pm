package Math::GSL::Statistics::Test;
use base q{Test::Class};
use Test::More;
use Math::GSL::Statistics qw/:all/;
use Math::GSL qw/:all/;
use strict;

sub make_fixture : Test(setup) {
}

sub teardown : Test(teardown) {
}

sub GSL_STATS_MEAN : Tests {
 my $x = gsl_stats_mean([2,3,4, 5], 1, 4);
 ok ($x eq 3.5);
}

sub GSL_STATS_VARIANCE : Tests {
 my $x = gsl_stats_variance([2,3,4, 5], 1, 4);
 ok ($x eq 5/3);
}

1;
