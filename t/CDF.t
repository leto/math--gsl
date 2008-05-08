use Test::More 'no_plan';
use Math::GSL;
use Math::GSL::CDF;
use Data::Dumper;
use strict;
use warnings;

{
    my $gsl = Math::GSL->new;
    my $results = { 
                    'gsl_cdf_ugaussian_P(2.0)'           => 0.977250,
                    'gsl_cdf_ugaussian_Q(2.0)'           => 0.022750,
                    'gsl_cdf_ugaussian_Pinv(0.977250)'   => 2.000000,
                    'gsl_cdf_ugaussian_Qinv(0.022750)'   => 2.000000,
                };
    $gsl->verify_results($results, 'Math::GSL::CDF', 1e-5);
}
