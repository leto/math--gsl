%module "Math::GSL::Sys"

%include "typemaps.i"
%apply int *OUTPUT { int * e };

%{
    #include "gsl/gsl_sys.h"
%}
%include "gsl/gsl_sys.h"
%include "../pod/Sys.pod"
