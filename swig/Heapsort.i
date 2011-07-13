%module "Math::GSL::Heapsort"
%include "typemaps.i"
%include "gsl_typemaps.i"
%include "renames.i"

%{
    #include "gsl/gsl_heapsort.h"
    #include "gsl/gsl_permutation.h"
%}

%include "gsl/gsl_permutation.h"
%include "gsl/gsl_heapsort.h"
%include "../pod/Heapsort.pod"
