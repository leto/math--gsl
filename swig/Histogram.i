%module "Math::GSL::Histogram"
%include "typemaps.i"
%include "gsl_typemaps.i"

%apply double *OUTPUT { double * lower, double * upper, size_t * i};

%{
    #include "gsl/gsl_histogram.h"
%}

%include "gsl/gsl_histogram.h"
%include "../pod/Histogram.pod"
