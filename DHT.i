%module DHT
%{
    #include "/usr/local/include/gsl/gsl_dht.h"
%}

%include "/usr/local/include/gsl/gsl_dht.h"


%perlcode %{
@EXPORT_OK = qw/
               gsl_dht_alloc 
               gsl_dht_new 
               gsl_dht_init 
               gsl_dht_x_sample 
               gsl_dht_k_sample 
               gsl_dht_free 
               gsl_dht_apply 
             /;
%EXPORT_TAGS = ( all => [ @EXPORT_OK ] );
%}
