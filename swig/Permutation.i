%module "Math::GSL::Permutation"

%include "typemaps.i"
%include "gsl_typemaps.i"
%include "renames.i"

%{
    #include "gsl/gsl_inline.h"

    #include "gsl/gsl_permute_complex_long_double.h"
    #include "gsl/gsl_permute_complex_double.h"
    #include "gsl/gsl_permute_complex_float.h"

    #include "gsl/gsl_permute.h"
    #include "gsl/gsl_permute_long_double.h"
    #include "gsl/gsl_permute_double.h"
    #include "gsl/gsl_permute_float.h"

    #include "gsl/gsl_permute_ulong.h"
    #include "gsl/gsl_permute_long.h"

    #include "gsl/gsl_permute_int.h"
    #include "gsl/gsl_permute_uint.h"

    #include "gsl/gsl_permute_short.h"
    #include "gsl/gsl_permute_ushort.h"

    #include "gsl/gsl_permute_char.h"
    #include "gsl/gsl_permute_uchar.h"

    #include "gsl/gsl_permute_vector.h"
    #include "gsl/gsl_permute_vector_double.h"
    #include "gsl/gsl_permute_vector_int.h"
    #include "gsl/gsl_permute_vector_uint.h"
    #include "gsl/gsl_permute_vector_long.h"
    #include "gsl/gsl_permute_vector_long_double.h"
    #include "gsl/gsl_permute_vector_ulong.h"
    #include "gsl/gsl_permute_vector_short.h"
    #include "gsl/gsl_permute_vector_ushort.h"

    #include "gsl/gsl_permutation.h"
%}

%include "gsl/gsl_inline.h"
%include "gsl/gsl_permute_complex_long_double.h"
%include "gsl/gsl_permute_complex_double.h"
%include "gsl/gsl_permute_complex_float.h"
%include "gsl/gsl_permute.h"
%include "gsl/gsl_permute_long_double.h"
%include "gsl/gsl_permute_double.h"
%include "gsl/gsl_permute_int.h"
%include "gsl/gsl_permute_uint.h"
%include "gsl/gsl_permute_vector.h"
%include "gsl/gsl_permute_vector_double.h"
%include "gsl/gsl_permute_vector_int.h"
%include "gsl/gsl_permute_vector_uint.h"
%include "gsl/gsl_permute_vector_long.h"
%include "gsl/gsl_permute_vector_long_double.h"
%include "gsl/gsl_permute_vector_ulong.h"
%include "gsl/gsl_permute_vector_short.h"
%include "gsl/gsl_permute_vector_ushort.h"
%include "gsl/gsl_permutation.h"
%include "../pod/Permutation.pod"
