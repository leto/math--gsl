%module Wavelet
%{
    #include "gsl/gsl_types.h"
    #include "gsl/gsl_wavelet.h"
%}

typedef int size_t;

%include "gsl/gsl_types.h"
%include "gsl/gsl_wavelet.h"

%include "carrays.i"
%include "typemaps.i"
%array_functions(double, doubleArray);


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


%EXPORT_TAGS = ( all        => [ @EXPORT_OK ], );

%}
