%module "Math::GSL::Linalg"
%include "gsl_typemaps.i"
%include "renames.i"

%apply int *OUTPUT { int *signum };
%apply double *OUTPUT { double *c, double *s };

%{
    #include "gsl/gsl_inline.h"
    #include "gsl/gsl_linalg.h"
    #include "gsl/gsl_permutation.h"
    #include "gsl/gsl_complex.h"
    #include "gsl/gsl_complex_math.h"
%}

%include "gsl/gsl_inline.h"
%include "gsl/gsl_linalg.h"
%include "gsl/gsl_permutation.h"
%include "gsl/gsl_complex.h"
%include "gsl/gsl_complex_math.h"
%include "../pod/Linalg.pod"
