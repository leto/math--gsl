%module Deriv

%typemap(in) gsl_function const * {
    printf("gsl_func \n");
};

%apply double * OUTPUT { double *result,double *abserr };

%{
    #include "/usr/local/include/gsl/gsl_math.h"
    #include "/usr/local/include/gsl/gsl_deriv.h"
%}

%include "/usr/local/include/gsl/gsl_math.h"
%include "/usr/local/include/gsl/gsl_deriv.h"

%perlcode %{
@EXPORT_OK = qw/
               gsl_deriv_central 
               gsl_deriv_backward 
               gsl_deriv_forward 
             /;
%EXPORT_TAGS = ( all => [ @EXPORT_OK ] );
%}

