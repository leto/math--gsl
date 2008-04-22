use Test::More tests=>1;
use Math::GSL;
use Math::GSL::Randist;
use Data::Dumper;
use strict;
use warnings;

my $gsl = Math::GSL->new;

my $results = { 
                'Math::GSL::Randist::gsl_ran_hypergeometric_pdf(1,3,5,6)' => 0.107142857142857,
              };

$gsl->verify_results($results);

