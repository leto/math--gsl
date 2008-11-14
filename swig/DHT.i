%module "Math::GSL::DHT"
%include "typemaps.i"
%include "gsl_typemaps.i"

%{
    #include "gsl/gsl_dht.h"
%}

%include "gsl/gsl_dht.h"
%include "../pod/DHT.pod"
