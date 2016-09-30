%module "Math::GSL::Interp"

%include "typemaps.i"
%include "gsl_typemaps.i"
%include "renames.i"
%include "system.i"

%apply double *OUTPUT { double * y, double * d, double * d2, double * result };

%{
    #include "gsl/gsl_inline.h"
    #include "gsl/gsl_types.h"
    #include "gsl/gsl_version.h"
    #include "gsl/gsl_interp.h"
%}

%inline %{
#if defined GSL_MAJOR_VERSION && (GSL_MAJOR_VERSION < 2)
    GSL_VAR const gsl_interp_type * gsl_interp_steffen;
#endif
%}

%ignore gsl_interp_type;

%include "gsl/gsl_inline.h"
%include "gsl/gsl_types.h"
%include "gsl/gsl_version.h"
%include "gsl/gsl_interp.h"

%include "../pod/Interp.pod"
