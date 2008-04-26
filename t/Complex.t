use Test::More 'no_plan';
use Math::GSL;
use Math::GSL::Complex;
use Data::Dumper;
use strict;
use warnings;

# gsl_complex gsl_complex_polar (double r, double theta)

{
    my $x =Math::GSL::Complex::gsl_complex->new;
    ok( defined $x && $x->isa('Math::GSL::Complex'), 'gsl_complex' );
}
{
    my $x =Math::GSL::Complex::gsl_complex->new;

    my $vals = Math::GSL::Complex::new_doubleArray(2);

    Math::GSL::Complex::doubleArray_setitem($vals, 0, 2);

    Math::GSL::Complex::doubleArray_setitem($vals, 1, 3);

    warn Dumper [ $vals ];
    warn Dumper [ $x ];
}


