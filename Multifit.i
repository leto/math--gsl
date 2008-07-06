%module Multifit
%{
    #include "gsl/gsl_types.h"
    #include "gsl/gsl_multifit.h"
    #include "gsl/gsl_multifit_nlin.h"
%}

%include "gsl/gsl_types.h"
%include "gsl/gsl_multifit.h"
%include "gsl/gsl_multifit_nlin.h"

%perlcode %{
@EXPORT_OK = qw/
               gsl_multifit_linear_alloc 
               gsl_multifit_linear_free 
               gsl_multifit_linear 
               gsl_multifit_linear_svd 
               gsl_multifit_wlinear 
               gsl_multifit_wlinear_svd 
               gsl_multifit_linear_est 
               gsl_multifit_linear_residuals 
               gsl_multifit_gradient 
               gsl_multifit_covar 
               gsl_multifit_fsolver_alloc 
               gsl_multifit_fsolver_free 
               gsl_multifit_fsolver_set 
               gsl_multifit_fsolver_iterate 
               gsl_multifit_fsolver_name 
               gsl_multifit_fsolver_position 
               gsl_multifit_fdfsolver_alloc 
               gsl_multifit_fdfsolver_set 
               gsl_multifit_fdfsolver_iterate 
               gsl_multifit_fdfsolver_free 
               gsl_multifit_fdfsolver_name 
               gsl_multifit_fdfsolver_position 
               gsl_multifit_test_delta 
               gsl_multifit_test_gradient 
             /;
%EXPORT_TAGS = ( all => [ @EXPORT_OK ] );
%}
