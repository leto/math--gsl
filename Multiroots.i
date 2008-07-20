%module "Math::GSL::Multiroots"
%{
#include "gsl/gsl_types.h"
#include "gsl/gsl_multiroots.h"
%}

%include "gsl/gsl_types.h"
%include "gsl/gsl_multiroots.h"


%perlcode %{
@EXPORT_OK = qw/
               gsl_multiroot_fdjacobian 
               gsl_multiroot_fsolver_alloc 
               gsl_multiroot_fsolver_free 
               gsl_multiroot_fsolver_set 
               gsl_multiroot_fsolver_iterate 
               gsl_multiroot_fsolver_name 
               gsl_multiroot_fsolver_root 
               gsl_multiroot_fsolver_dx 
               gsl_multiroot_fsolver_f 
               gsl_multiroot_fdfsolver_alloc 
               gsl_multiroot_fdfsolver_set 
               gsl_multiroot_fdfsolver_iterate 
               gsl_multiroot_fdfsolver_free 
               gsl_multiroot_fdfsolver_name 
               gsl_multiroot_fdfsolver_root 
               gsl_multiroot_fdfsolver_dx 
               gsl_multiroot_fdfsolver_f 
               gsl_multiroot_test_delta 
               gsl_multiroot_test_residual 
             /;
%EXPORT_TAGS = ( all => [ @EXPORT_OK ] );
%}
