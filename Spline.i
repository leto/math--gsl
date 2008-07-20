%module "Math::GSL::Spline"
%{
    #include "gsl/gsl_spline.h"
%}

%include "gsl/gsl_spline.h"


%perlcode %{
@EXPORT_OK = qw/
               gsl_spline_alloc 
               gsl_spline_init 
               gsl_spline_name 
               gsl_spline_min_size 
               gsl_spline_eval_e 
               gsl_spline_eval 
               gsl_spline_eval_deriv_e 
               gsl_spline_eval_deriv 
               gsl_spline_eval_deriv2_e 
               gsl_spline_eval_deriv2 
               gsl_spline_eval_integ_e 
               gsl_spline_eval_integ 
               gsl_spline_free 
             /;
%EXPORT_TAGS = ( all => [ @EXPORT_OK ] );
%}
