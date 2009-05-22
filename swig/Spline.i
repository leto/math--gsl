%module "Math::GSL::Spline"

%include "typemaps.i"
%include "gsl_typemaps.i"

%{
    #include "gsl/gsl_spline.h"
%}

%include "gsl/gsl_spline.h"

%include "../pod/Spline.pod"
