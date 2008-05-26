use Test::More 'no_plan';
use Math::GSL qw/is_similar/;
use Math::GSL::Errno qw/:all/;
use Math::GSL::SF qw/gsl_sf_bessel_J0 gsl_sf_bessel_J0_e/;
use Data::Dumper;
use strict;
use warnings;

BEGIN{ gsl_set_error_handler_off(); }

my $gsl = Math::GSL->new;

my $results = { 
                # GSL does not seem to have one argument versions of Ai(x)
                #'gsl_sf_airy_Ai(-5)'           => 0.3507610090241142,
                #'gsl_sf_airy_Ai(-500)'         => 0.0725901201040411396
                'gsl_sf_bessel_J0(0.1)'         => 0.99750156206604003230,
                'gsl_sf_bessel_J0(2.0)'         => 0.22389077914123566805,
                'gsl_sf_bessel_J0(5)'           => -0.17759677131433830434739701,
                'gsl_sf_bessel_J0(100)'         => 0.019985850304223122424,
                'gsl_sf_bessel_J0(1e10)'        => 2.1755917502468917269e-06,
                'gsl_sf_erf(5)'                 => 0.999999999998463,
                'gsl_sf_dilog(-3.0)'            => -1.9393754207667089531,     
                'gsl_sf_dilog(-0.5)'            => -0.4484142069236462024,     
                'gsl_sf_gamma(6.3)'             => [ 201.813275184748, 1e-12 ],
                'gsl_sf_dilog(-0.001)'          => -0.0009997501110486510834,  
                'gsl_sf_dilog(0.1)'             => 0.1026177910993911,        
                'gsl_sf_dilog(0.7)'             => 0.8893776242860387386,     
                'gsl_sf_dilog(1.0)'             => 1.6449340668482260,        
                'gsl_sf_gamma(-1)'              => 'nan', 
              };

$gsl->verify_results($results, 'Math::GSL::SF');

{
    my $result = Math::GSL::SF::gsl_sf_result_struct->new;
    my ($status) = gsl_sf_bessel_J0_e(2.0,$result); 
    ok( defined $result->{err}, '$result->{err}' );
    ok( is_similar($result->{val}, gsl_sf_bessel_J0(2.0)) , '$result->{val}' );
};
