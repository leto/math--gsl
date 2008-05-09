package Math::GSL::RNG::Test;
use base q{Test::Class};
use Test::More;
use Math::GSL::RNG qw/:all/; 
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

sub GSL_RNG_TYPE_DEFAULT : Tests(7) {
    my $self = shift;
    my $seed = 42;

    my $type = Math::GSL::RNG::gsl_rng_type->new;
    isa_ok( $type, 'Math::GSL::RNG::gsl_rng_type', 'gsl_rng_type' );

    my $rng = gsl_rng_alloc($gsl_rng_default);
    isa_ok( $rng, 'Math::GSL::RNG', 'gsl_rng_alloc' );

    eval { gsl_rng_set($rng, $seed) };
    isa_ok( $rng, 'Math::GSL::RNG', 'gsl_rng_set' );
    ok( ! $@, 'gsl_rng_set' );

    my $rand = gsl_rng_get($rng);
    ok( defined $rand && $rand == 1608637542, 'gsl_rng_get' );

    my $rng2 = gsl_rng_alloc($gsl_rng_default);
    eval { gsl_rng_memcpy($rng2, $rng) };
    ok ( ! $@, 'gsl_rng_memcpy' );

    eval { Math::GSL::RNG::gsl_rng_free($rng) };
    ok( ! $@, 'gsl_rng_free' );
}

1;
