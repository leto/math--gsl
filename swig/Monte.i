%module "Math::GSL::Monte"
%include "typemaps.i"
%include "gsl_typemaps.i"
%include "gsl/gsl_monte.h"
%include "gsl/gsl_monte_miser.h"
%include "gsl/gsl_monte_plain.h"
%include "gsl/gsl_monte_vegas.h"
%include "gsl/gsl_types.h"
%include "gsl/gsl_errno.h"

%typemap(argout) ( gsl_monte_function * f, double xl[], double xu[],
                   size_t dim, size_t calls, gsl_rng * r,
                   gsl_monte_vegas_state *state,
                    double *result, double *abserr) {
    // This is not being triggered
    fprintf(stderr, "argout of monte_vegas_int!");
k

}
%typemap(in) void * {
    $1 = (double *) $input;
};


%{
    #include "gsl/gsl_monte.h"
    #include "gsl/gsl_monte_miser.h"
    #include "gsl/gsl_monte_plain.h"
    #include "gsl/gsl_monte_vegas.h"
    #include "gsl/gsl_types.h"
    #include "gsl/gsl_errno.h"
%}
%include "../pod/Monte.pod"
