%module "Math::GSL::Machine"

%{
    #include "gsl/gsl_machine.h"
%}

%include "gsl/gsl_machine.h"
%include "../pod/Machine.pod"
%include "gsl_typemaps.i"
