%module "Math::GSL::Heapsort"
%include "typemaps.i"
%include "gsl_typemaps.i"
%include "system.i"

%{
    #include "gsl/gsl_heapsort.h"
    #include "gsl/gsl_permutation.h"
%}
#if GSL_MINOR_VERSION == 12
    %import "gsl/gsl_inline.h"
#endif

%include "gsl/gsl_permutation.h"
%include "gsl/gsl_heapsort.h"
%include "../pod/Heapsort.pod"
