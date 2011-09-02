package Math::GSL::Roots::Test;
use strict;
use base q{Test::Class};
use Test::More tests => 13;
use Math::GSL        qw/:all/;
use Math::GSL::Roots qw/:all/;
use Math::GSL::Test  qw/:all/;
use Math::GSL::Errno qw/:all/;
use Data::Dumper;

BEGIN { gsl_set_error_handler_off(); }

sub make_fixture : Test(setup) {
    my $self = shift;
    $self->{solver}    = gsl_root_fsolver_alloc($gsl_root_fsolver_bisection);
    $self->{fdfsolver} = gsl_root_fdfsolver_alloc($gsl_root_fdfsolver_newton);
}

sub teardown : Test(teardown) {
    my $self = shift;
}

sub GSL_FDFSOLVER_BASIC : Tests {
    my $self = shift;
    local $TODO = 'this blows up';
    #ok_status(gsl_root_fdfsolver_set($self->{fdfsolver},
    #    sub { my $x=shift; ($x-3.2)**3 },
    #    5
    #));

}

sub GSL_ROOTS_SET : Tests {
    my $self = shift;
    my $solver = $self->{solver};
    ok_status(gsl_root_fsolver_set($solver,
        sub { my $x=shift; ($x-3.2)**3 },
        0, 5
    ));
    ok_similar( [$solver->{root} ], [2.5], 'bisection starts of with midpoint as initial guess' );
}

sub GSL_ROOT_ITERATE : Tests {
    my $self = shift;
    my $solver = gsl_root_fsolver_alloc($gsl_root_fsolver_brent);
    ok_status(gsl_root_fsolver_set($solver,
        sub { my $x=shift; ($x-3.2)**3 },
        0, 5
    ));

    my ($status, $root);
    for (1..20) {
        $status = gsl_root_fsolver_iterate($solver);
        $root = gsl_root_fsolver_root($solver);
        my $x_lo = gsl_root_fsolver_x_lower($solver);
        my $x_hi = gsl_root_fsolver_x_upper($solver);
        $status = gsl_root_test_interval($x_lo, $x_hi, 3.1, 3.3);
    }
    ok_status($status);
    ok_similar([$root], [3.2], 'gsl_root_fsolver_root', 0.1);
}

sub SOlVER_TYPES : Tests {
    cmp_ok( $gsl_root_fsolver_bisection->{name}   ,'eq','bisection'  );
    cmp_ok( $gsl_root_fsolver_brent->{name}       ,'eq','brent'      );
    cmp_ok( $gsl_root_fsolver_falsepos->{name}    ,'eq','falsepos'   );
    cmp_ok( $gsl_root_fdfsolver_newton->{name}    ,'eq','newton'     );
    cmp_ok( $gsl_root_fdfsolver_secant->{name}    ,'eq','secant'     );
    cmp_ok( $gsl_root_fdfsolver_steffenson->{name},'eq','steffenson' );
}

sub GSL_ROOTFSOLVER_NAME : Tests {
    my $self = shift;
    cmp_ok( gsl_root_fsolver_name($self->{solver})   ,'eq','bisection'  );
}

sub GSL_FDFSOLVER_NAME : Tests {
    my $self = shift;
    cmp_ok( gsl_root_fdfsolver_name($self->{fdfsolver})   ,'eq','newton'  );
}

Test::Class->runtests;
