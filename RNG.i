%module RNG
%{
    #include "/usr/local/include/gsl/gsl_rng.h"
%}
%import "/usr/local/include/gsl/gsl_types.h"

%include "/usr/local/include/gsl/gsl_rng.h"

%perlcode %{

@EXPORT_OK = qw/ gsl_rng_alloc gsl_rng_set gsl_rng_get gsl_rng_free gsl_rng_memcpy $gsl_rng_default/;
%EXPORT_TAGS = ( all => [ @EXPORT_OK ] );

%}
