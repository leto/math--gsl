%module "Math::GSL::Errno"
%include "typemaps.i"
%include "gsl_typemaps.i"
%include "renames.i"

%{
    #include "gsl/gsl_errno.h"
    #include "gsl/gsl_types.h"
%}

%apply const char* format {
  const char * label,
  const char * reason,
  const char * file
};

%include "gsl/gsl_errno.h"
%include "gsl/gsl_types.h"
%include "../pod/Errno.pod"
