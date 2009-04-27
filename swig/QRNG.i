%module "Math::GSL::QRNG"
%include "typemaps.i"
%include "gsl_typemaps.i"

%{
    #include "gsl/gsl_types.h"
    #include "gsl/gsl_qrng.h"
%}

%include "gsl/gsl_types.h"
%include "gsl/gsl_qrng.h"
%include "../pod/QRNG.pod"
