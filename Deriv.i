%module Deriv
%{
    #include "/usr/local/include/gsl/gsl_deriv.h"
%}

%include "/usr/local/include/gsl/gsl_deriv.h"

%perlcode %{
@EXPORT_OK = qw/
               gsl_deriv_central 
               gsl_deriv_backward 
               gsl_deriv_forward 
             /;
%EXPORT_TAGS = ( all => [ @EXPORT_OK ] );
%}

