%module "Math::GSL::Fit"
%include "typemaps.i"
%include "gsl_typemaps.i"

%{
    #include "gsl/gsl_fit.h"
%}

%include "gsl/gsl_fit.h"
%include "../pod/Fit.pod"
