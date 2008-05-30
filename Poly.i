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
our $GSL_NAN = q{nan};
#our $GSL_POSZERO = 0.0;
#our $GSL_NEGZERO = -1*0.0;

%EXPORT_TAGS = ( all => [ @EXPORT_OK ] );

__END__

=head1 NAME

Math::GSL::Poly
Functions for evaluating and solving polynomials

=head1 SYPNOPSIS

use Math::GSL::Poly qw/:all/;

=head1 DESCRIPTION

Here is a list of all the functions included in this module :
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

For more informations on the functions, we refer you to the GSL offcial documentation: http://www.gnu.org/software/gsl/manual/html_node/
Tip : search on google: site:http://www.gnu.org/software/gsl/manual/html_node/ name_of_the_function_you_want

=head1 EXAMPLES

use Math::GSL::Poly qw/:all/;
$a = 1;
$b = 6;
$c = 9;
$x0 = 0;
$x1 = 0;
$num_roots = gsl_poly_solve_quadratic( $a, $b, $c, \$x0, \$x1);
print "x²+6x+9 contains $num_roots roots which are $x0 and $x1. \n";
 
=head1 AUTHOR

Jonathan Leto <jaleto@gmail.com> and Thierry Moisan <thierry.moisan@gmail.com>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2008 Jonathan Leto and Thierry Moisan

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut
%}

