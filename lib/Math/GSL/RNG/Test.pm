package Math::GSL::RNG::Test;
use base q{Test::Class};
use Test::More;
use Math::GSL::RNG; 
use Math::GSL qw/is_similar/;
use Data::Dumper;
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

sub GSL_RNG_TYPE_DEFAULT : Tests(5) {
    my $self = shift;
    my $seed = 42;

    my $type = Math::GSL::RNG::gsl_rng_type->new;
    ok( $type->isa('Math::GSL::RNG::gsl_rng_type'), 'gsl_rng_type' );
    my $rng = Math::GSL::RNG::gsl_rng_alloc($Math::GSL::RNG::gsl_rng_default);
    ok( $rng->isa('Math::GSL::RNG'), 'gsl_rng_alloc' );

    Math::GSL::RNG::gsl_rng_set($rng, $seed);
    ok( $rng->isa('Math::GSL::RNG'), 'gsl_rng_set' );
    ok( ! $@, 'gsl_rng_set' );

    my $rand = Math::GSL::RNG::gsl_rng_get($rng);
    ok( defined $rand && $rand == 1608637542, 'gsl_rng_get' );
}

1;
