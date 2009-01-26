%module "Math::GSL::Combination"
%include "typemaps.i"
%include "gsl_typemaps.i"
%{
    #include "gsl/gsl_types.h"
    #include "gsl/gsl_combination.h"
%}
#define TEST 1

#if TEST==1
    %import "gsl/gsl_inline.h"
#endif

%include "gsl/gsl_types.h"
%include "gsl/gsl_combination.h"
%include "../pod/Combination.pod"
