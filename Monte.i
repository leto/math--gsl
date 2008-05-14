%module Monte
%{
#include "/usr/local/include/gsl/gsl_monte.h"
#include "/usr/local/include/gsl/gsl_monte_miser.h"
#include "/usr/local/include/gsl/gsl_monte_plain.h"
#include "/usr/local/include/gsl/gsl_monte_vegas.h"
%}

%include "/usr/local/include/gsl/gsl_monte.h"
%include "/usr/local/include/gsl/gsl_monte_miser.h"
%include "/usr/local/include/gsl/gsl_monte_plain.h"
%include "/usr/local/include/gsl/gsl_monte_vegas.h"

