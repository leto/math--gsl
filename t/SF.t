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
                'gsl_sf_bessel_J0(0.1)' => 0.99750156206604003230,
                'gsl_sf_bessel_J0(2.0)' => 0.22389077914123566805,
                'gsl_sf_bessel_J0(100)' => 0.019985850304223122424,
                'gsl_sf_bessel_J0(1e10)' => 2.1755917502468917269e-06,
                'gsl_sf_gamma(6.3)'     => 201.813275184748,
                'gsl_sf_erf(5)'         => 0.999999999998463,
                'gsl_sf_bessel_J0(5)'   => -0.17759677131433830434739701,
                'gsl_sf_gamma(-1)'      => 'nan', 
              };

$gsl->verify_results($results, 'Math::GSL::SF');

