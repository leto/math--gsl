use Test::More 'no_plan';
use Math::GSL qw/:all/;
use Math::GSL::Deriv qw/:all/;
use Math::GSL::Errno qw/:all/;
use Data::Dumper;
use strict;
use warnings;

BEGIN{ gsl_set_error_handler_off() };

{
    my ($x,$h)=(10,0.01);

    my $gsl_func = Math::GSL::Deriv::gsl_function_struct->new;

    isa_ok( $gsl_func,'Math::GSL::Deriv::gsl_function_struct');


    my ($status, $result, $abserr);
    ($status, $result, $abserr) = gsl_deriv_central ( $gsl_func, $x, $h); 
    ok_status( $status, $GSL_SUCCESS);
    ok_similar( $result, 2*$x, 'gsl_deriv_central works for a static function' );

    local $TODO = "gsl_function *";
    $gsl_func->swig_function_set( sub { print "FOO\n" } );
    my $func = $gsl_func->swig_function_get();
    ok( ref $func eq 'CODE', 'swig_function_get works' );

    $gsl_func->swig_params_set(42);
    my $params = $gsl_func->swig_params_get();
    ok(defined $params && $params == 42, 'swig_params_get works' );
}

