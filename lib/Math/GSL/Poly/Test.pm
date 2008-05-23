package Math::GSL::Poly::Test;
use base q{Test::Class};
use Test::More;
use Math::GSL::Poly qw/gsl_poly_eval gsl_poly_solve_quadratic/;
use Math::GSL qw/is_similar/;
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

42;
