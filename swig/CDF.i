%module "Math::GSL::CDF"
%include "typemaps.i"
%include "gsl_typemaps.i"
%include "renames.i"

%{
#include "gsl/gsl_cdf.h"
%}

%include "gsl/gsl_cdf.h"
%include "../pod/CDF.pod"
