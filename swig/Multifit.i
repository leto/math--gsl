%module "Math::GSL::Multifit"

%include "typemaps.i"
%include "gsl_typemaps.i"
%include "renames.i"

%apply double *OUTPUT { double * y, double * y_err, double * chisq,  size_t * rank};

%{
    #include "gsl/gsl_inline.h"
    #include "gsl/gsl_types.h"
    #include "gsl/gsl_math.h"
    #include "gsl/gsl_vector.h"
    #include "gsl/gsl_matrix.h"
    #include "gsl/gsl_permutation.h"
    #include "gsl/gsl_multifit.h"
%}

%include "gsl/gsl_inline.h"
%include "gsl/gsl_types.h"
%include "gsl/gsl_math.h"
%include "gsl/gsl_vector.h"
%include "gsl/gsl_matrix.h"
%include "gsl/gsl_permutation.h"
%include "gsl/gsl_multifit.h"
%include "../pod/Multifit.pod"
