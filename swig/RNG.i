%module "Math::GSL::RNG"
%{
    #include "gsl/gsl_rng.h"
%}
%import "gsl/gsl_types.h"

%include "gsl/gsl_rng.h"
%include "../pod/RNG.pod"
