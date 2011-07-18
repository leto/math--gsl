%module "Math::GSL::Roots"
%include "gsl_typemaps.i"
%include "typemaps.i"
%include "renames.i"

%{
    #include "gsl/gsl_types.h"
    #include "gsl/gsl_roots.h"
%}
%include "gsl/gsl_types.h"
%include "gsl/gsl_roots.h"
%include "../pod/Roots.pod"
