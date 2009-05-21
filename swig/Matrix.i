// Red Pill or Blue Pill ?
%module "Math::GSL::Matrix"

%include "typemaps.i"
%include "gsl_typemaps.i"

%{
    #include "gsl/gsl_matrix.h"
    #include "gsl/gsl_complex.h"
    #include "gsl/gsl_vector_double.h"
    #include "gsl/gsl_matrix_double.h"
    #include "gsl/gsl_matrix_int.h"
    #include "gsl/gsl_matrix_complex_double.h"
    #include "gsl/gsl_matrix_char.h" 
%}
%include "gsl/gsl_matrix.h"
%include "gsl/gsl_complex.h"
%include "gsl/gsl_vector_double.h"
%include "gsl/gsl_matrix_double.h"
%include "gsl/gsl_matrix_int.h"
%include "gsl/gsl_matrix_complex_double.h"
%include "gsl/gsl_matrix_char.h"

%include "../pod/Matrix.pod" 
