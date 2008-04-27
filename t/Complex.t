use Test::More 'no_plan';
use Math::GSL qw/is_similar/;
use Math::GSL::Complex;
use Data::Dumper;
use strict;
use warnings;

{
    my $x =Math::GSL::Complex::gsl_complex->new;
    ok( defined $x && $x->isa('Math::GSL::Complex'), 'gsl_complex' );
}

{
    my $x = Math::GSL::Complex::gsl_complex->new;
    $x = Math::GSL::Complex::gsl_complex_rect(5,3);

    my $real = Math::GSL::Complex::doubleArray_getitem($x->{dat}, 0);
    my $imag = Math::GSL::Complex::doubleArray_getitem($x->{dat}, 1);
    print "x=$real + $imag*I\n" if $ENV{DEBUG};
    ok( is_similar($real,5), 'gsl_complex_rect real'); 
    ok( is_similar($imag,3), 'gsl_complex_rect imag'); 
}

