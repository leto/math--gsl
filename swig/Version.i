%module "Math::GSL::Version"
%include "system.i"
%{
    #include "gsl/gsl_types.h"
    #include "gsl/gsl_version.h"
%}
%ignore gsl_version;
%include "gsl/gsl_types.h"
