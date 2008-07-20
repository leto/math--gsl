%module "Math::GSL::Machine"
%{
    #include "gsl/gsl_machine.h"
%}

%include "gsl/gsl_machine.h"


%perlcode %{
@EXPORT_OK = qw/
               $GSL_DBL_EPSILON 
               $GSL_SQRT_DBL_EPSILON 
               $GSL_ROOT3_DBL_EPSILON 
               $GSL_ROOT4_DBL_EPSILON 
               $GSL_ROOT5_DBL_EPSILON 
               $GSL_ROOT6_DBL_EPSILON 
               $GSL_LOG_DBL_EPSILON 
               $GSL_DBL_MIN 
               $GSL_SQRT_DBL_MIN 
               $GSL_ROOT3_DBL_MIN 
               $GSL_ROOT4_DBL_MIN 
               $GSL_ROOT5_DBL_MIN 
               $GSL_ROOT6_DBL_MIN 
               $GSL_LOG_DBL_MIN 
               $GSL_DBL_MAX 
               $GSL_SQRT_DBL_MAX 
               $GSL_ROOT3_DBL_MAX 
               $GSL_ROOT4_DBL_MAX 
               $GSL_ROOT5_DBL_MAX 
               $GSL_ROOT6_DBL_MAX 
               $GSL_LOG_DBL_MAX 
               $GSL_FLT_EPSILON 
               $GSL_SQRT_FLT_EPSILON 
               $GSL_ROOT3_FLT_EPSILON 
               $GSL_ROOT4_FLT_EPSILON 
               $GSL_ROOT5_FLT_EPSILON 
               $GSL_ROOT6_FLT_EPSILON 
               $GSL_LOG_FLT_EPSILON 
               $GSL_FLT_MIN 
               $GSL_SQRT_FLT_MIN 
               $GSL_ROOT3_FLT_MIN 
               $GSL_ROOT4_FLT_MIN 
               $GSL_ROOT5_FLT_MIN 
               $GSL_ROOT6_FLT_MIN 
               $GSL_LOG_FLT_MIN 
               $GSL_FLT_MAX 
               $GSL_SQRT_FLT_MAX 
               $GSL_ROOT3_FLT_MAX 
               $GSL_ROOT4_FLT_MAX 
               $GSL_ROOT5_FLT_MAX 
               $GSL_ROOT6_FLT_MAX 
               $GSL_LOG_FLT_MAX 
               $GSL_SFLT_EPSILON 
               $GSL_SQRT_SFLT_EPSILON 
               $GSL_ROOT3_SFLT_EPSILON 
               $GSL_ROOT4_SFLT_EPSILON 
               $GSL_ROOT5_SFLT_EPSILON 
               $GSL_ROOT6_SFLT_EPSILON 
               $GSL_LOG_SFLT_EPSILON 
               $GSL_MACH_EPS 
               $GSL_SQRT_MACH_EPS 
               $GSL_ROOT3_MACH_EPS 
               $GSL_ROOT4_MACH_EPS 
               $GSL_ROOT5_MACH_EPS 
               $GSL_ROOT6_MACH_EPS 
               $GSL_LOG_MACH_EPS 
             /;
%EXPORT_TAGS = ( all => [ @EXPORT_OK ] );
%}
