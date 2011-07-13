%module "Math::GSL::Chebyshev"
%include "typemaps.i"
%include "gsl_typemaps.i"
%include "renames.i"

%{
    #include "gsl/gsl_chebyshev.h"
    #include "gsl/gsl_math.h"
    #include "gsl/gsl_mode.h"
%}
%include "gsl/gsl_chebyshev.h"
%include "gsl/gsl_math.h"
%include "gsl/gsl_mode.h"
%include "../pod/Chebyshev.pod"
