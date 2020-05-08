%module "Math::GSL::Multifit"

%include "typemaps.i"
%include "gsl_typemaps.i"
%include "renames.i"
%include "system.i"

%apply double *OUTPUT { double * y, double * y_err, double * chisq,  size_t * rank};

%ignore gsl_multifit_fdfsolver_dif_fdf;

%{
    #include "gsl/gsl_inline.h"
    #include "gsl/gsl_types.h"
    #include "gsl/gsl_version.h"
    #include "gsl/gsl_math.h"
    #include "gsl/gsl_vector.h"
    #include "gsl/gsl_matrix.h"
    #include "gsl/gsl_permutation.h"
    #include "gsl/gsl_multifit.h"
    #include "gsl/gsl_multifit_nlin.h"
%}

%inline %{
#if defined GSL_MAJOR_VERSION && (GSL_MAJOR_VERSION < 2)
    /* TOTAL HACKERY TO GET THINGS TO COMPILE on 1.15 and 1.16 */
    GSL_VAR const gsl_multifit_fdfsolver_type * gsl_multifit_fdfsolver_lmniel;
#endif
%}

%include "gsl/gsl_inline.h"
%include "gsl/gsl_types.h"
%include "gsl/gsl_math.h"
%include "gsl/gsl_vector.h"
%include "gsl/gsl_matrix.h"
%include "gsl/gsl_permutation.h"
%include "gsl/gsl_multifit.h"
%include "gsl/gsl_multifit_nlin.h"
%include "../pod/Multifit.pod"
