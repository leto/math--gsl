%module "Math::GSL::Interp"

%include "typemaps.i"
%include "gsl_typemaps.i"

%apply double *OUTPUT { double * y, double * d, double * d2, double * result };

%{
    #include "gsl/gsl_types.h"
    #include "gsl/gsl_interp.h"
%}
%include "gsl/gsl_types.h"
%include "gsl/gsl_interp.h"

%include "../pod/Interp.pod"
