%module "Math::GSL::Multifit"

%include "typemaps.i"
%include "gsl_typemaps.i"

%{
    #include "gsl/gsl_types.h"
    #include "gsl/gsl_multifit.h"
    #include "gsl/gsl_multifit_nlin.h"
%}

%include "gsl/gsl_types.h"
%include "gsl/gsl_multifit.h"
%include "gsl/gsl_multifit_nlin.h"
%include "../pod/Multifit.pod"
