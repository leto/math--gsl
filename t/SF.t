use Test::More 'no_plan';
use Math::GSL;
use Math::GSL::Errno;
use Math::GSL::SF;
use Data::Dumper;
use strict;
use warnings;

BEGIN{ Math::GSL::Errno::gsl_set_error_handler_off(); }

my $gsl = Math::GSL->new;

my $results = { 
                'Math::GSL::SF::gsl_sf_gamma(6.3)'  =>  201.813275184748,
                'Math::GSL::SF::gsl_sf_erf(5)'      => 0.999999999998463,
                'Math::GSL::SF::gsl_sf_bessel_J0(5)'=> -0.17759677131433830434739701,
                # domain errors return nan
                'Math::GSL::SF::gsl_sf_gamma(-1)'   => 'nan', 
              };

$gsl->verify_results($results);

