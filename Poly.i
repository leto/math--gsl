%module Poly
%include "GSL.i"
%{
    #include "/usr/local/include/gsl/gsl_poly.h"
    #include "/usr/local/include/gsl/gsl_nan.h"
    #include "/usr/local/include/gsl/gsl_complex.h"
%}

%include "/usr/local/include/gsl/gsl_poly.h"
%include "/usr/local/include/gsl/gsl_complex.h"
%include "/usr/local/include/gsl/gsl_nan.h"

%include "typemaps.i"


%perlcode %{

@EXPORT_OK = qw(gsl_poly_eval gsl_poly_solve_quadratic);
%EXPORT_TAGS = ( all => [ @EXPORT_OK ] );

%}

