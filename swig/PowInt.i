%module "Math::GSL::PowInt"
%{
    #include "gsl/gsl_pow_int.h"
%}
%import "gsl/gsl_inline.h"

%include "gsl/gsl_pow_int.h"
%include "../pod/PowInt.pod"
