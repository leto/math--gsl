package Math::GSL::RNG::Test;
use base q{Test::Class};
use Test::More;
use Math::GSL::RNG qw/:all/; 
use Math::GSL qw/is_similar/;
use Data::Dumper;
use strict;

sub make_fixture : Test(setup) {
    my $self = shift;
    $self->{rng} = gsl_rng_alloc($gsl_rng_default);
    gsl_rng_set( $self->{rng}, 1 + 9*(int rand) );
}

sub teardown : Test(teardown) {
    my $self = shift;

    gsl_rng_free($self->{rng});
}

sub GSL_RNG_NEW : Tests {
    my $self = shift;
    my $x = $self->{rng};
    isa_ok( $x, 'Math::GSL::RNG', 'gsl_rng->new' );
}

sub GSL_RNG_TYPE : Tests {
    my $self = shift;
    my $type = Math::GSL::RNG::gsl_rng_type->new;
    isa_ok( $type, 'Math::GSL::RNG::gsl_rng_type', 'gsl_rng_type' );
}

sub GSL_RNG_ALLOC : Tests { 
    for my $rngtype ( $gsl_rng_random256_bsd, $gsl_rng_knuthran,
                      $gsl_rng_transputer, $gsl_rng_knuthran2002) {
        my $rng;
        eval { $rng = gsl_rng_alloc($rngtype) };
        isa_ok( $rng, 'Math::GSL::RNG');
        ok( !$@ );
    }
}

sub GSL_RNG_DEFAULT : Tests {
    my $self = shift;
    my $seed = 42;

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
