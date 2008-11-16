%module "Math::GSL::Sum"
%include "gsl_typemaps.i"

%apply double *OUTPUT { double * sum_accel, double * abserr, double * abserr_trunc };

%{
    #include "gsl/gsl_sum.h"
%}

%include "gsl/gsl_sum.h"
%include "../pod/Sum.pod"
