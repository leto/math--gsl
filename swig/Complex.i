%module "Math::GSL::Complex"
%include "typemaps.i"
%include "gsl_typemaps.i"
%include "renames.i"

%{
    #include "gsl/gsl_complex.h"
    #include "gsl/gsl_complex_math.h"
%}

%include "gsl/gsl_complex.h"
%include "gsl/gsl_complex_math.h"

// Need to fix this interface
%include "carrays.i"
%array_functions(double, doubleArray);

%include "../pod/Complex.pod"
