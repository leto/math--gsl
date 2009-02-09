%module "Math::GSL::Permutation"
%include "typemaps.i"
%include "gsl_typemaps.i"
%include "system.i"

%{
    #include "gsl/gsl_permute.h"
    #include "gsl/gsl_permute_double.h"
    #include "gsl/gsl_permute_int.h"
    #include "gsl/gsl_permute_vector.h"
    #include "gsl/gsl_permute_vector_double.h"
    #include "gsl/gsl_permute_vector_int.h"
    #include "gsl/gsl_permutation.h"
%}
#if GSL_MINOR_VERSION == 12
    %import "gsl/gsl_inline.h"
#endif

%include "gsl/gsl_permute.h"
%include "gsl/gsl_permute_double.h"
%include "gsl/gsl_permute_int.h"
%include "gsl/gsl_permute_vector.h"
%include "gsl/gsl_permute_vector_double.h"
%include "gsl/gsl_permute_vector_int.h"
%include "gsl/gsl_permutation.h"
%include "../pod/Permutation.pod"
