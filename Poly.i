%module Poly
%{
    #include "/usr/local/include/gsl/gsl_poly.h"
    #include "/usr/local/include/gsl/gsl_complex.h"
%}

%include "/usr/local/include/gsl/gsl_poly.h"
%include "/usr/local/include/gsl/gsl_complex.h"

%include "carrays.i"
%include "cpointer.i"
%include "typemaps.i"
%array_functions(double, doubleArray);
%pointer_functions(double, ptr);

%perlcode %{

@EXPORT_OK = qw(gsl_poly_eval gsl_poly_solve_quadratic);
%EXPORT_TAGS = ( all => [ @EXPORT_OK ] );

%}
