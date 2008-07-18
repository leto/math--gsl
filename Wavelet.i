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

Math::GSL::Wavelet - wavelets for real data in one dimension

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

=item C<gsl_wavelet_transform_forward>

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
