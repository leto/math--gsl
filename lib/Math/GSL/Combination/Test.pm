package Math::GSL::Combination::Test;
use base q{Test::Class};
use Test::More;
use Math::GSL::Combination qw/:all/;
use Math::GSL qw/:all/;
use strict;

sub make_fixture : Test(setup) {
}

sub teardown : Test(teardown) {
}

sub GSL_COMBINATION_ALLOC : Tests { 
    my $c = gsl_combination_alloc(2,2);
    isa_ok($c, 'Math::GSL::Combination');
}

1;
