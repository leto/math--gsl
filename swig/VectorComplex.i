%module "Math::GSL::VectorComplex"
%include "typemaps.i"
%include "gsl_typemaps.i"
%include "renames.i"

%{
    #include "gsl/gsl_nan.h"
    #include "gsl/gsl_complex.h"
    #include "gsl/gsl_vector.h"
    #include "gsl/gsl_vector_double.h"
    #include "gsl/gsl_vector_complex.h"
    #include "gsl/gsl_vector_complex_double.h"
%}

%include "gsl/gsl_nan.h"
%include "gsl/gsl_complex.h"
%include "gsl/gsl_vector.h"
%include "gsl/gsl_vector_double.h"
%include "gsl/gsl_vector_complex.h"
%include "gsl/gsl_vector_complex_double.h"
%include "../pod/VectorComplex.pod"
