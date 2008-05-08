%module Randist
%{
#include "/usr/local/include/gsl/gsl_randist.h"
%}

%include "/usr/local/include/gsl/gsl_randist.h"

%perlcode %{

our @EXPORT_OK = qw/ gsl_ran_hypergeometric_pdf gsl_ran_laplace_pdf gsl_ran_gaussian_pdf
                /;
our %EXPORT_TAGS = ( all =>  [  @EXPORT_OK ] );
%}
