%module "Math::GSL::Wavelet"
%include "gsl_typemaps.i"
%{
    #include "gsl/gsl_types.h"
    #include "gsl/gsl_wavelet.h"
%}

typedef int size_t;

%include "gsl/gsl_types.h"
%include "gsl/gsl_wavelet.h"

%include "typemaps.i"


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


%EXPORT_TAGS = ( all => [ @EXPORT_OK ], );

=head1 NAME

Math::GSL::Wavelet - Wavelets (for 1-D real data)

=head1 SYNOPSIS

    use Math::GSL::Wavelet qw/:all/;

=cut

=head1 DESCRIPTION

Here is a list of all the functions included in this module :

=over 1

=item C<gsl_wavelet_alloc($T, $k)> - This function allocates and initializes a wavelet object of type $T, where $T must be one of the constants below. The parameter $k selects the specific member of the wavelet family.

=item C<gsl_wavelet_free($w)> - This function frees the wavelet object $w. 

=item C<gsl_wavelet_name>

=item C<gsl_wavelet_workspace_alloc($n)> - This function allocates a workspace for the discrete wavelet transform. To perform a one-dimensional transform on $n elements, a workspace of size $n must be provided. For two-dimensional transforms of $n-by-$n matrices it is sufficient to allocate a workspace of size $n, since the transform operates on individual rows and columns.

=item C<gsl_wavelet_workspace_free($work)> - This function frees the allocated workspace work. 

=item C<gsl_wavelet_transform>

=item C<gsl_wavelet_transform_forward($w, $data, $stride, $n, $work)> - This functions compute in-place forward discrete wavelet transforms of length $n with stride $stride on the array $data. The length of the transform $n is restricted to powers of two. For the forward transform, the elements of the original array are replaced by the discrete wavelet transform f_i -> w_{j,k} in a packed triangular storage layout, where j is the index of the level j = 0 ... J-1 and k is the index of the coefficient within each level, k = 0 ... (2^j)-1. The total number of levels is J = \log_2(n). The output data has the following form,

=over

=item (s_{-1,0}, d_{0,0}, d_{1,0}, d_{1,1}, d_{2,0}, ...,

=item d_{j,k}, ..., d_{J-1,2^{J-1}-1})

=back
     
where the first element is the smoothing coefficient s_{-1,0}, followed by the detail coefficients d_{j,k} for each level j. The backward transform inverts these coefficients to obtain the original data. These functions return a status of $GSL_SUCCESS upon successful completion. $GSL_EINVAL is returned if $n is not an integer power of 2 or if insufficient workspace is provided.

=item C<gsl_wavelet_transform_inverse>

=back

This module also contains the following constants with their valid k value for the gsl_wavelet_alloc function :

=over 1

=item $gsl_wavelet_daubechies

=item $gsl_wavelet_daubechies_centered

=back

This is the Daubechies wavelet family of maximum phase with k/2 vanishing moments. The implemented wavelets are k=4, 6, ..., 20, with k even.

=over 1

=item $gsl_wavelet_haar

=item $gsl_wavelet_haar_centered

=back

This is the Haar wavelet. The only valid choice of k for the Haar wavelet is k=2. 

=over 1

=item $gsl_wavelet_bspline

=item $gsl_wavelet_bspline_centered

=back

This is the biorthogonal B-spline wavelet family of order (i,j). The implemented values of k = 100*i + j are 103, 105, 202, 204, 206, 208, 301, 303, 305 307, 309.

=head1 AUTHORS

Jonathan Leto <jonathan@leto.net> and Thierry Moisan <thierry.moisan@gmail.com>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2008 Jonathan Leto and Thierry Moisan

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut
%}
