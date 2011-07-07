%module "Math::GSL::Machine"
%include "renames.i"

%{
    #include "gsl/gsl_machine.h"
%}

%include "gsl/gsl_machine.h"
%include "../pod/Machine.pod"
%include "gsl_typemaps.i"
