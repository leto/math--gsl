%module "Math::GSL::CBLAS"
%include "typemaps.i"
%include "gsl_typemaps.i"

%apply double const [] { const double * };
%apply float const [] { const float * };

%{
    #include "gsl/gsl_cblas.h"
%}

%ignore cblas_xerbla;

%include "gsl/gsl_cblas.h"
%include "../pod/CBLAS.pod"
