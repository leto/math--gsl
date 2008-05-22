%module QRNG
%{
    #include "/usr/local/include/gsl/gsl_types.h"
    #include "/usr/local/include/gsl/gsl_qrng.h"
%}

%include "/usr/local/include/gsl/gsl_types.h"
%include "/usr/local/include/gsl/gsl_qrng.h"

%perlcode %{

@EXPORT_OK = qw($gsl_qrng_niederreiter_2 $gsl_qrng_sobol $gsl_qrng_halton $gsl_qrng_reversehalton
                gsl_qrng_alloc gsl_qrng_memcpy gsl_qrng_clone
                gsl_qrng_free  gsl_qrng_init gsl_qrng_name 
                gsl_qrng_size gsl_qrng_state gsl_qrng_get
            );
%EXPORT_TAGS = ( all => [ @EXPORT_OK ] );
%}
