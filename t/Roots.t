package Math::GSL::Roots::Test;
use strict;
use base q{Test::Class};
use Test::More;
use Math::GSL        qw/:all/;
use Math::GSL::Roots qw/:all/;
use Math::GSL::Test  qw/:all/;
use Data::Dumper;

sub make_fixture : Test(setup) {
    my $self = shift;
    $self->{solver} =gsl_root_fsolver_alloc($gsl_root_fsolver_bisection);
}

sub teardown : Test(teardown) {
    my $self = shift;
    #gsl_root_fsolver_free($self->{solver});
}

sub GSL_ROOTS_ALLOC_FREE : Tests {
    my $self = shift;
    my $x = $self->{solver};
    isa_ok($x, 'Math::GSL::Roots', 'gsl_root_fsolver_alloc' );
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
sub SOlVER_TYPES : Tests {
    cmp_ok( $gsl_root_fsolver_bisection->{name}   ,'eq','bisection'  );
    cmp_ok( $gsl_root_fsolver_brent->{name}       ,'eq','brent'      );
    cmp_ok( $gsl_root_fsolver_falsepos->{name}    ,'eq','falsepos'   );     
    cmp_ok( $gsl_root_fdfsolver_newton->{name}    ,'eq','newton'     );    
    cmp_ok( $gsl_root_fdfsolver_secant->{name}    ,'eq','secant'     );   
    cmp_ok( $gsl_root_fdfsolver_steffenson->{name},'eq','steffenson' ); 
}

Test::Class->runtests;
