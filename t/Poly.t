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

    my $gsl = Math::GSL->new;
    my $results = { 
        #   'Math::GSL::Poly::gsl_poly_eval( 1 .. 3, 3, 2)' => 42, 
            'Math::GSL::Poly::gsl_poly_complex_eval( 1 ..3, 3, $z)' => 43,
    };

    #$gsl->verify_results($results);
}

