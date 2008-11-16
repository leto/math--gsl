%module "Math::GSL::Eigen"
%{
    #include "gsl/gsl_eigen.h"
    #include "gsl/gsl_complex.h"
    #include "gsl/gsl_vector_complex.h"
%}

%include "gsl/gsl_eigen.h"
%include "gsl/gsl_complex.h"
%include "gsl/gsl_vector_complex.h"
%include "../pod/Eigen.pod"
