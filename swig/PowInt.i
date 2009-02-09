%module "Math::GSL::PowInt"
%include "system.i"
%{
    #include "gsl/gsl_pow_int.h"
%}
#if GSL_MINOR_VERSION == 12
    %import "gsl/gsl_inline.h"
#endif

%include "gsl/gsl_pow_int.h"
%include "../pod/PowInt.pod"
