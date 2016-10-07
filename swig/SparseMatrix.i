%module "Math::GSL::SparseMatrix"

%include "typemaps.i"
%include "gsl_typemaps.i"
%include "renames.i"
%include "system.i"

%{
    #include "gsl/gsl_spmatrix.h"
%}


%include "gsl/gsl_spmatrix.h"

%include "../pod/SparseMatrix.pod"
