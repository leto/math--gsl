%module "Math::GSL::IEEEUtils"
%include "gsl_typemaps.i"
%{
    #include "gsl/gsl_ieee_utils.h"
%}

%apply const char* format {
    const char* description
};

%include "gsl/gsl_ieee_utils.h"
%include "../pod/IEEEUtils.pod"
