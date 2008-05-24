%module DFT
%{
    #include "/usr/local/include/gsl/gsl_dft_complex.h"
%}

%include "/usr/local/include/gsl/gsl_dft_complex.h"


%perlcode %{
@EXPORT_OK = qw/
               gsl_dft_complex_forward 
               gsl_dft_complex_backward 
               gsl_dft_complex_inverse 
               gsl_dft_complex_transform 
             /;
%EXPORT_TAGS = ( all => [ @EXPORT_OK ] );
%}
