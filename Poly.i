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

%typemap(in) gsl_complex const [] {
    AV *tempav;
    I32 len;
    int i, magic, stuff;
    double x,y;
    gsl_complex z;
    SV **elem, **helem, **real, **imag;
    HV *hash, *htmp;
    SV *svtmp, tmp;
    double result[2];

    printf("gsl_complex typemap\n");
    if (!SvROK($input))
        croak("Math::GSL : $input is not a reference!");
    if (SvTYPE(SvRV($input)) != SVt_PVAV)
        croak("Math::GSL : $input is not an array ref!");
       
    z      = gsl_complex_rect(0,0);
    tempav = (AV*)SvRV($input);
    len    = av_len(tempav);
    $1 = (gsl_complex *) malloc((len+1)*sizeof(gsl_complex));
    for (i = 0; i <= len; i++) {
        elem  = av_fetch(tempav, i, 0);

        hash = (HV*) SvRV(*elem);
        helem = hv_fetch(hash, "dat", 3, 0);
        magic = mg_get(*helem);
        if ( magic != 0)
            croak("FETCH magic failed!\n");

        printf("magic = %d\n", magic);
        if( *helem == NULL)
            croak("Structure does not contain 'dat' element\n");
        printf("helem is:\n");
        Perl_sv_dump(*helem);
        if( i == 0){
            svtmp = (SV*)SvRV(*helem);
            Perl_sv_dump(svtmp);
        }
        printf("re z = %f\n", GSL_REAL(z) );
        printf("im z = %f\n", GSL_IMAG(z) );
        $1[i] = z;
    }
    //$1[i] = GSL_NAN;
}
%{
    #include "/usr/local/include/gsl/gsl_nan.h"
    #include "/usr/local/include/gsl/gsl_poly.h"
    #include "/usr/local/include/gsl/gsl_complex.h"
    #include "/usr/local/include/gsl/gsl_complex_math.h"
%}

%include "/usr/local/include/gsl/gsl_nan.h"
%include "/usr/local/include/gsl/gsl_poly.h"
%include "/usr/local/include/gsl/gsl_complex.h"
%include "/usr/local/include/gsl/gsl_complex_math.h"


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

Jonathan Leto <jonathan@leto.net> and Thierry Moisan <thierry.moisan@gmail.com>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2008 Jonathan Leto and Thierry Moisan

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut
%}

