%module "Math::GSL::Complex"
%include "typemaps.i"
%include "gsl_typemaps.i"
%include "system.i"
%{
    #include "gsl/gsl_complex.h"
    #include "gsl/gsl_complex_math.h"
%}
#if GSL_MINOR_VERSION == 12
    %import "gsl/gsl_inline.h"
#endif

%include "gsl/gsl_complex.h"
%include "gsl/gsl_complex_math.h"

// Need to fix this interface
%include "carrays.i"
%array_functions(double, doubleArray);

%include "../pod/Complex.pod"
