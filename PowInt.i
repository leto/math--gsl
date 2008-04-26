%module PowInt
%{
#include "/usr/local/include/gsl/gsl_pow_int.h"
%}

%include "/usr/local/include/gsl/gsl_pow_int.h"

%perlcode %{

our @EXPORT_OK = qw/ gsl_pow_2 gsl_pow_2 gsl_pow_3 
                    gsl_pow_4 gsl_pow_5 gsl_pow_6 
                    gsl_pow_7 gsl_pow_8 gsl_pow_9 
                /;
our %EXPORT_TAGS = ( all =>  [  @EXPORT_OK ] );

%}
