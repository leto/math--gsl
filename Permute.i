%module Permute
%{
    #include "/usr/local/include/gsl/gsl_permute.h"
    #include "/usr/local/include/gsl/gsl_permute_double.h"
    #include "/usr/local/include/gsl/gsl_permute_int.h"
    #include "/usr/local/include/gsl/gsl_permute_vector.h"
    #include "/usr/local/include/gsl/gsl_permute_vector_double.h"
    #include "/usr/local/include/gsl/gsl_permute_vector_int.h"
%}

%include "/usr/local/include/gsl/gsl_permute.h"
%include "/usr/local/include/gsl/gsl_permute_double.h"
%include "/usr/local/include/gsl/gsl_permute_int.h"
%include "/usr/local/include/gsl/gsl_permute_vector.h"
%include "/usr/local/include/gsl/gsl_permute_vector_double.h"
%include "/usr/local/include/gsl/gsl_permute_vector_int.h"


%perlcode %{
@EXPORT_OK = qw/
                gsl_permute gsl_permute_inverse gsl_permute_int 
                gsl_permute_int_inverse gsl_permute_vector gsl_permute_vector_inverse 
                gsl_permute_vector_int gsl_permute_vector_int_inverse 
             /;
%EXPORT_TAGS = ( all => [ @EXPORT_OK ] );
%}
