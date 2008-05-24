%module Sum
%{
    #include "/usr/local/include/gsl/gsl_sum.h"
%}

%include "/usr/local/include/gsl/gsl_sum.h"

%perlcode %{
@EXPORT_OK = qw/
               gsl_sum_levin_u_alloc 
               gsl_sum_levin_u_free 
               gsl_sum_levin_u_accel 
               gsl_sum_levin_u_minmax 
               gsl_sum_levin_u_step 
               gsl_sum_levin_utrunc_alloc 
               gsl_sum_levin_utrunc_free 
               gsl_sum_levin_utrunc_accel 
               gsl_sum_levin_utrunc_minmax 
               gsl_sum_levin_utrunc_step 
               swig_size_get 
               swig_size_set 
               swig_i_get 
               swig_i_set 
               swig_terms_used_get 
               swig_terms_used_set 
               swig_sum_plain_get 
               swig_sum_plain_set 
               swig_q_num_get 
               swig_q_num_set 
               swig_q_den_get 
               swig_q_den_set 
               swig_dq_num_get 
               swig_dq_num_set 
               swig_dq_den_get 
               swig_dq_den_set 
               swig_dsum_get 
               swig_dsum_set 
               swig_size_get 
               swig_size_set 
               swig_i_get 
               swig_i_set 
               swig_terms_used_get 
               swig_terms_used_set 
               swig_sum_plain_get 
               swig_sum_plain_set 
               swig_q_num_get 
               swig_q_num_set 
               swig_q_den_get 
               swig_q_den_set 
               swig_dsum_get 
               swig_dsum_set 
             /;
%EXPORT_TAGS = ( all => [ @EXPORT_OK ] );
%}
