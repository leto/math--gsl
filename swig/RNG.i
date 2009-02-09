%module "Math::GSL::RNG"
%include "system.i"
%{
    #include "gsl/gsl_rng.h"
%}
#if GSL_MINOR_VERSION == 12
    %import "gsl/gsl_inline.h"
#endif
%import "gsl/gsl_types.h"

%include "gsl/gsl_rng.h"
%include "../pod/RNG.pod"
