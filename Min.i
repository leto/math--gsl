%module "Math::GSL::Min"
%{
    #include "gsl/gsl_types.h"
    #include "gsl/gsl_min.h"
%}

%include "gsl/gsl_types.h"
%include "gsl/gsl_min.h"

%perlcode %{

@EXPORT_OK = qw/
   gsl_min_fminimizer_alloc 
   gsl_min_fminimizer_free 
   gsl_min_fminimizer_set 
   gsl_min_fminimizer_set_with_values
   gsl_min_fminimizer_iterate 
   gsl_min_fminimizer_name 
   gsl_min_fminimizer_x_minimum
   gsl_min_fminimizer_x_lower 
   gsl_min_fminimizer_x_upper 
   gsl_min_fminimizer_f_minimum
   gsl_min_fminimizer_f_lower 
   gsl_min_fminimizer_f_upper 
   gsl_min_fminimizer_minimum 
   gsl_min_test_interval 
   gsl_min_find_bracket 
   $gsl_min_fminimizer_brent
   $gsl_min_fminimizer_goldensection
/;

%EXPORT_TAGS = ( all => [ @EXPORT_OK ] );

%}
