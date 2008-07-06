%module "Math::GSL"
%{
    #include "gsl/gsl_sys.h"
%}

%include "gsl/gsl_sys.h"

%perlcode %{

our $GSL_VERSION = '1.11';

%}

