%module Randist
%{
#include "/usr/local/include/gsl/gsl_randist.h"
extern double gsl_ran_hypergeometric_pdf (const unsigned int k, const unsigned int n1, const unsigned int n2, unsigned int t);
extern double gsl_ran_laplace_pdf (const double x, const double a);
extern double gsl_ran_gaussian_pdf (const double x, const double sigma);
%}

%include "/usr/local/include/gsl/gsl_randist.h"

%perlcode %{

our @EXPORT_OK = qw/ gsl_ran_hypergeometric_pdf gsl_ran_laplace_pdf gsl_ran_gaussian_pdf
                /;
our %EXPORT_TAGS = ( all =>  [  @EXPORT_OK ] );
%}
