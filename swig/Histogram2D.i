%module "Math::GSL::Histogram2D"
%include "typemaps.i"
%include "gsl_typemaps.i"
%include "renames.i"

%apply double *OUTPUT { double * xlower, double * xupper, double * ylower, double * yupper, double * x, double * y};
%apply int *OUTPUT { size_t * i, size_t * j };

%{
    #include "gsl/gsl_histogram2d.h"
%}

%include "gsl/gsl_histogram2d.h"
%include "../pod/Histogram2D.pod"
