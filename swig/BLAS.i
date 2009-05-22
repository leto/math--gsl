%module "Math::GSL::BLAS"

%include "typemaps.i"
%include "gsl_typemaps.i"
%include "gsl/gsl_blas.h"
%include "gsl/gsl_blas_types.h"
%include "../pod/BLAS.pod"

%{
    #include "gsl/gsl_blas.h"
    #include "gsl/gsl_blas_types.h"
%}

