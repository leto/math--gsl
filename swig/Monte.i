%module "Math::GSL::Monte"
%include "typemaps.i"
%include "gsl_typemaps.i"

%typemap(argout) ( gsl_monte_function * f, double xl[], double xu[],
                   size_t dim, size_t calls, gsl_rng * r,
                   gsl_monte_vegas_state *state,
                    double *result, double *abserr) {
    int i=0;
    AV* tempav = newAV();

    while( i < $4 ) {
        av_push(tempav, newSVnv((double) $8[i]));
        i++;
    }
    $result = sv_2mortal( newRV_noinc( (SV*) tempav) );
    argvi++;
}


%{
    #include "gsl/gsl_monte.h"
    #include "gsl/gsl_monte_miser.h"
    #include "gsl/gsl_monte_plain.h"
    #include "gsl/gsl_monte_vegas.h"
    #include "gsl/gsl_types.h"
    #include "gsl/gsl_errno.h"
%}
%include "gsl/gsl_monte.h"
%include "gsl/gsl_monte_miser.h"
%include "gsl/gsl_monte_plain.h"
%include "gsl/gsl_monte_vegas.h"
%include "gsl/gsl_types.h"
%include "gsl/gsl_errno.h"
%include "../pod/Monte.pod"
