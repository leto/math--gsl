package Math::GSL::Monte::Test;
use base q{Test::Class};
use Test::More tests => 15;
use Math::GSL::Monte qw/:all/;
use Math::GSL::Errno qw/:all/;
use Math::GSL::RNG   qw/:all/;
use Math::GSL::Test  qw/:all/;
use Data::Dumper;
use strict;

BEGIN { gsl_set_error_handler_off() }

sub make_fixture : Test(setup) {
    my $self = shift;
    my $j          = 1 + int(rand(20));
    $self->{miser} = gsl_monte_miser_alloc($j);
    $self->{vegas} = gsl_monte_vegas_alloc($j);
    $self->{plain} = gsl_monte_plain_alloc($j);
    $self->{dim}   = $j;
}

sub teardown : Test(teardown) {
    my $self = shift;
    gsl_monte_miser_free($self->{miser});
    gsl_monte_plain_free($self->{plain});
    gsl_monte_vegas_free($self->{vegas});
}

sub TEST_INIT  : Tests(3) {
    my $self = shift;
    ok_status( gsl_monte_plain_init($self->{plain}), $GSL_SUCCESS, 'plain' );
    ok_status( gsl_monte_vegas_init($self->{vegas}), $GSL_SUCCESS, 'vegas' );
    ok_status( gsl_monte_miser_init($self->{miser}), $GSL_SUCCESS, 'miser' );
}

sub TEST_MONTE_VEGAS_STATE : Tests {
    my $state = Math::GSL::Monte::gsl_monte_vegas_state->new;
    isa_ok($state, 'Math::GSL::Monte::gsl_monte_vegas_state');
}

sub TEST_MONTE_VEGAS_STATE_DIM : Tests {
    my $state = Math::GSL::Monte::gsl_monte_vegas_state->new;
    $state->swig_dim_set(1);
    cmp_ok( $state->swig_dim_get , '==', 1, 'swig_dim_set' );
}

sub TEST_MONTE_PLAIN_INTEGRATE : Tests {

    my $state = gsl_monte_plain_alloc(1);
    my $rng   = Math::GSL::RNG->new;
    my ($status, @stuff) =  gsl_monte_plain_integrate( sub { exp(-$_[0] ** 2) },
        [ -1 ], [ 2 ], 1, 1000, $rng->raw, $state);
    ok_status($status);
    #warn Dumper [ @stuff ];

}
sub TEST_MONTE_VEGAS_INTEGRATE : Tests(3) {
    my $self = shift;
    my $state = gsl_monte_vegas_alloc(1);
    my $rng   = Math::GSL::RNG->new;
    my ($status, @stuff);
    ($status, @stuff) =  gsl_monte_vegas_integrate( sub { $_[0] ** 2 },
        [ 0 ], [ 1 ], 1, 100, $rng->raw, $state);

    ok( $state->{dim} == 1, 'dim = 1');
    #warn Dumper [ @stuff ];
    #warn Dumper [ $status, $state, $state->{result} ];
    ok_status($status);
    local $TODO = 'result of Monte carlo needs fixin';
    ok_similar( [ 1/3 ] ,  [ $state->{result} ] );

}
sub TEST_ALLOC : Tests(6) {
    my $self = shift;
    isa_ok($self->{miser},'Math::GSL::Monte');
    cmp_ok($self->{miser}->{dim},'==',$self->{dim});

    isa_ok($self->{vegas},'Math::GSL::Monte');
    cmp_ok($self->{vegas}->{dim},'==',$self->{dim});

    isa_ok($self->{plain},'Math::GSL::Monte');
    cmp_ok($self->{plain}->{dim},'==',$self->{dim});
}
Test::Class->runtests;
