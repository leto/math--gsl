%module Math
%{
#include "/usr/local/include/gsl/gsl_math.h"
%}

%include "/usr/local/include/gsl/gsl_math.h"

%perlcode %{
@EXPORT_OK = qw/
               $M_PI
               $M_LN2
             /;
%EXPORT_TAGS = ( all => [ @EXPORT_OK ] );
%}
