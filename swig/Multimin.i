%module "Math::GSL::Multimin"

%include "typemaps.i"
%include "gsl_typemaps.i"
%{
    #include "gsl/gsl_types.h"
    #include "gsl/gsl_multimin.h"
%}

%include "gsl/gsl_types.h"
%include "gsl/gsl_multimin.h"
%include "../pod/Multimin.pod"
