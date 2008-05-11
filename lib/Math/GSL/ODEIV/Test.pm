package Math::GSL::ODEIV::Test;
use base q{Test::Class};
use Test::More;
use Math::GSL::ODEIV qw/:all/;
use Math::GSL qw/is_similar/;
use Data::Dumper;
use strict;

sub make_fixture : Test(setup) {
    my $self = shift;
}

sub teardown : Test(teardown) {
}

sub GSL_ODEIV_EVOLVE_ALLOC : Tests {
    my $evolver = gsl_odeiv_evolve_alloc(2);
    isa_ok( $evolver, 'Math::GSL::ODEIV' );
}


1;
