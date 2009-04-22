%module "Math::GSL::Deriv"
// Danger Will Robinson, for realz!

%include "typemaps.i"
%include "gsl_typemaps.i"

%{
    #include "gsl/gsl_math.h"
    #include "gsl/gsl_deriv.h"
%}

%include "gsl/gsl_math.h"
%include "gsl/gsl_deriv.h"
%include "../pod/Deriv.pod"
