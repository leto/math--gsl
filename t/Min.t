package Math::GSL::Min::Test;
use base q{Test::Class};
use strict;
use Test::More tests => 22;
use Math::GSL        qw/:all/;
use Math::GSL::Min   qw/:all/;
use Math::GSL::Test  qw/:all/;
use Math::GSL::Errno qw/:all/;
use Math::GSL::Const qw/$M_PI/;
#use Devel::Trace     qw/trace/;
use Data::Dumper;

BEGIN { gsl_set_error_handler_off(); }

sub trace { }

sub make_fixture : Test(setup) {
    my $self = shift;
    $self->{min}   = gsl_min_fminimizer_alloc($gsl_min_fminimizer_goldensection);
    $self->{brent} = gsl_min_fminimizer_alloc($gsl_min_fminimizer_brent);
}

sub teardown : Test(teardown) {
    my $self = shift;
}

sub GSL_MIN_TYPES : Tests {

    my $m = gsl_min_fminimizer_alloc($gsl_min_fminimizer_goldensection);
    isa_ok($m, 'Math::GSL::Min');

    my $n = gsl_min_fminimizer_alloc($gsl_min_fminimizer_brent);
    isa_ok($n, 'Math::GSL::Min');
}

sub GSL_MIN_NAME : Tests {
    my $self = shift;
    cmp_ok( 'goldensection', 'eq', gsl_min_fminimizer_name($self->{min}) );
    cmp_ok( 'brent', 'eq', gsl_min_fminimizer_name($self->{brent}) );
}

sub GSL_MIN_SET : Tests {
    my $self = shift;
    my $mini = $self->{min};
    ok_status(
        gsl_min_fminimizer_set($mini,
            sub { cos($_[0]) }, 3, 0, 2*$M_PI
        ),
    );

    # These are the first guesses first the initial iteration
    cmp_ok( $mini->{x_minimum}, '==', 3 );
    cmp_ok( $mini->{x_lower}, '==', 0 );
    isa_ok( $mini->{function} , 'Math::GSL::Min::gsl_function_struct');
    ok_similar([$mini->{x_upper}], [2*$M_PI] );
    ok_similar([$mini->{f_minimum}], [cos(3)] );
    ok_similar([$mini->{f_lower}], [cos(0)] );
    ok_similar([$mini->{f_upper}], [cos(2*$M_PI)] );

    ok_similar([gsl_min_fminimizer_x_lower($mini)],[0],'x_lower');
    ok_similar([gsl_min_fminimizer_x_upper($mini)],[2*$M_PI],'x_upper');
    ok_similar([gsl_min_fminimizer_x_minimum($mini)],[3],'x_minimum');

    ok_similar([gsl_min_fminimizer_f_lower($mini)],[cos(0)],'f_lower');
    ok_similar([gsl_min_fminimizer_f_upper($mini)],[cos(2*$M_PI)],'f_upper');
    ok_similar([gsl_min_fminimizer_f_minimum($mini)],[cos(3)],'f_minimum');
}

sub GSL_MIN_TEST_INTERVAL : Tests {
    my $self = shift;
    my $mini = $self->{min};

    my ($x_lower, $x_upper, $epsabs, $epsrel) = (0,1e-7, 1e-3,1e-5);
    ok_status(gsl_min_test_interval ($x_lower, $x_upper, $epsabs, $epsrel),
        $GSL_SUCCESS, 'gsl_min_test_interval'
    );

    ($x_lower, $x_upper, $epsabs, $epsrel) = (0,1e-2, 1e-3,1e-5);
    ok_status(gsl_min_test_interval ($x_lower, $x_upper, $epsabs, $epsrel),
        $GSL_CONTINUE, 'gsl_min_test_interval'
    );
}

sub GSL_MIN_ITERATE : Tests {
    my $self = shift;
    my $mini = $self->{min};
    ok_status(gsl_min_fminimizer_set_with_values($mini,
        sub { cos($_[0]) },
        3, cos(3),
        0, cos(0),
        2*$M_PI, cos(2*$M_PI)
    ));
    ok_status(gsl_min_fminimizer_iterate($mini));
}

Test::Class->runtests;
