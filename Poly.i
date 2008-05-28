%module Poly
%include "GSL.i" 

%typemap(in) double * (double dvalue) {
  SV* tempsv;
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


%{
    #include "/usr/local/include/gsl/gsl_nan.h"
    #include "/usr/local/include/gsl/gsl_poly.h"
    #include "/usr/local/include/gsl/gsl_complex.h"
%}

%include "/usr/local/include/gsl/gsl_nan.h"
%include "/usr/local/include/gsl/gsl_poly.h"
%include "/usr/local/include/gsl/gsl_complex.h"


%perlcode %{

@EXPORT_OK = qw/
                gsl_poly_eval 
                gsl_poly_complex_eval 
                gsl_complex_poly_complex_eval 
                gsl_poly_dd_init 
                gsl_poly_dd_eval 
                gsl_poly_dd_taylor 
                gsl_poly_solve_quadratic 
                gsl_poly_complex_solve_quadratic 
                gsl_poly_solve_cubic 
                gsl_poly_complex_solve_cubic 
                gsl_poly_complex_workspace_alloc 
                gsl_poly_complex_workspace_free 
                gsl_poly_complex_solve 
                $GSL_POSZERO $GSL_NEGZERO $GSL_NAN
             /;

%EXPORT_TAGS = ( all => [ @EXPORT_OK ] );

%}

