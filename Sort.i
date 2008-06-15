%module Sort
//%include "GSL.i"

/* Danger Will Robinson! */

%include "typemaps.i"
%typemap(in) double * {
    AV *tempav;
    I32 len;
    int i;
    SV **tv;
    if (!SvROK($input))
        croak("Math::GSL : $input is not a reference!");
    if (SvTYPE(SvRV($input)) != SVt_PVAV)
        croak("Math::GSL : $input is not an array ref!");
        
    tempav = (AV*)SvRV($input);
    len = av_len(tempav);
    $1 = (double *) malloc((len+1)*sizeof(double));
    for (i = 0; i <= len; i++) {
        tv = av_fetch(tempav, i, 0);
        $1[i] = (double) SvNV(*tv);
    }
}

%typemap(argout) double * {
    int i=0;
    AV* tempav = newAV();

    // Need to determine length of $1
    while( i<= 5 ) {
        //printf("setting stuff %f\n", $1[i]);
        av_push(tempav, newSVnv((double) $1[i]));
        i++;
    }

    $result = sv_2mortal( newRV_noinc( (SV*) tempav) );
    //Perl_sv_dump($result);
    argvi++;
}

%apply double * { double *data };

%{
    #include "/usr/local/include/gsl/gsl_nan.h"
    #include "/usr/local/include/gsl/gsl_sort.h"
    #include "/usr/local/include/gsl/gsl_sort_double.h"
    #include "/usr/local/include/gsl/gsl_sort_int.h"
    #include "/usr/local/include/gsl/gsl_sort_vector.h"
    #include "/usr/local/include/gsl/gsl_sort_vector_double.h"
    #include "/usr/local/include/gsl/gsl_sort_vector_int.h"
%}
%include "/usr/local/include/gsl/gsl_nan.h"
%include "/usr/local/include/gsl/gsl_sort.h"
%include "/usr/local/include/gsl/gsl_sort_double.h"
%include "/usr/local/include/gsl/gsl_sort_int.h"
%include "/usr/local/include/gsl/gsl_sort_vector.h"
%include "/usr/local/include/gsl/gsl_sort_vector_double.h"
%include "/usr/local/include/gsl/gsl_sort_vector_int.h"


%perlcode %{
@EXPORT_plain = qw/
                gsl_sort gsl_sort_index 
                gsl_sort_smallest gsl_sort_smallest_index
                gsl_sort_largest gsl_sort_largest_index
                /;
@EXPORT_vector= qw/
                gsl_sort_vector gsl_sort_vector_index 
                gsl_sort_vector_smallest gsl_sort_vector_smallest_index
                gsl_sort_vector_largest gsl_sort_vector_largest_index
                /;
@EXPORT_OK    = ( @EXPORT_plain, @EXPORT_vector );
%EXPORT_TAGS  = (
                 all    => [ @EXPORT_OK     ], 
                 plain  => [ @EXPORT_plain  ], 
                 vector => [ @EXPORT_vector ], 
                );

%}
