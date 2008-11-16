%module "Math::GSL::Monte"
%include "gsl/gsl_monte.h"
%include "gsl/gsl_monte_miser.h"
%include "gsl/gsl_monte_plain.h"
%include "gsl/gsl_monte_vegas.h"
%include "gsl/gsl_types.h"
%include "gsl/gsl_errno.h"
%include "typemaps.i"
%include "gsl_typemaps.i"

%{
    #include "gsl/gsl_monte.h"
    #include "gsl/gsl_monte_miser.h"
    #include "gsl/gsl_monte_plain.h"
    #include "gsl/gsl_monte_vegas.h"
    #include "gsl/gsl_types.h"
    #include "gsl/gsl_errno.h"
%}
%include "../pod/Monte.pod"
