use Test::More 'no_plan';
use Math::GSL qw/:all/;
use Math::GSL::Deriv qw/:all/;
use Math::GSL::Errno qw/:all/;
use Data::Dumper;
use strict;
use warnings;

BEGIN{ gsl_set_error_handler_off() };

{
    local $TODO = "gsl_function *";
    my ($x,$h)=(5,0.01);

    my $gsl_func = Math::GSL::Deriv::gsl_function_struct->new;

    isa_ok( $gsl_func, 'Math::GSL::Deriv::gsl_function_struct' );


    $gsl_func->swig_function_set( sub { print "FOO\n" } );
    my $func = $gsl_func->swig_function_get();
    ok( ref $func eq 'CODE', 'swig_function_get works' );

    my $params = $gsl_func->swig_params_set(0);
    ok( defined $params, 'swig_params_set works' );

    my ($value, $result, $abserr);
    print "about to call deriv_central\n";
    #($value, $abserr) = gsl_deriv_central ( $gsl_func, $x, $h, $result, $abserr); 
    print Dumper [ $value, $abserr ];
}

