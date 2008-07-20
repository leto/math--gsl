%module "Math::GSL::Combination"
%{
    #include "gsl/gsl_types.h"
    #include "gsl/gsl_combination.h"
%}

%include "gsl/gsl_types.h"
%include "gsl/gsl_combination.h"


%perlcode %{
@EXPORT_OK = qw/
               gsl_combination_alloc 
               gsl_combination_calloc 
               gsl_combination_init_first 
               gsl_combination_init_last 
               gsl_combination_free 
               gsl_combination_memcpy 
               gsl_combination_fread 
               gsl_combination_fwrite 
               gsl_combination_fscanf 
               gsl_combination_fprintf 
               gsl_combination_n 
               gsl_combination_k 
               gsl_combination_data 
               gsl_combination_get 
               gsl_combination_valid 
               gsl_combination_next 
               gsl_combination_prev 
             /;
%EXPORT_TAGS = ( all => [ @EXPORT_OK ] );
%}
