%module "Math::GSL::BSpline"
%include "typemaps.i"
%include "gsl_typemaps.i"
%include "renames.i"

#define  GSL_DISABLE_DEPRECATED 1

%include "gsl/gsl_math.h"
%include "gsl/gsl_vector.h"
%include "gsl/gsl_bspline.h"
%include "../pod/BSpline.pod"

%{
    #include "gsl/gsl_math.h"
    #include "gsl/gsl_vector.h"
    #include "gsl/gsl_bspline.h"
%}


