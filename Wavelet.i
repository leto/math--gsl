%module Wavelet
%{
    #include "/usr/local/include/gsl/gsl_types.h"
    #include "/usr/local/include/gsl/gsl_wavelet.h"
%}

typedef int size_t;

%include "/usr/local/include/gsl/gsl_types.h"
%include "/usr/local/include/gsl/gsl_wavelet.h"

%include "carrays.i"
%include "cpointer.i"
%include "typemaps.i"
%array_functions(double, doubleArray);
%pointer_functions(double, ptr);


%perlcode %{


@EXPORT_OK = qw/
    gsl_wavelet_alloc 
    gsl_wavelet_free 
    gsl_wavelet_name 
    gsl_wavelet_workspace_alloc 
    gsl_wavelet_workspace_free 
    gsl_wavelet_transform 
    gsl_wavelet_transform_forward 
    gsl_wavelet_transform_inverse 
    $gsl_wavelet_daubechies
    $gsl_wavelet_daubechies_centered
    $gsl_wavelet_haar
    $gsl_wavelet_haar_centered
    $gsl_wavelet_bspline
    $gsl_wavelet_bspline_centered
/;

# int gsl_wavelet_transform_forward (const gsl_wavelet * w, double *data, 
#                                   size_t stride, size_t n, gsl_wavelet_workspace * work);



%EXPORT_TAGS = ( all        => [ @EXPORT_OK ], );

%}
