%module "Math::GSL::Combination"
%include "typemaps.i"
%include "gsl_typemaps.i"
%include "renames.i"

%{
    #include <gsl/gsl_errno.h>
    #include "gsl/gsl_types.h"
    #include <gsl/gsl_inline.h>
    #include <gsl/gsl_check_range.h>
    #include "gsl/gsl_combination.h"
%}

%include "gsl/gsl_errno.h"
%include "gsl/gsl_types.h"
%include "gsl/gsl_inline.h"
%include "gsl/gsl_check_range.h"
%include "gsl/gsl_combination.h"
%include "../pod/Combination.pod"
