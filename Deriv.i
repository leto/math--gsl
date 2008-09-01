%module "Math::GSL::Deriv"
// Danger Will Robinson, for realz!

%include "typemaps.i"
%{
    static HV * Callbacks = (HV*)NULL;
    /* this function returns the value 
        of evaluating the function pointer
        stored in func
    */
    double callthis(double x , int func, void *params){
        SV ** sv;
        double y;
        //fprintf(stderr, "LOOKUP CALLBACK\n");
        sv = hv_fetch(Callbacks, (char*)func, sizeof(func), FALSE );
        if (sv == (SV**)NULL)
            croak("Math::GSL(callthis) : Missing callback!\n");

        dSP;
        PUSHMARK(SP);
        XPUSHs(sv_2mortal(newSVnv((double)x)));
        PUTBACK;
        call_sv(*sv, G_SCALAR);
        y = POPn;
        //fprintf(stderr,"y=%f\n", y);
        return y;
    }
%}
%apply double * OUTPUT { double *abserr, double *result };
%typemap(in) gsl_function const * {
    fprintf(stderr,"typemap in!\n");
    gsl_function F;
    int count;
    F.params = &$input;
    F.function = &callthis;
    SV ** callback;
    double x;

    if (!SvROK($input)) {
        croak("Math::GSL : not a reference value!");
    }
    if (Callbacks == (HV*)NULL)
        Callbacks = newHV();
    //fprintf(stderr,"STORE CALLBACK\n");
    hv_store( Callbacks, (char*)&$input, sizeof($input), newSVsv($input), 0 );

    //Perl_sv_dump( $input );
    $1 = &F;
};
%typemap(argout) (const gsl_function *f,
                       double x, double h,
                       double *result, double *abserr) {
    SV ** sv;
    AV* av = newAV();

    sv = hv_fetch(Callbacks, (char*)&$input, sizeof($input), FALSE );
    if (sv == (SV**)NULL)
        croak("Math::GSL(argout) : Missing callback!\n");
    dSP;

    PUSHMARK(SP);
    // these are the arguments passed to the callback
    XPUSHs(sv_2mortal(newSViv((int)$2)));
    PUTBACK;

    /* This actually calls the perl subroutine */
    call_sv(*sv, G_SCALAR);    

    av_push(av, newSVnv((double) *$4));
    av_push(av, newSVnv((double) *$5));
    $result = sv_2mortal( newRV_noinc( (SV*) av) );
    if (argvi >= items) {            
        EXTEND(SP,1);              
    }
    argvi++;

}

%typemap(in) void * {
    $1 = (double *) $input;
};
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

