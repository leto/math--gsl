%module "Math::GSL::IEEEUtils"
%{
    #include "gsl/gsl_ieee_utils.h"
%}

%include "gsl/gsl_ieee_utils.h"
%include "../pod/IEEEUtils.pod"
