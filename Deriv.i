%module "Math::GSL::Deriv"

%include "typemaps.i"
%typemap(in) gsl_function * {
    printf("gsl_func \n");
};

%typemap(in) void * {
    printf("void * \n");
};

%typemap(in) double (*)(double,void *) {
    printf("function pointer * \n");
};
%apply double * OUTPUT { double *result,double *abserr };

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

