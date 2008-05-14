%module FFT
%{
#include "/usr/local/include/gsl/gsl_fft.h"
#include "/usr/local/include/gsl/gsl_fft_complex.h"
#include "/usr/local/include/gsl/gsl_fft_complex_float.h"
#include "/usr/local/include/gsl/gsl_fft_halfcomplex.h"
#include "/usr/local/include/gsl/gsl_fft_halfcomplex_float.h"
#include "/usr/local/include/gsl/gsl_fft_real.h"
#include "/usr/local/include/gsl/gsl_fft_real_float.h"

%}

%include "/usr/local/include/gsl/gsl_fft.h"
%include "/usr/local/include/gsl/gsl_fft_complex.h"
%include "/usr/local/include/gsl/gsl_fft_complex_float.h"
%include "/usr/local/include/gsl/gsl_fft_halfcomplex.h"
%include "/usr/local/include/gsl/gsl_fft_halfcomplex_float.h"
%include "/usr/local/include/gsl/gsl_fft_real.h"
%include "/usr/local/include/gsl/gsl_fft_real_float.h"

