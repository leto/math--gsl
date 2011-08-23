%module "Math::GSL::Version"
%{
    #include "gsl/gsl_types.h"
    #include "gsl/gsl_version.h"
%}
%ignore gsl_version;
%include "gsl/gsl_types.h"
%include "gsl/gsl_version.h"
