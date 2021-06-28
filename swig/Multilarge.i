%module "Math::GSL::Multilarge"

%include "typemaps.i"
%include "gsl_typemaps.i"
%include "renames.i"

%apply double *OUTPUT { double *rnorm, double *snorm };

%ignore gsl_multifit_fdfsolver_dif_fdf;

%{
    #include "gsl/gsl_inline.h"
    #include "gsl/gsl_types.h"
    #include "gsl/gsl_math.h"
    #include "gsl/gsl_vector.h"
    #include "gsl/gsl_matrix.h"
    #include "gsl/gsl_permutation.h"
    #include "gsl/gsl_multifit.h"
    #include "gsl/gsl_multilarge.h"
%}
%include "gsl/gsl_inline.h"
%include "gsl/gsl_types.h"
%include "gsl/gsl_math.h"
%include "gsl/gsl_vector.h"
%include "gsl/gsl_matrix.h"
%include "gsl/gsl_permutation.h"
%include "gsl/gsl_multifit.h"
#if MG_GSL_NUM_VERSION >= 002007
  %include "gsl/gsl_multilarge.h"
#else
  %include "legacy/gsl-2.6/gsl_multilarge.h"
#endif
%include "../pod/Multifit.pod"
