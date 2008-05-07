%module Poly
%{
#include "/usr/local/include/gsl/gsl_poly.h"
#include "/usr/local/include/gsl/gsl_complex.h"
%}

%include "/usr/local/include/gsl/gsl_poly.h"
%include "/usr/local/include/gsl/gsl_complex.h"

%include "carrays.i"
%array_functions(double, doubleArray);
%include "typemaps.i"

// I wish this typemap worked
%{
    extern double gsl_poly_eval(const double *INPUT, const int len, const double x);
%}
extern double gsl_poly_eval(const double  *INPUT, const int len, const double x);

%perlcode %{

@EXPORT_OK = qw(gsl_poly_eval gsl_poly_solve_quadratic);

%}
