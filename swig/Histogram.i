%module "Math::GSL::Histogram"
%include "typemaps.i"
%include "gsl_typemaps.i"

%{
    #include "gsl/gsl_histogram.h"
%}

%include "gsl/gsl_histogram.h"
%include "../pod/Histogram.pod"
