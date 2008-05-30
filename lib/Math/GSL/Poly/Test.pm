package Math::GSL::Poly::Test;
use base q{Test::Class};
use Test::More;
use Math::GSL qw/is_similar/;
use Math::GSL::Poly qw/:all/;
use Math::GSL::Complex qw/:all/;
use Data::Dumper;
use strict;

sub make_fixture : Test(setup) {
}
sub teardown : Test(teardown) {
}

sub GSL_POLY_EVAL : Tests {
    my $y = gsl_poly_eval( [ 3.14, 2.72, 5.55 ] , 3, 1.0);

    ok( is_similar($y,3.14+2.72+5.55) );
}

sub GSL_POLY_SOLVE_QUADRATIC : Tests {
    my ($a,$b,$c) = (1, 6, 9);
    my ($x0,$x1)=(0,0);

    my ($num_roots) = gsl_poly_solve_quadratic( $a, $b, $c, \$x0, \$x1);
    is_deeply ( [ $num_roots, $x0, $x1], [ 2, -3, -3 ] );
}

sub GSL_POLY_COMPLEX_EVAL : Tests {
    my $z   = gsl_complex_rect(2,1);                      # 2+i
    my $got = gsl_poly_complex_eval( [ 1, 4 ], 2, $z);   # 1 + 4 x

    is_deeply( [ gsl_parts($got) ] , [ 9, 4 ] );
}

sub GSL_COMPLEX_POLY_COMPLEX_EVAL : Tests {
    my $z   = gsl_complex_rect(0.674,-1.423);
    my $w   = gsl_complex_rect(-1.44, 9.55);
    $y = gsl_complex_poly_complex_eval ($z, 1, $w);

    is_deeply( [ gsl_parts($got) ] , [0.674,-1.423] );
}

sub GSL_POLY_SOLVE_CUBIC : Tests {
    my ($x0, $x1, $x2) = (0, 0, 0);
    my ($num_roots) = gsl_poly_solve_cubic (-51.0, 867.0, -4913.0, \$x0, \$x1, \$x2);

    is_deeply ( [ $num_roots, $x0, $x1, $x2], [ 3, 17.0, 17.0, 17.0] );
}

sub GSL_POLY_COMPLEX_SOLVE_QUADRATIC : Tests {
    my $z0 = gsl_complex_rect(2,3);
    my $z1 = gsl_complex_rect(3,2);
    print Dumper [ $z0 ];
    my ($num_roots) = gsl_poly_complex_solve_quadratic (4.0, -20.0, 26.0, \$z0, \$z1);

    is_deeply ( [ $num_roots, gsl_real($z0), gsl_complex($z0), gsl_real($z1), gsl_complex($z1)], [ 2, 2.5, -0.5, 2.5, 0.5] );
}


42;
