%module "Math::GSL::ODEIV"
%include "gsl_typemaps.i"
%{
    #include "gsl/gsl_odeiv.h"
    #include "gsl/gsl_types.h"
%}
%include "gsl/gsl_types.h"
%include "gsl/gsl_odeiv.h"
%include "../pod/ODEIV.pod"
