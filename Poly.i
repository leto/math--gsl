%module Poly
%{
#include "/usr/local/include/gsl/gsl_poly.h"
#include "/usr/local/include/gsl/gsl_complex.h"
%}

%include "/usr/local/include/gsl/gsl_poly.h"
%include "/usr/local/include/gsl/gsl_complex.h"

%include "carrays.i"
%array_functions(double, doubleArray);

double gsl_poly_eval(double c[], int len, double x);
