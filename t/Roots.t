package Math::GSL::Roots::Test;
use strict;
use base q{Test::Class};
use Test::More;
use Math::GSL        qw/:all/;
use Math::GSL::Roots qw/:all/;
use Math::GSL::Test  qw/:all/;

sub make_fixture : Test(setup) {
    my $self = shift;
    $self->{roots} =gsl_root_fsolver_alloc($gsl_root_fsolver_bisection);
}

sub teardown : Test(teardown) {
}

sub GSL_ROOTS_ALLOC_FREE : Tests {
    my $self = shift;
    my $x = $self->{roots};
    isa_ok($x, 'Math::GSL::Roots', 'gsl_root_fsolver_alloc' );
    gsl_root_fsolver_free($x);
    ok(!$@, 'gsl_root_fsolver_free');
}

sub SOlVER_TYPES : Tests {
    ok( defined $gsl_root_fsolver_bisection );
    ok( defined $gsl_root_fsolver_brent);
    ok( defined $gsl_root_fsolver_falsepos);     
    ok( defined $gsl_root_fdfsolver_newton );    
    ok( defined $gsl_root_fdfsolver_secant  );   
    ok( defined $gsl_root_fdfsolver_steffenson); 
}

Test::Class->runtests;
