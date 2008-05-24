%module Interp
%{
    #include "/usr/local/include/gsl/gsl_types.h"
    #include "/usr/local/include/gsl/gsl_interp.h"
%}
%include "/usr/local/include/gsl/gsl_types.h"
%include "/usr/local/include/gsl/gsl_interp.h"


%perlcode %{
@EXPORT_OK = qw/
               gsl_interp_accel_alloc 
               gsl_interp_accel_find 
               gsl_interp_accel_reset 
               gsl_interp_accel_free 
               gsl_interp_alloc 
               gsl_interp_init 
               gsl_interp_name 
               gsl_interp_min_size 
               gsl_interp_eval_e 
               gsl_interp_eval 
               gsl_interp_eval_deriv_e 
               gsl_interp_eval_deriv 
               gsl_interp_eval_deriv2_e 
               gsl_interp_eval_deriv2 
               gsl_interp_eval_integ_e 
               gsl_interp_eval_integ 
               gsl_interp_free 
               gsl_interp_bsearch 
             /;
%EXPORT_TAGS = ( all => [ @EXPORT_OK ] );
%}
