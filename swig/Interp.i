%module "Math::GSL::Interp"

%include "typemaps.i"
%include "gsl_typemaps.i"
%include "system.i"

%apply double *OUTPUT { double * y, double * d, double * d2, double * result };

%{
    #include "gsl/gsl_types.h"
    #include "gsl/gsl_interp.h"
%}
#if GSL_MINOR_VERSION == 12
    %import "gsl/gsl_inline.h"
#endif

%include "gsl/gsl_types.h"
%include "gsl/gsl_interp.h"

%include "../pod/Interp.pod"
