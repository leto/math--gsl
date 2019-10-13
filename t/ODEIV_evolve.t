package Math::GSL::ODEIV::Test;
use strict;
use base q{Test::Class};
use Test::Exception;
use Test::More;
use Math::GSL        qw/:all/;
use Math::GSL::IEEEUtils qw/ :all /;
use Math::GSL::ODEIV qw/:all/;
use Math::GSL::Errno qw/:all/;
use Math::GSL::Test  qw/:all/;
use Data::Dumper;

BEGIN { gsl_set_error_handler_off(); }

sub make_fixture : Test(setup) {
    my $self = shift;
    my %config;
    my $T = $config{T} = $gsl_odeiv_step_rk8pd;
    $config{s} = gsl_odeiv_step_alloc($T, 2);
    $config{c} = gsl_odeiv_control_y_new(1e-6, 0.0);
    $config{e} = gsl_odeiv_evolve_alloc(2);
    my $params = $config{params} = { mu => 10 };
    $config{sys} = Math::GSL::ODEIV::gsl_odeiv_system->new(\&func, \&jac, 2, $params );
    gsl_ieee_env_setup;
    $self->{config} = \%config;
}

sub teardown : Test(teardown) {
    my $self = shift;

    my $c = $self->{config};
    gsl_odeiv_evolve_free($c->{e});
    gsl_odeiv_control_free($c->{c});
    gsl_odeiv_step_free($c->{s});
}

sub func {
    my ($t, $y, $dydt, $params) = @_;
    my $mu = $params->{mu};

    $dydt->[0] = $y->[1];
    $dydt->[1] = -$y->[0] - $mu*$y->[1]*(($y->[0])**2 - 1);
    return $GSL_SUCCESS;
}

sub jac {
    my ($t, $y, $dfdy, $dfdt, $params) = @_;

    my $mu = $params->{mu};
    my $m = gsl_matrix_view_array($dfdy, 2, 2);
    gsl_matrix_set( $m, 0, 0, 0.0 );
    gsl_matrix_set( $m, 0, 1, 1.0 );
    gsl_matrix_set( $m, 1, 0, (-2.0 * $mu * $y->[0] * $y->[1]) - 1.0 );
    gsl_matrix_set( $m, 1, 1, -$mu * (($y->[0])**2 - 1.0) );
    $dfdt->[0] = 0.0;
    $dfdt->[1] = 0.0;
    return $GSL_SUCCESS;
}

sub GSL_ODEIV_BAD_SYS_INPUT : Tests {
    my $self = shift;

    my $c = $self->{config};
    my $t = 0.0;
    my $t1 = 100.0;
    my $h = 1e-6;
    my $y = [ 1.0, 0.0 ];
    my $foo = 2;
    throws_ok {  
        gsl_odeiv_evolve_apply (
            $c->{e}, $c->{c}, $c->{s}, $foo, \$t, $t1, \$h, $y
        );
    } qr/Input parameter \$dydt is not a blessed reference/, 'wrong type 1';
    throws_ok {  
        gsl_odeiv_evolve_apply (
            $c->{e}, $c->{c}, $c->{s}, $self, \$t, $t1, \$h, $y
        );
    } qr/not an object of type Math::GSL::ODEIV::gsl_odeiv_system/, 'wrong type 2';
    my $bar = bless [], 'Math::GSL::ODEIV::gsl_odeiv_system';
    throws_ok {  
        gsl_odeiv_evolve_apply (
            $c->{e}, $c->{c}, $c->{s}, $bar, \$t, $t1, \$h, $y
        );
    } qr/not a blessed hash reference/, 'wrong type 3';
}

sub GSL_ODEIV_BAD_SYS_INPUT2 : Tests {
    my $self = shift;

    my $c = $self->{config};
    my $t = 0.0;
    my $t1 = 100.0;
    my $h = 1e-6;
    my $y = [ 1.0, 0.0 ];
    my $sys = $c->{sys};
    $sys->{func} = 2;
    throws_ok {  
        gsl_odeiv_evolve_apply (
            $c->{e}, $c->{c}, $c->{s}, $sys, \$t, $t1, \$h, $y
        );
    } qr/not a reference/, 'wrong func type 1';
    $sys->{func} = [];
    throws_ok {  
        gsl_odeiv_evolve_apply (
            $c->{e}, $c->{c}, $c->{s}, $sys, \$t, $t1, \$h, $y
        );
    } qr/not a coderef/, 'wrong func type 2';
    $sys->{func} = \&func;
    $sys->{params} = 5;
    throws_ok {  
        gsl_odeiv_evolve_apply (
            $c->{e}, $c->{c}, $c->{s}, $sys, \$t, $t1, \$h, $y
        );
    } qr/not a reference/, 'wrong param type 1';
    $sys->{params} = [];
    throws_ok {  
        gsl_odeiv_evolve_apply (
            $c->{e}, $c->{c}, $c->{s}, $sys, \$t, $t1, \$h, $y
        );
    } qr/not a hashref/, 'wrong param type 2';
    $sys->{params} = { mu => 10 };
    $sys->{dim} = [];
    throws_ok {  
        gsl_odeiv_evolve_apply (
            $c->{e}, $c->{c}, $c->{s}, $sys, \$t, $t1, \$h, $y
        );
    } qr/not a scalar value/, 'wrong dim type 1';
    $sys->{dim} = 2.1;
    throws_ok {  
        gsl_odeiv_evolve_apply (
            $c->{e}, $c->{c}, $c->{s}, $sys, \$t, $t1, \$h, $y
        );
    } qr/not an integer/, 'wrong dim type 2';
}

sub GSL_ODEIV_BAD_Y_INPUT : Tests {
    my $self = shift;

    my $c = $self->{config};
    my $t = 0.0;
    my $t1 = 100.0;
    my $h = 1e-6;
    my $y = 1.0;
    
    throws_ok {  
        gsl_odeiv_evolve_apply (
            $c->{e}, $c->{c}, $c->{s}, $c->{sys}, \$t, $t1, \$h, $y
        );
    } qr/not a reference/, 'wrong y type 1';
    $y = { a => 1 };
    throws_ok {  
        gsl_odeiv_evolve_apply (
            $c->{e}, $c->{c}, $c->{s}, $c->{sys}, \$t, $t1, \$h, $y
        );
    } qr/not an array reference/, 'wrong y type 2';
}

sub func2 {
    my ($t, $y, $dydt, $params) = @_;
    my $mu = $params->{mu};

    $dydt->[0] = $y->[1];
    $dydt->[1] = -$y->[0] - $mu*$y->[1]*(($y->[0])**2 - 1);
    return $GSL_SUCCESS;
}

sub GSL_ODEIV_BAD_FUNC_CALLBACK : Tests {
    my $self = shift;

    my $c = $self->{config};
    my $t1 = 100.0;
    my $h = 1e-6;
    my $y = [ 1.0, 0.0 ];
    my $t = 0.0;
    my $sys = $c->{sys};
    $sys->{func} = sub {  my ($t, $y, $dydt, $params) = @_; $dydt->[2] = 3; 0 };
    
    throws_ok {  
        gsl_odeiv_evolve_apply (
            $c->{e}, $c->{c}, $c->{s}, $sys, \$t, $t1, \$h, $y
        );
    } qr/array of wrong dimension/, 'wrong callback return type 1';
    $sys->{func} = sub {  my ($t, $y, $dydt, $params) = @_;
                          $dydt->[0]=1; $dydt->[1]={}; 0 };
    throws_ok {  
        gsl_odeiv_evolve_apply (
            $c->{e}, $c->{c}, $c->{s}, $sys, \$t, $t1, \$h, $y
        );
    } qr/array value is not a scalar/, 'wrong callback return type 2';
}

sub GSL_ODEIV_BAD_T_INPUT : Tests {
    my $self = shift;

    my $c = $self->{config};
    my $t1 = 100.0;
    my $h = 1e-6;
    my $y = [ 1.0, 0.0 ];
    my $t = 0.0;
    
    throws_ok {  
        gsl_odeiv_evolve_apply (
            $c->{e}, $c->{c}, $c->{s}, $c->{sys}, $t, $t1, \$h, $y
        );
    } qr/not a reference/, 'wrong t type 1';
    $t = { a => 1 };
    throws_ok {  
        gsl_odeiv_evolve_apply (
            $c->{e}, $c->{c}, $c->{s}, $c->{sys}, $t, $t1, \$h, $y
        );
    } qr/not a scalar reference/, 'wrong t type 2';
}

sub GSL_ODEIV_STEP1 : Tests {
    my $self = shift;

    my $c = $self->{config};
    my $t = 0.0;
    my $t1 = 100.0;
    my $h = 1e-6;
    my $y = [ 1.0, 0.0 ];
    
    my $status = gsl_odeiv_evolve_apply (
        $c->{e}, $c->{c}, $c->{s}, $c->{sys}, \$t, $t1, \$h, $y
    );
    ok_similar( $t, 1e-6, 'first_step_dt', 1e-8 );
    ok_similar( $h, 5e-6, 'first_step_h', 1e-8 );
}

Test::Class->runtests;
