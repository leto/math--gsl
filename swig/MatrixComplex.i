// Red Pill or Blue Pill ?
%module "Math::GSL::MatrixComplex"

%include "typemaps.i"
%include "gsl_typemaps.i"
%apply int *OUTPUT { size_t *imin, size_t *imax, size_t *jmin, size_t *jmax };
%apply double *OUTPUT { double * min_out, double * max_out };
%include "system.i"

%{
    #include "gsl/gsl_matrix.h"
    #include "gsl/gsl_complex.h"
    #include "gsl/gsl_vector_double.h"
    #include "gsl/gsl_matrix_complex_double.h"
%}
#if GSL_MINOR_VERSION == 12
    %import "gsl/gsl_inline.h"
#endif

%include "gsl/gsl_matrix.h"
%include "gsl/gsl_complex.h"
%include "gsl/gsl_vector_double.h"
%include "gsl/gsl_matrix_complex_double.h"

%include "../pod/MatrixComplex.pod" 
