%module "Math::GSL::Monte"
%{
    #include "gsl/gsl_monte.h"
    #include "gsl/gsl_monte_miser.h"
    #include "gsl/gsl_monte_plain.h"
    #include "gsl/gsl_monte_vegas.h"
%}

%include "gsl/gsl_monte.h"
%include "gsl/gsl_monte_miser.h"
%include "gsl/gsl_monte_plain.h"
%include "gsl/gsl_monte_vegas.h"


%perlcode %{
@EXPORT_OK = qw/
               gsl_monte_miser_integrate 
               gsl_monte_miser_alloc 
               gsl_monte_miser_init 
               gsl_monte_miser_free 
               gsl_monte_plain_integrate 
               gsl_monte_plain_alloc 
               gsl_monte_plain_init 
               gsl_monte_plain_free 
               gsl_monte_vegas_integrate 
               gsl_monte_vegas_alloc 
               gsl_monte_vegas_init 
               gsl_monte_vegas_free 
               $GSL_VEGAS_MODE_IMPORTANCE 
               $GSL_VEGAS_MODE_IMPORTANCE_ONLY 
               $GSL_VEGAS_MODE_STRATIFIED 
             /;
%EXPORT_TAGS = ( all => [ @EXPORT_OK ] );
%}
