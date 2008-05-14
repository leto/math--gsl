%module Multifit
%{
    #include "/usr/local/include/gsl/gsl_types.h"
    #include "/usr/local/include/gsl/gsl_multifit.h"
    #include "/usr/local/include/gsl/gsl_multifit_nlin.h"
%}

%include "/usr/local/include/gsl/gsl_types.h"
%include "/usr/local/include/gsl/gsl_multifit.h"
%include "/usr/local/include/gsl/gsl_multifit_nlin.h"
