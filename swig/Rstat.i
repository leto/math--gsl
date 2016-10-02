%module "Math::GSL::Rstat"

%include "typemaps.i"
%include "gsl_typemaps.i"
%include "renames.i"

%{
    #include "gsl/gsl_rstat.h"
%}

%include "gsl/gsl_rstat.h"

%include "../pod/Rstat.pod"
