package Math::GSL::Permutation::Test;
use base q{Test::Class};
use Test::More;
use Math::GSL::Permutation qw/:all/;
use Math::GSL qw/:all/;
use Data::Dumper;
use strict;

sub make_fixture : Test(setup) {
    my $self = shift;
    $self = gsl_permutation_alloc(6);
}

sub teardown : Test(teardown) {
}

sub GSL_PERMUTATION_ALLOC : Tests {
    my $p = gsl_permutation_alloc(6);
    isa_ok($p, 'Math::GSL::Permutation');
}

1;
