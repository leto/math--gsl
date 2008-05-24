%module Heapsort
%{
#include "/usr/local/include/gsl/gsl_heapsort.h"
%}

%include "/usr/local/include/gsl/gsl_heapsort.h"


%perlcode %{
@EXPORT_OK = qw/
               gsl_heapsort 
               gsl_heapsort_index 
             /;
%EXPORT_TAGS = ( all => [ @EXPORT_OK ] );
%}
