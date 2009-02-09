%module "Math::GSL::Combination"
%include "typemaps.i"
%include "gsl_typemaps.i"
%include "system.i"
%{
    #include "gsl/gsl_types.h"
    #include "gsl/gsl_combination.h"
%}

#if GSL_MINOR_VERSION == 12
    %import "gsl/gsl_inline.h"
#endif

%include "gsl/gsl_types.h"
%include "gsl/gsl_combination.h"
%include "../pod/Combination.pod"
