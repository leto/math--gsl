use Test::More 'no_plan';
use Math::GSL qw/:all/;
use Math::GSL::Deriv qw/:all/;
use Math::GSL::Errno qw/:all/;
use Data::Dumper;
use strict;
use warnings;

BEGIN{ gsl_set_error_handler_off() };

{
    my ($x,$h)=(5,0.01);
    my $func = Math::GSL::Deriv::gsl_function_struct->new;
    isa_ok( $func, 'Math::GSL::Deriv::gsl_function_struct' );

    local $TODO = "gsl_function *";
    $func->swig_params_set(0);
    $func->swig_function_set( sub { $_[0] ** 2 } );

    #my ($value, $abserr) = gsl_deriv_central ( $func, $x, $h); 
    #print Dumper [ $value, $abserr ];
}

