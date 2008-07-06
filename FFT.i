%module FFT
%{
    #include "gsl/gsl_fft.h"
    #include "gsl/gsl_fft_complex.h"
    #include "gsl/gsl_fft_halfcomplex.h"
    #include "gsl/gsl_fft_real.h"
    #include "gsl/gsl_complex.h"
%}

%include "gsl/gsl_complex.h"
%include "gsl/gsl_fft.h"
%include "gsl/gsl_fft_complex.h"
%include "gsl/gsl_fft_halfcomplex.h"
%include "gsl/gsl_fft_real.h"

%perlcode %{
@EXPORT_OK = qw/
                gsl_fft_complex_radix2_forward gsl_fft_complex_radix2_backward gsl_fft_complex_radix2_inverse 
                gsl_fft_complex_radix2_transform gsl_fft_complex_radix2_dif_forward gsl_fft_complex_radix2_dif_backward 
                gsl_fft_complex_radix2_dif_inverse gsl_fft_complex_radix2_dif_transform gsl_fft_complex_wavetable_alloc 
                gsl_fft_complex_wavetable_free gsl_fft_complex_workspace_alloc gsl_fft_complex_workspace_free 
                gsl_fft_complex_memcpy gsl_fft_complex_forward gsl_fft_complex_backward 
                gsl_fft_complex_inverse gsl_fft_complex_transform gsl_fft_halfcomplex_radix2_backward 
                gsl_fft_halfcomplex_radix2_inverse gsl_fft_halfcomplex_radix2_transform gsl_fft_halfcomplex_wavetable_alloc 
                gsl_fft_halfcomplex_wavetable_free gsl_fft_halfcomplex_backward gsl_fft_halfcomplex_inverse 
                gsl_fft_halfcomplex_transform gsl_fft_halfcomplex_unpack gsl_fft_halfcomplex_radix2_unpack 
                gsl_fft_real_radix2_transform gsl_fft_real_wavetable_alloc gsl_fft_real_wavetable_free 
                gsl_fft_real_workspace_alloc gsl_fft_real_workspace_free gsl_fft_real_transform 
                gsl_fft_real_unpack $forward $backward $gsl_fft_forward $gsl_fft_backward
             /;
%EXPORT_TAGS = ( all => [ @EXPORT_OK ] );
%}
