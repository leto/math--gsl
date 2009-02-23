%module "Math::GSL::PowInt"
%include "gsl_typemaps.i"
%{
    #include "gsl/gsl_pow_int.h"
%}

%include "gsl/gsl_pow_int.h"
%include "../pod/PowInt.pod"
