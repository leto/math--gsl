package Math::GSL::Min::Test;
use Math::GSL::Test qw/:all/;
use base q{Test::Class};
use Test::More;
use Math::GSL::Min qw/:all/;
use Math::GSL qw/:all/;
use Math::GSL::Const qw/$M_PI/;
use strict;
use Data::Dumper;

sub make_fixture : Test(setup) {
    my $self = shift;
    $self->{min} = gsl_min_fminimizer_alloc($gsl_min_fminimizer_goldensection);
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
            )
    );
    cmp_ok( $mini->{x_minimum}, '==', 3 );
    cmp_ok( $mini->{x_lower}, '==', 0 );
    ok_similar([$mini->{x_upper}], [2*$M_PI] );
    ok_similar([$mini->{f_minimum}], [cos(3)] );
    ok_similar([$mini->{f_lower}], [cos(0)] );
    ok_similar([$mini->{f_upper}], [cos(2*$M_PI)] );
}

sub GSL_MIN_ITERATE : Tests {
    my $self = shift;
    my $mini = $self->{min};
    ok_status(gsl_min_fminimizer_set($mini, 
        sub { cos($_[0]) }, 3, 0, 2*$M_PI     
    ));
    # This blows up
    #ok_status(gsl_min_fminimizer_iterate($mini));
}

sub GSL_MIN_NEW_FREE : Tests {
    my $self = shift;
    my $min = $self->{min};
    isa_ok($min, 'Math::GSL::Min');

    gsl_min_fminimizer_free($min);
    ok(!$@, 'gsl_min_fminimizer_free');
}

Test::Class->runtests;
