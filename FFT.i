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

%typemap(argout) (gsl_complex_packed_array data[], const size_t stride, const size_t n) {
    int i=0;
    AV* tempav = newAV();

    while( i < 2*$3 ) {
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
__END__

=head1 NAME

Math::GSL::FFT - Functions for performing Fast Fourier Transforms (FFT)

=head1 SYNOPSIS

use Math::GSL::FFT qw /:all/;

=head1 DESCRIPTION

Here is a list of all the functions in this module :

=over

=item * C<gsl_fft_complex_radix2_forward >

=item * C<gsl_fft_complex_radix2_backward >

=item * C<gsl_fft_complex_radix2_inverse >

=item * C<gsl_fft_complex_radix2_transform >

=item * C<gsl_fft_complex_radix2_dif_forward >

=item * C<gsl_fft_complex_radix2_dif_backward >

=item * C<gsl_fft_complex_radix2_dif_inverse >

=item * C<gsl_fft_complex_radix2_dif_transform >

=item * C<gsl_fft_complex_wavetable_alloc >

=item * C<gsl_fft_complex_wavetable_free >

=item * C<gsl_fft_complex_workspace_alloc >

=item * C<gsl_fft_complex_workspace_free >

=item * C<gsl_fft_complex_memcpy >

=item * C<gsl_fft_complex_forward >

=item * C<gsl_fft_complex_backward >

=item * C<gsl_fft_complex_inverse >

=item * C<gsl_fft_complex_transform >

=item * C<gsl_fft_halfcomplex_radix2_backward >

=item * C<gsl_fft_halfcomplex_radix2_inverse >

=item * C<gsl_fft_halfcomplex_radix2_transform >

=item * C<gsl_fft_halfcomplex_wavetable_alloc >

=item * C<gsl_fft_halfcomplex_wavetable_free >

=item * C<gsl_fft_halfcomplex_backward >

=item * C<gsl_fft_halfcomplex_inverse >

=item * C<gsl_fft_halfcomplex_transform >

=item * C<gsl_fft_halfcomplex_unpack >

=item * C<gsl_fft_halfcomplex_radix2_unpack >

=item * C<gsl_fft_real_radix2_transform >

=item * C<gsl_fft_real_wavetable_alloc >

=item * C<gsl_fft_real_wavetable_free >

=item * C<gsl_fft_real_workspace_alloc >

=item * C<gsl_fft_real_workspace_free >

=item * C<gsl_fft_real_transform >

=item * C<gsl_fft_real_unpack >

=back

This module also includes the following constants :

=over

=item * C<$gsl_fft_forward>

=item * C<$gsl_fft_backward>

=back

For more informations on the functions, we refer you to the GSL offcial
documentation: L<http://www.gnu.org/software/gsl/manual/html_node/>

 Tip : search on google: site:http://www.gnu.org/software/gsl/manual/html_node/ name_of_the_function_you_want


=head1 AUTHORS

Jonathan Leto <jonathan@leto.net> and Thierry Moisan <thierry.moisan@gmail.com>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2008 Jonathan Leto and Thierry Moisan

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

%}
