package Math::GSL::Interp::Test;
use base q{Test::Class};
use Test::More;
use Math::GSL::Interp qw/:all/;
use Math::GSL::Errno qw/:all/;
use Math::GSL qw/:all/;
use Data::Dumper;
use strict;

sub make_fixture : Test(setup) {
}

sub teardown : Test(teardown) {
}

sub GSL_INTERP_ALLOC : Tests {
 my $I = gsl_interp_alloc($gsl_interp_linear, 2);
 isa_ok($I, 'Math::GSL::Interp');
}

1;
