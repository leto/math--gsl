%module "Math::GSL::BLAS"

%apply float *OUTPUT { float *result };
%apply double *OUTPUT { double *result };
%apply double *OUTPUT { double c[], double s[] };

%include "typemaps.i"
%include "gsl_typemaps.i"
%include "renames.i"
%include "gsl/gsl_blas.h"
%include "gsl/gsl_blas_types.h"
%include "../pod/BLAS.pod"

%{
    #include "gsl/gsl_blas.h"
    #include "gsl/gsl_blas_types.h"
%}

