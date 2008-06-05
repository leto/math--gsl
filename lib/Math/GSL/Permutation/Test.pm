package Math::GSL::Permutation::Test;
use base q{Test::Class};
use Test::More;
use Math::GSL::Permutation qw/:all/;
use Math::GSL qw/:all/;
use Data::Dumper;
use strict;

sub make_fixture : Test(setup) {
    my $self = shift;
    $self->{gsl_permutation} = Math::GSL::Complex::gsl_complex->new(6);
}

sub teardown : Test(teardown) {
}


