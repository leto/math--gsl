%module "Math::GSL::Interp"

%include "typemaps.i"
%include "gsl_typemaps.i"

%{
    #include "gsl/gsl_types.h"
    #include "gsl/gsl_interp.h"
%}
%include "gsl/gsl_types.h"
%include "gsl/gsl_interp.h"


%perlcode %{
@EXPORT_OK = qw/
               gsl_interp_accel_alloc 
               gsl_interp_accel_find 
               gsl_interp_accel_reset 
               gsl_interp_accel_free 
               gsl_interp_alloc 
               gsl_interp_init 
               gsl_interp_name 
               gsl_interp_min_size 
               gsl_interp_eval_e 
               gsl_interp_eval 
               gsl_interp_eval_deriv_e 
               gsl_interp_eval_deriv 
               gsl_interp_eval_deriv2_e 
               gsl_interp_eval_deriv2 
               gsl_interp_eval_integ_e 
               gsl_interp_eval_integ 
               gsl_interp_free 
               gsl_interp_bsearch
               $gsl_interp_linear
               $gsl_interp_polynomial
               $gsl_interp_cspline
               $gsl_interp_cspline_periodic
               $gsl_interp_akima
               $gsl_interp_akima_periodic
             /;
%EXPORT_TAGS = ( all => [ @EXPORT_OK ] );

__END__

=head1 NAME

Math::GSL::Interp - Functions for performing interpolation

=head1 SYNOPSIS

 use Math::GSL::Interp qw/:all/;

=head1 DESCRIPTION

Here is a list of all the functions included in this module :

=over 1

=item C<gsl_interp_accel_alloc()> - This function returns a pointer to an accelerator object, which is a kind of iterator for interpolation lookups. It tracks the state of lookups, thus allowing for application of various acceleration strategies.

=item C<gsl_interp_accel_find($a, $x_array, $size, $x)> - This function performs a lookup action on the data array $x_array of size $size, using the given accelerator $a. This is how lookups are performed during evaluation of an interpolation. The function returns an index i such that $x_array[i] <= $x < $x_array[i+1].

=item C<gsl_interp_accel_reset> 

=item C<gsl_interp_accel_free($a)> - This function frees the accelerator object $a. 

=item C<gsl_interp_alloc($T, $alloc)> - This function returns a newly allocated interpolation object of type $T for $size data-points. $T must be one of the constants below.  

=item C<gsl_interp_init($interp, $xa, $ya, $size)> - This function initializes the interpolation object interp for the data (xa,ya) where xa and ya are arrays of size size. The interpolation object (gsl_interp) does not save the data arrays xa and ya and only stores the static state computed from the data. The xa data array is always assumed to be strictly ordered, with increasing x values; the behavior for other arrangements is not defined. 

=item C<gsl_interp_name> 

=item C<gsl_interp_min_size> 

=item C<gsl_interp_eval_e> 

=item C<gsl_interp_eval> 

=item C<gsl_interp_eval_deriv_e> 

=item C<gsl_interp_eval_deriv> 

=item C<gsl_interp_eval_deriv2_e> 

=item C<gsl_interp_eval_deriv2> 

=item C<gsl_interp_eval_integ_e> 

=item C<gsl_interp_eval_integ> 

=item C<gsl_interp_free> 

=item C<gsl_interp_bsearch> 

=back

This module also includes the following constants :

=over 1

=item C<$gsl_interp_linear> - Linear interpolation

=item C<$gsl_interp_polynomial> - Polynomial interpolation. This method should only be used for interpolating small numbers of points because polynomial interpolation introduces large oscillations, even for well-behaved datasets. The number of terms in the interpolating polynomial is equal to the number of points. 

=item C<$gsl_interp_cspline> - Cubic spline with natural boundary conditions. The resulting curve is piecewise cubic on each interval, with matching first and second derivatives at the supplied data-points. The second derivative is chosen to be zero at the first point and last point.

=item C<$gsl_interp_cspline_periodic> - Cubic spline with periodic boundary conditions. The resulting curve is piecewise cubic on each interval, with matching first and second derivatives at the supplied data-points. The derivatives at the first and last points are also matched. Note that the last point in the data must have the same y-value as the first point, otherwise the resulting periodic interpolation will have a discontinuity at the boundary. 

=item C<$gsl_interp_akima> - Non-rounded Akima spline with natural boundary conditions. This method uses the non-rounded corner algorithm of Wodicka. 

=item C<$gsl_interp_akima_periodic> - Non-rounded Akima spline with periodic boundary conditions. This method uses the non-rounded corner algorithm of Wodicka.

=back

=head1 AUTHORS

Jonathan Leto <jonathan@leto.net> and Thierry Moisan <thierry.moisan@gmail.com>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2008 Jonathan Leto and Thierry Moisan

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut


%}
