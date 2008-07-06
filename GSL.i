%module "Math::GSL"
%{
    #include "/usr/local/include/gsl/gsl_sys.h"
%}

%include "/usr/local/include/gsl/gsl_sys.h"

%perlcode %{

our $GSL_VERSION = '1.11';

%}

