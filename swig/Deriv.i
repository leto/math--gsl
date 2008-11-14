%module "Math::GSL::Deriv"
// Danger Will Robinson, for realz!

%include "typemaps.i"
%include "gsl_typemaps.i"
%typemap(argout) (const gsl_function *f,
                       double x, double h,
                       double *result, double *abserr) {
    SV ** sv;

    sv = hv_fetch(Callbacks, (char*)&$input, sizeof($input), FALSE );
    if (sv == (SV**)NULL)
        croak("Math::GSL(argout) : Missing callback!\n");
    dSP;

    PUSHMARK(SP);
    // these are the arguments passed to the callback
    XPUSHs(sv_2mortal(newSViv((int)$2)));
    // shouldnt we be doing something with $3 ?
    PUTBACK;

    /* This actually calls the perl subroutine, in scalar context */
    call_sv(*sv, G_SCALAR);    

    $result = sv_newmortal();
    sv_setnv($result, (double) *$4);
    argvi++;
    sv_setnv($result, (double) *$5);
    argvi++;

    if (argvi >= items) {            
        EXTEND(SP,1);              
    }

}
// this is rarely prudent but seems to work
%typemap(in) void * {
    $1 = (double *) $input;
};
%{
    #include "gsl/gsl_math.h"
    #include "gsl/gsl_deriv.h"
%}

%include "gsl/gsl_math.h"
%include "gsl/gsl_deriv.h"
%include "../pod/Deriv.pod"
