%module "Math::GSL::Eigen"
%include "typemaps.i"
%include "gsl_typemaps.i"
%{
    #include "gsl/gsl_eigen.h"
    #include "gsl/gsl_complex.h"
    #include "gsl/gsl_vector_complex.h"
%}

%include "gsl/gsl_eigen.h"
%include "gsl/gsl_complex.h"
%include "gsl/gsl_vector_complex.h"
%include "../pod/Eigen.pod"
