%module "Math::GSL::NTuple"
%include "typemaps.i"
%include "gsl_typemaps.i"

%typemap(in) void *ntuple_data {
    fprintf(stderr,"symname=$symname \n");

    if (!SvROK($input))
        croak("Math::GSL : $$1_name is not a reference!");

    if (SvTYPE(SvRV($input)) != SVt_PVAV)
        croak("Math::GSL : $$1_name is not an array ref!");

    $1 = (double *) $input;
};

%typemap(argout) void *ntuple_data {
    //Perl_sv_dump($1);
}

%{
    #include "gsl/gsl_ntuple.h"
    #include "gsl/gsl_errno.h"
    #include "gsl/gsl_histogram.h"
%}

%include "gsl/gsl_ntuple.h"
%include "gsl/gsl_errno.h"
%include "gsl/gsl_histogram.h"

%include "../pod/NTuple.pod"
