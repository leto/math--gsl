%module "Math::GSL::Deriv"
/*
struct gsl_function_struct 
{
  double (* function) (double x, void * params);
  void * params;
};

typedef struct gsl_function_struct gsl_function ;
#define GSL_FN_EVAL(F,x) (*((F)->function))(x,(F)->params)
*/

%include "typemaps.i"
%typemap(in) gsl_function * {
    gsl_function F;
    int count;
    F.params = 0;
    F.function = &xsquared;
   
    if( !SvROK($input) ) {
        croak("Math::GSL : not a reference value!");
    }
    //Perl_sv_dump( $input );

    // does not work
    //count = call_sv((SV*) $input, G_ARRAY);
    $1 = &F;
};

%{
    typedef struct callback_t
    {  
        SV * obj;
    };
    double xsquared(double x,void *params){
        return x * x;
    }
%}
%typemap(in) void * {
    printf("void * \n");
    $1 = (double *) $input;
};
%typemap(in) double (*)(double,void *) {
    fprintf(stderr,"input * %d \n", (int) $input);
    //Perl_sv_dump( $input );
};

%apply double * OUTPUT { double *abserr, double *result };

%{
    #include "gsl/gsl_math.h"
    #include "gsl/gsl_deriv.h"
%}

%include "gsl/gsl_math.h"
%include "gsl/gsl_deriv.h"

%perlcode %{
@EXPORT_OK = qw/
               gsl_deriv_central 
               gsl_deriv_backward 
               gsl_deriv_forward 
             /;
%EXPORT_TAGS = ( all => [ @EXPORT_OK ] );

__END__

=head1 NAME

Math::GSL::Deriv - Functions to compute numerical derivatives by finite differencing

=head1 SYNOPSIS

This module is not yet implemented. Patches Welcome!

use Math::GSL::Deriv qw /:all/;

=head1 DESCRIPTION

Here is a list of all the functions in this module :

=over 

=item * C<gsl_deriv_central> 

=item * C<gsl_deriv_backward> 

=item * C<gsl_deriv_forward> 

=back

For more informations on the functions, we refer you to the GSL offcial
documentation: L<http://www.gnu.org/software/gsl/manual/html_node/>

Tip : search on google: site:http://www.gnu.org/software/gsl/manual/html_node/ name_of_the_function_you_want


=head1 AUTHORS

Jonathan Leto <jonathan@leto.net> and Thierry Moisan <thierry.moisan@gmail.com>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2008 Jonathan Leto and Thierry Moisan

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

%}

