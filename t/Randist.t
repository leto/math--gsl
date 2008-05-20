use Test::More tests=>4;
use Math::GSL;
use Math::GSL::Randist;
use Math::GSL::RNG;
use Data::Dumper;
use strict;
use warnings;

my $gsl = Math::GSL->new;

my $results = { 
                'Math::GSL::Randist::gsl_ran_hypergeometric_pdf(1,3,5,6)' => 0.107142857142857,
                'Math::GSL::Randist::gsl_ran_laplace_pdf(5,10)'           => 0.0303265329856317, 
                'Math::GSL::Randist::gsl_ran_gaussian_pdf(2,3.14)'        => 0.10372528979964, 
              };

$gsl->verify_results($results);

{
    Math::GSL::_assert_dies( sub { Math::GSL::Randist::gsl_ran_laplace(1,2) } );
}
