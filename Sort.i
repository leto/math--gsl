%module Sort
%include "GSL.i"
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

%include "typemaps.i"

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
