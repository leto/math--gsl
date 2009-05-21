%module "Math::GSL::NTuple"
%include "typemaps.i"
%include "gsl_typemaps.i"

// XXX: This needs to properly take the type of array into account,
// this assumes ints
%typemap(in) void *ntuple_data {
    AV *tempav;
    I32 len;
    int i;
    SV  **tv;

    //fprintf(stderr,"symname=$symname \n");

    if (!SvROK($input))
        croak("Math::GSL::NTuple : $1_name is not a reference!");

    if (SvTYPE(SvRV($input)) != SVt_PVAV)
        croak("Math::GSL::NTuple : $1_name is not an array ref!");

    tempav = (AV*)SvRV($input);
    len = av_len(tempav);
    if( len > 0 ){
        $1 = (int **) malloc((len+1)*sizeof(int *));
        for (i = 0; i <= len; i++) {
            tv = av_fetch(tempav, i, 0);
            memset((int*)($1+i), SvIV(*tv) , sizeof(int *));
        }
    }
};

%typemap(argout) void *ntuple_data {
    //Perl_sv_dump($1);
}

%typemap(freearg) void *ntuple_data {
//    if ($1) free($1);
}

%{
    #include "gsl/gsl_ntuple.h"
    #include "gsl/gsl_errno.h"
    #include "gsl/gsl_histogram.h"
%}

%include "gsl/gsl_ntuple.h"
%include "gsl/gsl_histogram.h"

%include "../pod/NTuple.pod"
