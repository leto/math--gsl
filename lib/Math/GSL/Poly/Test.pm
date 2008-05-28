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
    my $got = gsl_poly_complex_eval(  [ 1, 4 ], 2, $z);   # 1 + 4 x

    is_deeply( [ gsl_parts($got) ] , [ 9, 4 ] );
}

42;
