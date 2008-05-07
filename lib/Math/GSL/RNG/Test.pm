package Math::GSL::RNG::Test;
use base q{Test::Class};
use Test::More;
use Math::GSL::RNG; 
use Math::GSL qw/is_similar/;
use strict;

sub make_fixture : Test(setup) {
    my $self = shift;
    $self->{gsl_rng} = Math::GSL::RNG::gsl_rng->new;
}

sub teardown : Test(teardown) {
}

sub GSL_RNG_NEW : Test {
    my $self = shift;
    my $x = $self->{gsl_rng};
    ok( defined $x && $x->isa('Math::GSL::RNG::gsl_rng'), 'gsl_rng->new' );
}

1;
