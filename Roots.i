%module "Math::GSL::Roots"
%{
    #include "gsl/gsl_types.h"
    #include "gsl/gsl_roots.h"
%}
%include "gsl/gsl_types.h"
%include "gsl/gsl_roots.h"


%perlcode %{
@EXPORT_OK = qw/
               gsl_root_fsolver_alloc 
               gsl_root_fsolver_free 
               gsl_root_fsolver_set 
               gsl_root_fsolver_iterate 
               gsl_root_fsolver_name 
               gsl_root_fsolver_root 
               gsl_root_fsolver_x_lower 
               gsl_root_fsolver_x_upper 
               gsl_root_fdfsolver_alloc 
               gsl_root_fdfsolver_set 
               gsl_root_fdfsolver_iterate 
               gsl_root_fdfsolver_free 
               gsl_root_fdfsolver_name 
               gsl_root_fdfsolver_root 
               gsl_root_test_interval 
               gsl_root_test_residual 
               gsl_root_test_delta 
               $gsl_root_fsolver_bisection    
               $gsl_root_fsolver_brent   
               $gsl_root_fsolver_falsepos     
               $gsl_root_fdfsolver_newton     
               $gsl_root_fdfsolver_secant     
               $gsl_root_fdfsolver_steffenson 
             /;
%EXPORT_TAGS = ( all => [ @EXPORT_OK ] );
%}
