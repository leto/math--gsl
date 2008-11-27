package Math::GSL::Poly::Test;
use Math::GSL::Test qw/:all/;
use base q{Test::Class};
use Test::More tests => 1;
use Math::GSL qw/:all/;
use Math::GSL::BSpline qw/:all/;
use Math::GSL::Errno qw/:all/;
use Data::Dumper;
use strict;


sub make_fixture : Test(setup) {
}
sub teardown : Test(teardown) {
}

sub ALLOC : Tests {
 my $B = gsl_bspline_alloc(2,5);
 isa_ok($B, 'Math::GSL::BSpline');
}

Test::Class->runtests;
