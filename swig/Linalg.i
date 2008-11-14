%module "Math::GSL::Linalg"
%apply int *OUTPUT { int *signum };

%{
    #include "gsl/gsl_linalg.h"
    #include "gsl/gsl_permutation.h"
%}

%include "gsl/gsl_linalg.h"
%include "gsl/gsl_permutation.h"
%include "../pod/Linalg.pod"
