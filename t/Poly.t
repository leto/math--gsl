use Test::More 'no_plan';
use Math::GSL;
use Math::GSL::Errno;
use Math::GSL::Poly;
use Data::Dumper;
use strict;
use warnings;


{
    my $z = Math::GSL::Poly::gsl_complex->new;
   
    ok( defined $z && $z->isa('Math::GSL::Poly'), 'gsl_complex->new returns correct object');
}

{
    my $gsl = Math::GSL->new;

    my $vals = Math::GSL::Poly::new_doubleArray(3);

    #fugly
    Math::GSL::Poly::doubleArray_setitem($vals, 0, 3.14);
    Math::GSL::Poly::doubleArray_setitem($vals, 1, 2.72);
    Math::GSL::Poly::doubleArray_setitem($vals, 2, 5.55);

    my $y = Math::GSL::Poly::gsl_poly_eval( $vals , 3, 1.0);

    ok( abs($y - (3.14+2.72+5.55) ) < 1e-8, 'gsl_poly_eval' );
}

