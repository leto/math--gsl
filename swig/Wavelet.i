%module "Math::GSL::Wavelet"
%include "typemaps.i"
%include "gsl_typemaps.i"
%include "renames.i"

%{
    #include "gsl/gsl_types.h"
    #include "gsl/gsl_wavelet.h"
%}

%include "gsl/gsl_types.h"
%include "gsl/gsl_wavelet.h"

%include "../pod/Wavelet.pod"
