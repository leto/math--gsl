package Math::GSL::ODEIV::Test;
use strict;
use base q{Test::Class};
use Test::More tests => 4;
use Math::GSL        qw/:all/;
use Math::GSL::ODEIV qw/:all/;
use Math::GSL::Errno qw/:all/;
use Math::GSL::Test  qw/:all/;
use Data::Dumper;

BEGIN { gsl_set_error_handler_off(); }

sub make_fixture : Test(setup) {
    my $self = shift;
}

sub teardown : Test(teardown) {
}

sub GSL_ODEIV_STEP_ALLOC : Tests {
    my $step = gsl_odeiv_step_alloc($gsl_odeiv_step_rk2, 3);
    isa_ok( $step, 'Math::GSL::ODEIV' ); 
}

sub GSL_ODEIV_EVOLVE_ALLOC : Tests {
    my $evolver = gsl_odeiv_evolve_alloc(2);
    isa_ok( $evolver, 'Math::GSL::ODEIV' );
}

sub NAME : Tests {
    my $s = gsl_odeiv_step_alloc($gsl_odeiv_step_rk2, 3);
    my $name = gsl_odeiv_step_name ($s);
    ok($name eq "rk2");
}

sub GSL_ODEIV_CONTROL_ALLOC : Tests {
    local $TODO = "need a way to create a gsl_odeiv_control_type struct";
    my $control;

    ok( defined $gsl_odeiv_control_standard,'standard control type exists');
    # This will blowup with an undef control type
    if (defined $gsl_odeiv_control_standard ){
        $control = gsl_odeiv_control_alloc($gsl_odeiv_control_standard);
        isa_ok( $control, 'Math::GSL::ODEIV' );
    }
}
Test::Class->runtests;
