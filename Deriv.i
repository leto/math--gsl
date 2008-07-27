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
    F.params = 0;
    F.function = &xsquared;
    if( !SvROK($input) ) {
        fprintf(stderr,"not a reference value!");
        croak("bad juju"); 
    }
       fprintf(stderr,"gsl_func;input=%d\n", (int) $input);
    Perl_sv_dump( $input );
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
%}

