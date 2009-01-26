%module "Math::GSL::Complex"
%include "typemaps.i"
%include "gsl_typemaps.i"
%{
    #include "gsl/gsl_complex.h"
    #include "gsl/gsl_complex_math.h"
%}
%import "gsl/gsl_inline.h"

%include "gsl/gsl_complex.h"
%include "gsl/gsl_complex_math.h"

// Need to fix this interface
%include "carrays.i"
%array_functions(double, doubleArray);

%include "../pod/Complex.pod"
