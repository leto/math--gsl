%module "Math::GSL::SparseMatrix"

%include "typemaps.i"
%include "gsl_typemaps.i"
%include "renames.i"
%include "system.i"

%{
    #include "gsl/gsl_spmatrix.h"
%}

#if MG_GSL_NUM_VERSION >= 002006
// ignore gsl_spmatrix_uchar_norm1, gsl_spmatrix_char_norm1, ...
  %rename("%(regex:/^gsl_spmatrix_.+_norm1$/$ignore/)s") "";
  %include "gsl/gsl_spmatrix.h"
  %include "gsl/gsl_spmatrix_double.h"
  %include "gsl/gsl_spmatrix_complex_long_double.h"
  %include "gsl/gsl_spmatrix_complex_float.h"
  %include "gsl/gsl_spmatrix_long_double.h"
  %include "gsl/gsl_spmatrix_uint.h"
  %include "gsl/gsl_spmatrix_double.h"
  %include "gsl/gsl_spmatrix_complex_double.h"
  %include "gsl/gsl_spmatrix_char.h"
  %include "gsl/gsl_spmatrix_uchar.h"
  %include "gsl/gsl_spmatrix_int.h"
  %include "gsl/gsl_spmatrix_short.h"
  %include "gsl/gsl_spmatrix_float.h"
  %include "gsl/gsl_spmatrix_ushort.h"
#else
  %include "legacy/gsl-2.5/gsl_spmatrix.h"
#endif


%include "../pod/SparseMatrix.pod"
