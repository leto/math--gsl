use Test::More tests=>2;
use Math::GSL;
use Math::GSL::SF;
use Data::Dumper;
use strict;
use warnings;

my $gsl = Math::GSL->new;

my $results = { 
                'Math::GSL::SF::gsl_sf_gamma(6.3)' =>  201.813275184748,
                'Math::GSL::SF::gsl_sf_erf(5)'     => 0.999999999998463,
              };

$gsl->verify_results($results);

