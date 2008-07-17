%module "Math::GSL::Histogram"
%include "typemaps.i"
%include "gsl_typemaps.i"

FILE * fopen(char *, char *);
int fclose(FILE *);

%{
    #include "gsl/gsl_histogram.h"
%}

%include "gsl/gsl_histogram.h"


%perlcode %{
@EXPORT_OK = qw/fopen fclose
               gsl_histogram_alloc 
               gsl_histogram_calloc 
               gsl_histogram_calloc_uniform 
               gsl_histogram_free 
               gsl_histogram_increment 
               gsl_histogram_accumulate 
               gsl_histogram_find 
               gsl_histogram_get 
               gsl_histogram_get_range 
               gsl_histogram_max 
               gsl_histogram_min 
               gsl_histogram_bins 
               gsl_histogram_reset 
               gsl_histogram_calloc_range 
               gsl_histogram_set_ranges 
               gsl_histogram_set_ranges_uniform 
               gsl_histogram_memcpy 
               gsl_histogram_clone 
               gsl_histogram_max_val 
               gsl_histogram_max_bin 
               gsl_histogram_min_val 
               gsl_histogram_min_bin 
               gsl_histogram_equal_bins_p 
               gsl_histogram_add 
               gsl_histogram_sub 
               gsl_histogram_mul 
               gsl_histogram_div 
               gsl_histogram_scale 
               gsl_histogram_shift 
               gsl_histogram_sigma 
               gsl_histogram_mean 
               gsl_histogram_sum 
               gsl_histogram_fwrite 
               gsl_histogram_fread 
               gsl_histogram_fprintf 
               gsl_histogram_fscanf 
               gsl_histogram_pdf_alloc 
               gsl_histogram_pdf_init 
               gsl_histogram_pdf_free 
               gsl_histogram_pdf_sample 
             /;
%EXPORT_TAGS = ( all => [ @EXPORT_OK ] );

=head1 NAME

Math::GSL::Histogram - Create and manipulate histograms of data

=head1 SYNOPSIS

    use Math::GSL::Histogram qw/:all/;

    my $H = gsl_histogram_alloc(100);
    gsl_histogram_set_ranges_uniform($H,0,101);
    gsl_histogram_increment($H, -50 );  # ignored
    gsl_histogram_increment($H, 70 );   
    gsl_histogram_increment($H, 85.2 );

    my $G = gsl_histogram_clone($H);
    my $value = gsl_histogram_get($G, 70);
    my ($max,$min) = (gsl_histogram_min_val($H), gsl_histogram_max_val($H) );
    my $sum = gsl_histogram_sum($H);

=cut

=head1 DESCRIPTION

Here is a list of all the functions included in this module :

=over 1

=item C<gsl_histogram_alloc($n)> - This function allocates memory for a histogram with $n bins, and returns a pointer to a newly created gsl_histogram struct. The bins and ranges are not initialized, and should be prepared using one of the range-setting functions below in order to make the histogram ready for use. 

=item C<gsl_histogram_calloc >

=item C<gsl_histogram_calloc_uniform >

=item C<gsl_histogram_free($h)> - This function frees the histogram $h and all of the memory associated with it.

=item C<gsl_histogram_increment >

=item C<gsl_histogram_accumulate($h, $x, $weight)> - This function is similar to gsl_histogram_increment but increases the value of the appropriate bin in the histogram $h by the floating-point number weight.

=item C<gsl_histogram_find >

=item C<gsl_histogram_get($h, $i)> - This function returns the contents of the $i-th bin of the histogram $h. If $i lies outside the valid range of indices for the histogram then the error handler is called with an error code of GSL_EDOM and the function returns 0. 

=item C<gsl_histogram_get_range >

=item C<gsl_histogram_max($h)> - This function returns the maximum upper limit of the histogram $h. It provides a way of determining this value without accessing the gsl_histogram struct directly. 

=item C<gsl_histogram_min($h)> - This function returns the minimum lower range limit of the histogram $h. It provides a way of determining this value without accessing the gsl_histogram struct directly. 

=item C<gsl_histogram_bins($h)> - This function returns the number of bins of the histogram $h limit. It provides a way of determining this value without accessing the gsl_histogram struct directly. 
 
=item C<gsl_histogram_reset($h)> - This function resets all the bins in the histogram $h to zero. 

=item C<gsl_histogram_calloc_range >

=item C<gsl_histogram_set_ranges >

=item C<gsl_histogram_set_ranges_uniform($h, $xmin, $xmax)> - This function sets the ranges of the existing histogram $h to cover the range $xmin to $xmax uniformly. The values of the histogram bins are reset to zero. The bin ranges are shown in the table below,
=over

=item  bin[0] corresponds to xmin <= x < xmin + d

=item  bin[1] corresponds to xmin + d <= x < xmin + 2 d

=item  ......

=item  bin[n-1] corresponds to xmin + (n-1)d <= x < xmax

=back

where d is the bin spacing, d = (xmax-xmin)/n. 

=over

=item C<gsl_histogram_memcpy>

=item C<gsl_histogram_clone >

=item C<gsl_histogram_max_val >

=item C<gsl_histogram_max_bin >

=item C<gsl_histogram_min_val >

=item C<gsl_histogram_min_bin >

=item C<gsl_histogram_equal_bins_p >

=item C<gsl_histogram_add >

=item C<gsl_histogram_sub >

=item C<gsl_histogram_mul >

=item C<gsl_histogram_div >

=item C<gsl_histogram_scale >

=item C<gsl_histogram_shift >

=item C<gsl_histogram_sigma >

=item C<gsl_histogram_mean >

=item C<gsl_histogram_sum >

=item C<gsl_histogram_fwrite >

=item C<gsl_histogram_fread >

=item C<gsl_histogram_fprintf >

=item C<gsl_histogram_fscanf >

=item C<gsl_histogram_pdf_alloc >

=item C<gsl_histogram_pdf_init >

=item C<gsl_histogram_pdf_free >

=item C<gsl_histogram_pdf_sample >

=back

=head1 AUTHORS

Jonathan Leto <jonathan@leto.net> and Thierry Moisan <thierry.moisan@gmail.com>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2008 Jonathan Leto and Thierry Moisan

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

%}
