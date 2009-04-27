%module "Math::GSL::Sys"

%include "typemaps.i"
%include "gsl_typemaps.i"

%{
    #include "gsl/gsl_sys.h"
%}
%include "gsl/gsl_sys.h"
%include "../pod/Sys.pod"
