%module "Math::GSL::Sum"
%include "gsl_typemaps.i"

%{
    #include "gsl/gsl_sum.h"
%}

%include "gsl/gsl_sum.h"
%include "../pod/Sum.pod"
