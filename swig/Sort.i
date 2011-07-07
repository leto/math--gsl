%module "Math::GSL::Sort"
/* Danger Will Robinson! */

%include "typemaps.i"
%include "gsl_typemaps.i"
%include "renames.i"

%typemap(argout) (double * data, const size_t stride, const size_t n) {
    int i=0;
    AV* tempav = newAV();

    while( i < $3 ) {
        av_push(tempav, newSVnv((double) $1[i]));
        i++;
    }

    $result = sv_2mortal( newRV_noinc( (SV*) tempav) );
    //Perl_sv_dump($result);
    argvi++;
}
%typemap(argout) (double * dest, const size_t k, const gsl_vector * v) {
    int i=0;
    AV* tempav = newAV();

    while( i < $2 ) {
        av_push(tempav, newSVnv((double) $1[i]));
        i++;
    }

    $result = sv_2mortal( newRV_noinc( (SV*) tempav) );
    argvi++;
}

%typemap(argout) (double * dest, const size_t k, const double * src, const size_t stride, const size_t n) {
    int i=0;
    AV* tempav = newAV();
    while( i < $2 ) {
        av_push(tempav, newSVnv((double) $1[i]));
        i++;
    }

    $result = sv_2mortal( newRV_noinc( (SV*) tempav) );
    argvi++;
}
%typemap(argout) (size_t * p, const size_t k, const gsl_vector * v)
{
    int i=0;
    AV* tempav = newAV();
    while( i < $2 ) {
        av_push(tempav, newSVnv((size_t) $1[i]));
        i++;
    }

    $result = sv_2mortal( newRV_noinc( (SV*) tempav) );
    argvi++;
}

%typemap(argout) (size_t * p, const double * data, const size_t stride, const size_t n)
{
    int i=0;
    AV* tempav = newAV();
    while( i < $4 ) {
        av_push(tempav, newSViv((size_t) $1[i]));
        i++;
    }

    $result = sv_2mortal( newRV_noinc( (SV*) tempav) );
    argvi++;
}

%typemap(argout) (size_t * p, const size_t k, const double * src, const size_t stride, const size_t n)
{
    int i=0;
    AV* tempav = newAV();
    while( i < $2 ) {
        av_push(tempav, newSViv((size_t) $1[i]));
        i++;
    }

    $result = sv_2mortal( newRV_noinc( (SV*) tempav) );
    argvi++;
} 

%apply double * { double *data, double *dest };

%{
    #include "gsl/gsl_nan.h"
    #include "gsl/gsl_sort.h"
    #include "gsl/gsl_sort_double.h"
    #include "gsl/gsl_sort_int.h"
    #include "gsl/gsl_sort_vector.h"
    #include "gsl/gsl_sort_vector_double.h"
    #include "gsl/gsl_sort_vector_int.h"
    #include "gsl/gsl_permutation.h"
%}

%include "gsl/gsl_nan.h"
%include "gsl/gsl_sort.h"
%include "gsl/gsl_sort_double.h"
%include "gsl/gsl_sort_int.h"
%include "gsl/gsl_sort_vector.h"
%include "gsl/gsl_sort_vector_double.h"
%include "gsl/gsl_sort_vector_int.h"
%include "gsl/gsl_permutation.h"

%include "../pod/Sort.pod"
