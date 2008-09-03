%module "Math::GSL::FFT"
%include "typemaps.i"
%include "gsl_typemaps.i"


%typemap(argout) (double data[], const size_t stride, const size_t n) {
    int i=0;
    AV* tempav = newAV();

    while( i < $3 ) {
        av_push(tempav, newSVnv((double) $1[i]));
        i++;
    }

    $result = sv_2mortal( newRV_noinc( (SV*) tempav) );
    argvi++;
}


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
@EXPORT_complex = qw/
               gsl_fft_complex_radix2_forward 
               gsl_fft_complex_radix2_backward 
               gsl_fft_complex_radix2_inverse 
               gsl_fft_complex_radix2_transform 
               gsl_fft_complex_radix2_dif_forward 
               gsl_fft_complex_radix2_dif_backward 
               gsl_fft_complex_radix2_dif_inverse 
               gsl_fft_complex_radix2_dif_transform 
               gsl_fft_complex_wavetable_alloc 
               gsl_fft_complex_wavetable_free 
               gsl_fft_complex_workspace_alloc 
               gsl_fft_complex_workspace_free 
               gsl_fft_complex_memcpy 
               gsl_fft_complex_forward 
               gsl_fft_complex_backward 
               gsl_fft_complex_inverse 
               gsl_fft_complex_transform 
               /;
@EXPORT_halfcomplex = qw/
               gsl_fft_halfcomplex_radix2_backward 
               gsl_fft_halfcomplex_radix2_inverse 
               gsl_fft_halfcomplex_radix2_transform 
               gsl_fft_halfcomplex_wavetable_alloc 
               gsl_fft_halfcomplex_wavetable_free 
               gsl_fft_halfcomplex_backward 
               gsl_fft_halfcomplex_inverse 
               gsl_fft_halfcomplex_transform 
               gsl_fft_halfcomplex_unpack 
               gsl_fft_halfcomplex_radix2_unpack 
               /;
@EXPORT_real = qw/ 
               gsl_fft_real_radix2_transform 
               gsl_fft_real_wavetable_alloc 
               gsl_fft_real_wavetable_free 
               gsl_fft_real_workspace_alloc 
               gsl_fft_real_workspace_free 
               gsl_fft_real_transform 
               gsl_fft_real_unpack 
             /;
@EXPORT_vars = qw/
                $gsl_fft_forward
                $gsl_fft_backward
                /;
@EXPORT_OK =   (
                @EXPORT_real, 
                @EXPORT_complex,
                @EXPORT_halfcomplex, 
                @EXPORT_vars,
                );
%EXPORT_TAGS = ( 
                all         => \@EXPORT_OK, 
                real        => \@EXPORT_real,
                complex     => \@EXPORT_complex,
                halfcomplex => \@EXPORT_halfcomplex,
                vars        => \@EXPORT_vars,
               );
%}
