%module Fit
%{
#include "gsl/gsl_fit.h"
%}

%include "gsl/gsl_fit.h"


%perlcode %{
@EXPORT_OK = qw/
               gsl_fit_linear 
               gsl_fit_wlinear 
               gsl_fit_linear_est 
               gsl_fit_mul 
               gsl_fit_wmul 
               gsl_fit_mul_est 
             /;
%EXPORT_TAGS = ( all => [ @EXPORT_OK ] );
%}
