%module "Math::GSL::Linalg"
%include "gsl_typemaps.i"

%apply int *OUTPUT { int *signum };
%include "system.i"

%{
    #include "gsl/gsl_linalg.h"
    #include "gsl/gsl_permutation.h"
    #include "gsl/gsl_complex.h"
    #include "gsl/gsl_complex_math.h"
%}
#if GSL_MINOR_VERSION == 12
    %import "gsl/gsl_inline.h"
#endif

%include "gsl/gsl_linalg.h"
%include "gsl/gsl_permutation.h"
%include "gsl/gsl_complex.h"
%include "gsl/gsl_complex_math.h"
%include "../pod/Linalg.pod"
