%module "Math::GSL::NTuple"
%include "typemaps.i"
%include "gsl_typemaps.i"

%typemap(in) void *ntuple_data {
    fprintf(stderr,"symname=$symname\n");
    if ($input) 
        $1 = (double *) $input;
    // should have a croak in an else
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
