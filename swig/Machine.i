%module "Math::GSL::Machine"
%include "typemaps.i"

%{
    #include "gsl/gsl_machine.h"
%}

%include "gsl/gsl_machine.h"
%include "../pod/Machine.pod"
