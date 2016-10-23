%module "Math::GSL::Multiset"

%include "typemaps.i"
%include "gsl_typemaps.i"
%include "renames.i"

%{
    #include "gsl/gsl_types.h"
    #include "gsl/gsl_inline.h"
    #include "gsl/gsl_multiset.h"
%}

%include "gsl/gsl_types.h"
%include "gsl/gsl_inline.h"
%include "gsl/gsl_multiset.h"
%include "../pod/Multiset.pod"
