%module "Math::GSL::Deriv"

%include "typemaps.i"
%typemap(in) gsl_function * {

    fprintf(stderr,"gsl_func  \n");
    fprintf(stderr, "HAI %d\n", (int) $1->params );
    fprintf(stderr, "HAI %d\n", (int) $1->function );
};

%typemap(in) void * {
    printf("void * \n");
};

%typemap(in) double (*)(double,void *) {
    printf("function pointer * %d \n", (int) $1);
    printf("input * %d \n", (int) $input);
    Perl_sv_dump( $input );

};
//%apply double * OUTPUT { double *result,double *abserr };

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
%}

