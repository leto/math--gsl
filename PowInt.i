%module PowInt
%{
#include "/usr/local/include/gsl/gsl_pow_int.h"
%}

%include "/usr/local/include/gsl/gsl_pow_int.h"

%perlcode %{
    package Math::GSL::PowInt;
    use base 'Math::GSL';
    require Exporter;
    require DynaLoader;

    our @ISA = qw(Exporter);
    our @EXPORT = qw();
    our @EXPORT_OK = qw/ gsl_pow_2 gsl_pow_2 gsl_pow_3 
                     gsl_pow_4 gsl_pow_5 gsl_pow_6 
                     gsl_pow_7 gsl_pow_8 gsl_pow_9 
                  /;
    our %EXPORT_TAGS = ( all =>  [ 
                              qw/
                                  gsl_pow_2 gsl_pow_2 gsl_pow_3 
                                  gsl_pow_4 gsl_pow_5 gsl_pow_6
                                  gsl_pow_7 gsl_pow_8 gsl_pow_9
                               /  
                             ] );

%}
