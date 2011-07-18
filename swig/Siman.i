%module "Math::GSL::Siman"
%include "typemaps.i"
%include "gsl_typemaps.i"
%include "renames.i"

%{
    #include "gsl/gsl_siman.h"
%}

%include "gsl/gsl_siman.h"
%include "../pod/Siman.pod"
