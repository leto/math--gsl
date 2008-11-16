%module "Math::GSL::CBLAS"
%include "typemaps.i"
%include "gsl_typemaps.i"

%apply double *INPUT { float const *X };
%apply float *INPUT  { double const *X };
%apply double *OUTPUT { float *C };

%{
    #include "gsl/gsl_cblas.h"
%}

%include "gsl/gsl_cblas.h"
%include "../pod/CBLAS.pod"
