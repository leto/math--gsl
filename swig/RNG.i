%module "Math::GSL::RNG"
%include "gsl_typemaps.i"
%include "renames.i"

%{
    #include "gsl/gsl_rng.h"
%}
%import "gsl/gsl_types.h"

%include "gsl/gsl_rng.h"
%include "../pod/RNG.pod"
