%module "Math::GSL::Wavelet2D"
%include "typemaps.i"
%include "gsl_typemaps.i"

%{
    #include "gsl/gsl_types.h"
    #include "gsl/gsl_wavelet2d.h"
%}

%include "gsl/gsl_types.h"
%include "gsl/gsl_wavelet2d.h"
%include "../pod/Wavelet2D.pod"
