%module Function
%{
#include "/usr/local/include/gsl/gsl_math.h"
%}

%include "/usr/local/include/gsl/gsl_math.h"

%perlcode %{

@EXPORT_OK = qw(gsl_max gsl_min);

%}
