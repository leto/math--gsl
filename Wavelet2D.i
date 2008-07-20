%module "Math::GSL::Wavelet2D"
%{
    #include "gsl/gsl_types.h"
    #include "gsl/gsl_wavelet2d.h"
%}

%include "gsl/gsl_types.h"
%include "gsl/gsl_wavelet2d.h"

%perlcode %{

@EXPORT_OK = qw/
    gsl_wavelet2d_transform 
    gsl_wavelet2d_transform_forward 
    gsl_wavelet2d_transform_inverse 
    gsl_wavelet2d_nstransform 
    gsl_wavelet2d_nstransform_forward 
    gsl_wavelet2d_nstransform_inverse 
    gsl_wavelet2d_transform_matrix 
    gsl_wavelet2d_transform_matrix_forward 
    gsl_wavelet2d_transform_matrix_inverse 
    gsl_wavelet2d_nstransform_matrix 
    gsl_wavelet2d_nstransform_matrix_forward 
    gsl_wavelet2d_nstransform_matrix_inverse 

/;

%EXPORT_TAGS = ( all => [ @EXPORT_OK ] );

%}
