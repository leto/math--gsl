%module "Math::GSL::BSpline"
%include "typemaps.i"
%include "gsl_typemaps.i"
%include "renames.i"
%include "gsl/gsl_bspline.h"
%include "gsl/gsl_vector.h"
%include "../pod/BSpline.pod"

%{
    #include "gsl/gsl_bspline.h"
    #include "gsl/gsl_vector.h"
%}


