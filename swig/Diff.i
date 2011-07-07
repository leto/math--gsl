%module "Math::GSL::Diff"
%include "typemaps.i"
%include "gsl_typemaps.i"
%include "renames.i"

%{
    #include "gsl/gsl_diff.h"
%}

%include "gsl/gsl_diff.h"
%include "../pod/Diff.pod"
