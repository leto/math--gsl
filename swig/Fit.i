%module "Math::GSL::Fit"
%include "typemaps.i"
%include "gsl_typemaps.i"

%apply double *OUTPUT { double * c0, double * c1, double * cov00, double * cov01, double * cov11, double * sumsq, double * chisq };

%{
    #include "gsl/gsl_fit.h"
%}

%include "gsl/gsl_fit.h"
%include "../pod/Fit.pod"
