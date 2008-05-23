%module Permutation
%{
    #include "/usr/local/include/gsl/gsl_permutation.h"
%}

%include "/usr/local/include/gsl/gsl_permutation.h"

%perlcode %{ 
@EXPORT_OK = qw/
                gsl_permutation_alloc 
                gsl_permutation_calloc 
                gsl_permutation_init 
                gsl_permutation_free 
                gsl_permutation_memcpy 
                gsl_permutation_fread 
                gsl_permutation_fwrite 
                gsl_permutation_fscanf 
                gsl_permutation_fprintf 
                gsl_permutation_size 
                gsl_permutation_data 
                gsl_permutation_get 
                gsl_permutation_swap 
                gsl_permutation_valid 
                gsl_permutation_reverse 
                gsl_permutation_inverse 
                gsl_permutation_next 
                gsl_permutation_prev 
                gsl_permutation_mul 
                gsl_permutation_linear_to_canonical 
                gsl_permutation_canonical_to_linear 
                gsl_permutation_inversions 
                gsl_permutation_linear_cycles 
                gsl_permutation_canonical_cycles 
            /;
%EXPORT_TAGS = ( all => [ @EXPORT_OK ] );

%}

