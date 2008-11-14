%module "Math::GSL::Min"
%include "typemaps.i"
%include "gsl_typemaps.i"
%{
    #include "gsl/gsl_types.h"
    #include "gsl/gsl_min.h"
    #include "gsl/gsl_math.h"
%}
%include "gsl/gsl_types.h"
%include "gsl/gsl_min.h"
%include "gsl/gsl_math.h"
%include "../pod/Min.pod"
