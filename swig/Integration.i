%module "Math::GSL::Integration"
%include "typemaps.i"
%include "gsl_typemaps.i"
%include "renames.i"

%{
    #ifndef GSL_VAR
    #include "gsl/gsl_types.h"
    #endif

    #include "gsl/gsl_integration.h"
    #include "gsl/gsl_math.h"
%}
#ifndef GSL_VAR
%include "gsl/gsl_types.h"
#endif
%include "gsl/gsl_integration.h"
%include "gsl/gsl_math.h"
%include "../pod/Integration.pod"
