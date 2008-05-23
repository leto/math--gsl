%module Poly
%include "GSL.i" 
%typemap(in) double * (double dvalue) {
  SV* tempsv;
  printf("FOO\n");
  if (!SvROK($input)) {
    croak("Math::GSL::Sort : $input is not a reference!\n");
  }
  tempsv = SvRV($input);
  if ((!SvNOK(tempsv)) && (!SvIOK(tempsv))) {
    croak("Math::GSL::Sort : $input is not a reference to number!\n");
  }
  dvalue = SvNV(tempsv);
  $1 = &dvalue;
}
%typemap(argout) double * {
  SV *tempsv;
  tempsv = SvRV($input);
  sv_setnv(tempsv, *$1);
}
%include "typemaps.i"
%{
    #include "/usr/local/include/gsl/gsl_nan.h"
    #include "/usr/local/include/gsl/gsl_poly.h"
    #include "/usr/local/include/gsl/gsl_complex.h"
%}

%include "/usr/local/include/gsl/gsl_nan.h"
%include "/usr/local/include/gsl/gsl_poly.h"
%include "/usr/local/include/gsl/gsl_complex.h"


%perlcode %{

@EXPORT_OK = qw(gsl_poly_eval gsl_poly_solve_quadratic);
%EXPORT_TAGS = ( all => [ @EXPORT_OK ] );

%}

