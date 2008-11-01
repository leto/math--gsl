%module "Math::GSL::IEEEUtils"
%{
    #include "gsl/gsl_ieee_utils.h"
%}

%include "gsl/gsl_ieee_utils.h"

%perlcode %{
@EXPORT_OK = qw/
               gsl_ieee_printf_float 
               gsl_ieee_printf_double 
               gsl_ieee_fprintf_float 
               gsl_ieee_fprintf_double 
               gsl_ieee_float_to_rep 
               gsl_ieee_double_to_rep 
               gsl_ieee_env_setup 
               gsl_ieee_read_mode_string 
               gsl_ieee_set_mode 
               $GSL_IEEE_TYPE_NAN 
               $GSL_IEEE_TYPE_INF 
               $GSL_IEEE_TYPE_NORMAL 
               $GSL_IEEE_TYPE_DENORMAL 
               $GSL_IEEE_TYPE_ZERO 
               $GSL_IEEE_SINGLE_PRECISION 
               $GSL_IEEE_DOUBLE_PRECISION 
               $GSL_IEEE_EXTENDED_PRECISION 
               $GSL_IEEE_ROUND_TO_NEAREST 
               $GSL_IEEE_ROUND_DOWN 
               $GSL_IEEE_ROUND_UP 
               $GSL_IEEE_ROUND_TO_ZERO 
               $GSL_IEEE_MASK_INVALID 
               $GSL_IEEE_MASK_DENORMALIZED 
               $GSL_IEEE_MASK_DIVISION_BY_ZERO 
               $GSL_IEEE_MASK_OVERFLOW 
               $GSL_IEEE_MASK_UNDERFLOW 
               $GSL_IEEE_MASK_ALL 
               $GSL_IEEE_TRAP_INEXACT 
             /;
%EXPORT_TAGS = ( all => [ @EXPORT_OK ] );
%}
