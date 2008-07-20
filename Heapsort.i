%module "Math::GSL::Heapsort"
%{
    #include "gsl/gsl_heapsort.h"
%}

%include "gsl/gsl_heapsort.h"


%perlcode %{
@EXPORT_OK = qw/
               gsl_heapsort 
               gsl_heapsort_index 
             /;
%EXPORT_TAGS = ( all => [ @EXPORT_OK ] );
%}
