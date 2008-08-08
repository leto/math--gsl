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
 my $control_type;
 local $TODO = "need a way to create a gsl_odeiv_control_type struct";
# my $control = gsl_odeiv_control_alloc($control_type);
# isa_ok( $control, 'Math::GSL::ODEIV' );
}
1;
