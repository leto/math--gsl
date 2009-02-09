%module "Math::GSL::Vector"
%include "typemaps.i"
%include "gsl_typemaps.i"
%include "system.i"

FILE * fopen(char *, char *);
int fclose(FILE *);

%{
    #include "gsl/gsl_nan.h"
    #include "gsl/gsl_vector.h"
    #include "gsl/gsl_vector_char.h"
    #include "gsl/gsl_vector_complex.h"
    #include "gsl/gsl_vector_complex_double.h"
    #include "gsl/gsl_vector_double.h"
    #include "gsl/gsl_vector_float.h"
    #include "gsl/gsl_vector_int.h"
%}
#if GSL_MINOR_VERSION == 12
    %import "gsl/gsl_inline.h"
#endif

%include "gsl/gsl_nan.h"
%include "gsl/gsl_vector.h"
%include "gsl/gsl_vector_char.h"
%include "gsl/gsl_vector_complex.h"
%include "gsl/gsl_vector_complex_double.h"
%include "gsl/gsl_vector_double.h"
%include "gsl/gsl_vector_int.h"

%include "../pod/Vector.pod"
