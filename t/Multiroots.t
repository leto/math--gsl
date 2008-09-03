package Math::GSL::Multiroots::Test;
use Math::GSL::Test qw/:all/;
use base q{Test::Class};
use Test::More;
use Math::GSL::Multiroots qw/:all/;
use Math::GSL::Errno qw/:all/;
use Math::GSL qw/:all/;
use Data::Dumper;
use strict;

BEGIN { gsl_set_error_handler_off(); }

sub make_fixture : Test(setup) {
    my $self = shift;
    $self->{fdfsolver} = gsl_multiroot_fdfsolver_alloc($gsl_multiroot_fdfsolver_newton,2);
    $self->{fsolver} = gsl_multiroot_fsolver_alloc($gsl_multiroot_fsolver_broyden,2);
}

sub teardown : Test(teardown) {
    my $self = shift;
    gsl_multiroot_fsolver_free($self->{fsolver});
    gsl_multiroot_fdfsolver_free($self->{fdfsolver});
}

sub TEST_FSOLVER_ALLOC : Tests {
    my $self = shift;
    isa_ok($self->{fsolver}, 'Math::GSL::Multiroots');
}

sub TEST_FSOLVER_SET : Tests {
    local $TODO = 'need gsl_multiroot_function typemap';
    my $self = shift;
    my $vector = Math::GSL::Vector->new(2);
    ok_status(gsl_multiroot_fsolver_set($self->{fsolver}, 
            sub { die 'This will surely fail' },
            $vector->raw,
    ));
}

sub TEST_FDFSOLVER_ALLOC : Tests {
    my $self = shift;
    isa_ok($self->{fdfsolver}, 'Math::GSL::Multiroots');
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
Test::Class->runtests;
