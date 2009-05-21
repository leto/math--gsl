%module "Math::GSL::Histogram2D"
%include "typemaps.i"
%include "gsl_typemaps.i"

%{
    #include "gsl/gsl_histogram2d.h"
%}

%include "gsl/gsl_histogram2d.h"
%include "../pod/Histogram2D.pod"
