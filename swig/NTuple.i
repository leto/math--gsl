%module "Math::GSL::NTuple"
%include "typemaps.i"
%include "gsl_typemaps.i"

%{
    #include "gsl/gsl_ntuple.h"
    #include "gsl/gsl_errno.h"
    #include "gsl/gsl_histogram.h"
%}

%include "gsl/gsl_ntuple.h"
%include "gsl/gsl_histogram.h"

%include "../pod/NTuple.pod"
