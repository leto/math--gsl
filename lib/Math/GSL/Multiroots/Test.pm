package Math::GSL::Multiroots::Test;
use base q{Test::Class};
use Test::More;
use Math::GSL::Multiroots qw/:all/;
use Math::GSL::Errno qw/:all/;
use Math::GSL qw/:all/;
use strict;

sub make_fixture : Test(setup) {
    my $self = shift;
}

sub teardown : Test(teardown) {
    my $self = shift;
}

sub TEST_FSOLVER_TYPES : Tests {
    my $self = shift;
    isa_ok( $_, 'Math::GSL::Multiroots') 
        for ($gsl_multiroot_fsolver_dnewton,
            $gsl_multiroot_fsolver_broyden,
            $gsl_multiroot_fsolver_hybrid,
            $gsl_multiroot_fsolver_hybrids,
            $gsl_multiroot_fdfsolver_newton,
            $gsl_multiroot_fdfsolver_gnewton,
            $gsl_multiroot_fdfsolver_hybridj,
            $gsl_multiroot_fdfsolver_hybridsj
        );
}
1;
