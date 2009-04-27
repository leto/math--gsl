%module "Math::GSL::Sort"
/* Danger Will Robinson! */

%include "typemaps.i"
%include "gsl_typemaps.i"

%{
    #include "gsl/gsl_nan.h"
    #include "gsl/gsl_sort.h"
    #include "gsl/gsl_sort_double.h"
    #include "gsl/gsl_sort_int.h"
    #include "gsl/gsl_sort_vector.h"
    #include "gsl/gsl_sort_vector_double.h"
    #include "gsl/gsl_sort_vector_int.h"
    #include "gsl/gsl_permutation.h"
%}

%include "gsl/gsl_nan.h"
%include "gsl/gsl_sort.h"
%include "gsl/gsl_sort_double.h"
%include "gsl/gsl_sort_int.h"
%include "gsl/gsl_sort_vector.h"
%include "gsl/gsl_sort_vector_double.h"
%include "gsl/gsl_sort_vector_int.h"
%include "gsl/gsl_permutation.h"

%include "../pod/Sort.pod"
