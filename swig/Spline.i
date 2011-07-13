%module "Math::GSL::Spline"

%include "typemaps.i"
%include "gsl_typemaps.i"
%include "renames.i"

%apply double *OUTPUT { double * y, double * d, double * d2, double * result };

%{
    #include "gsl/gsl_spline.h"
%}

%include "gsl/gsl_spline.h"

%include "../pod/Spline.pod"
