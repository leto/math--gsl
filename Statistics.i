%module "Math::GSL::Statistics"

%include "typemaps.i"
%include "gsl_typemaps.i"

%apply double *OUTPUT { double * min, double * max };

%apply int *OUTPUT { size_t * min_index, size_t * max_index };

%{
    #include "gsl/gsl_statistics_double.h"
    #include "gsl/gsl_statistics_int.h"
    #include "gsl/gsl_statistics_char.h"
%}

%include "gsl/gsl_statistics_double.h"
%include "gsl/gsl_statistics_int.h"
%include "gsl/gsl_statistics_char.h"


%perlcode %{
@EXPORT_OK = qw/
               gsl_stats_mean 
               gsl_stats_variance 
               gsl_stats_sd 
               gsl_stats_variance_with_fixed_mean 
               gsl_stats_sd_with_fixed_mean 
               gsl_stats_tss 
               gsl_stats_tss_m 
               gsl_stats_absdev 
               gsl_stats_skew 
               gsl_stats_kurtosis 
               gsl_stats_lag1_autocorrelation 
               gsl_stats_covariance 
               gsl_stats_correlation 
               gsl_stats_variance_m 
               gsl_stats_sd_m 
               gsl_stats_absdev_m 
               gsl_stats_skew_m_sd 
               gsl_stats_kurtosis_m_sd 
               gsl_stats_lag1_autocorrelation_m 
               gsl_stats_covariance_m 
               gsl_stats_wmean 
               gsl_stats_wvariance 
               gsl_stats_wsd 
               gsl_stats_wvariance_with_fixed_mean 
               gsl_stats_wsd_with_fixed_mean 
               gsl_stats_wtss 
               gsl_stats_wtss_m 
               gsl_stats_wabsdev 
               gsl_stats_wskew 
               gsl_stats_wkurtosis 
               gsl_stats_wvariance_m 
               gsl_stats_wsd_m 
               gsl_stats_wabsdev_m 
               gsl_stats_wskew_m_sd 
               gsl_stats_wkurtosis_m_sd 
               gsl_stats_pvariance 
               gsl_stats_ttest 
               gsl_stats_max 
               gsl_stats_min 
               gsl_stats_minmax 
               gsl_stats_max_index 
               gsl_stats_min_index 
               gsl_stats_minmax_index 
               gsl_stats_median_from_sorted_data 
               gsl_stats_quantile_from_sorted_data 
               /;
our @EXPORT_int = qw/
               gsl_stats_int_mean 
               gsl_stats_int_variance 
               gsl_stats_int_sd 
               gsl_stats_int_variance_with_fixed_mean 
               gsl_stats_int_sd_with_fixed_mean 
               gsl_stats_int_tss 
               gsl_stats_int_tss_m 
               gsl_stats_int_absdev 
               gsl_stats_int_skew 
               gsl_stats_int_kurtosis 
               gsl_stats_int_lag1_autocorrelation 
               gsl_stats_int_covariance 
               gsl_stats_int_correlation 
               gsl_stats_int_variance_m 
               gsl_stats_int_sd_m 
               gsl_stats_int_absdev_m 
               gsl_stats_int_skew_m_sd 
               gsl_stats_int_kurtosis_m_sd 
               gsl_stats_int_lag1_autocorrelation_m 
               gsl_stats_int_covariance_m 
               gsl_stats_int_pvariance 
               gsl_stats_int_ttest 
               gsl_stats_int_max 
               gsl_stats_int_min 
               gsl_stats_int_minmax 
               gsl_stats_int_max_index 
               gsl_stats_int_min_index 
               gsl_stats_int_minmax_index 
               gsl_stats_int_median_from_sorted_data 
               gsl_stats_int_quantile_from_sorted_data 
               /;
our @EXPORT_char = qw/
               gsl_stats_char_mean 
               gsl_stats_char_variance 
               gsl_stats_char_sd 
               gsl_stats_char_variance_with_fixed_mean 
               gsl_stats_char_sd_with_fixed_mean 
               gsl_stats_char_tss 
               gsl_stats_char_tss_m 
               gsl_stats_char_absdev 
               gsl_stats_char_skew 
               gsl_stats_char_kurtosis 
               gsl_stats_char_lag1_autocorrelation 
               gsl_stats_char_covariance 
               gsl_stats_char_correlation 
               gsl_stats_char_variance_m 
               gsl_stats_char_sd_m 
               gsl_stats_char_absdev_m 
               gsl_stats_char_skew_m_sd 
               gsl_stats_char_kurtosis_m_sd 
               gsl_stats_char_lag1_autocorrelation_m 
               gsl_stats_char_covariance_m 
               gsl_stats_char_pvariance 
               gsl_stats_char_ttest 
               gsl_stats_char_max 
               gsl_stats_char_min 
               gsl_stats_char_minmax 
               gsl_stats_char_max_index 
               gsl_stats_char_min_index 
               gsl_stats_char_minmax_index 
               gsl_stats_char_median_from_sorted_data 
               gsl_stats_char_quantile_from_sorted_data 
             /;
push @EXPORT_OK, @EXPORT_int, @EXPORT_char;
%EXPORT_TAGS = ( 
                all => \@EXPORT_OK,
                int => \@EXPORT_int,
                char => \@EXPORT_char
               );
__END__

=head1 NAME

Math::GSL::Statistics - Statistical functions 

=head1 SYNOPSIS

use Math::GSL::Statistics qw /:all/;

=head1 DESCRIPTION

Here is a list of all the functions in this module :

=over 2

=item * C<gsl_stats_mean($data, $stride, $n)> - This function returns the arithmetic mean of the array reference $data, a dataset of length $n with stride $stride. The arithmetic mean, or sample mean, is denoted by \Hat\mu and defined as, \Hat\mu = (1/N) \sum x_i where x_i are the elements of the dataset $data. For samples drawn from a gaussian distribution the variance of \Hat\mu is \sigma^2 / N. 

=item * C<gsl_stats_variance($data, $stride, $n)>

=item * C<gsl_stats_sd($data, $stride, $n)>

=item * C<gsl_stats_sd_m($data, $stride, $n, $mean)>

=item * C<gsl_stats_variance_with_fixed_mean($data, $stride, $n, $mean)>

=item * C<gsl_stats_sd_with_fixed_mean($data, $stride, $n, $mean)>

=item * C<gsl_stats_tss($data, $stride, $n)>

=item * C<gsl_stats_tss_m($data, $stride, $n, $mean)>

=item * C<gsl_stats_absdev($data, $stride, $n)>

=item * C<gsl_stats_skew($data, $stride, $n)>

=item * C<gsl_stats_skew_m_sd($data, $stride, $n, $mean, $sd)>

=item * C<gsl_stats_kurtosis($data, $stride, $n)>

=item * C<gsl_stats_kurtosis_m_sd($data, $stride, $n, $mean, $sd)>

=item * C<gsl_stats_lag1_autocorrelation($data, $stride, $n)>

=item * C<gsl_stats_lag1_autocorrelation_m($data, $stride, $n, $mean)>

=item * C<gsl_stats_covariance($data1, $stride1, $data2, $stride2, $n)>

=item * C<gsl_stats_covariance_m($data1, $stride1, $data2, $stride2, $n, $mean1, $mean2)>

=item * C<gsl_stats_correlation($data1, $stride1, $data2, $stride2, $n)>

=item * C<gsl_stats_variance_m($data, $stride, $n, $mean)>

=item * C<gsl_stats_absdev_m >

=item * C<gsl_stats_wmean($w, $wstride, $data, $stride, $n)> - This function returns the weighted mean of the dataset $data array reference with stride $stride and length $n, using the set of weights $w, which is an array reference, with stride $wstride and length $n. The weighted mean is defined as, \Hat\mu = (\sum w_i x_i) / (\sum w_i)

=item * C<gsl_stats_wvariance($w, $wstride, $data, $stride, $n)>

=item * C<gsl_stats_wsd($w, $wstride, $data, $stride, $n)>

=item * C<gsl_stats_wsd_m($w, $wstride, $data, $stride, $n, $wmean)>

=item * C<gsl_stats_wvariance_with_fixed_mean($w, $wstride, $data, $stride, $n, $mean)>

=item * C<gsl_stats_wsd_with_fixed_mean($w, $wstride, $data, $stride, $n, $mean)>

=item * C<gsl_stats_wtss($w, $wstride, $data, $stride, $n)>

=item * C<gsl_stats_wtss_m($w, $wstride, $data, $stride, $n, $wmean)>

=item * C<gsl_stats_wabsdev($w, $wstride, $data, $stride, $n)>

=item * C<gsl_stats_wabsdev_m($w, $wstride, $data, $stride, $n, $wmean)>

=item * C<gsl_stats_wskew($w, $wstride, $data, $stride, $n)>

=item * C<gsl_stats_wskew_m_sd($w, $wstride, $data, $stride, $n, $wmean, $wsd)>

=item * C<gsl_stats_wkurtosis($w, $wstride, $data, $stride, $n)>

=item * C<gsl_stats_wvariance_m($w, $wstride, $data, $stride, $n, $wmean, $wsd)>

=item * C<gsl_stats_wkurtosis_m_sd($w, $wstride, $data, $stride, $n, $wmean, $wsd)>

=item * C<gsl_stats_pvariance($data, $stride, $n, $data2, $stride2, $n2)>

=item * C<gsl_stats_ttest >

=item * C<gsl_stats_max($data, $stride, $n)> - This function returns the maximum value in the $data array reference, a dataset of length $n with stride $stride. The maximum value is defined as the value of the element x_i which satisfies x_i >= x_j for all j. If you want instead to find the element with the largest absolute magnitude you will need to apply fabs or abs to your data before calling this function. 

=item * C<gsl_stats_min($data, $stride, $n)>

=item * C<gsl_stats_minmax($data, $stride, $n)> - This function finds both the minimum and maximum values in $data, which is an array reference, in a single pass and returns them in this order.

=item * C<gsl_stats_max_index($data, $stride, $n)>

=item * C<gsl_stats_min_index($data, $stride, $n)>

=item * C<gsl_stats_minmax_index($data, $stride, $n)>

=item * C<gsl_stats_median_from_sorted_data($data, $stride, $n)>

=item * C<gsl_stats_quantile_from_sorted_data($data, $stride, $n, $f)>

=back

The following function are simply variants for int and char of the last functions:

=over 4

=item * C<gsl_stats_int_mean >

=item * C<gsl_stats_int_variance >

=item * C<gsl_stats_int_sd >

=item * C<gsl_stats_int_variance_with_fixed_mean >

=item * C<gsl_stats_int_sd_with_fixed_mean >

=item * C<gsl_stats_int_tss >

=item * C<gsl_stats_int_tss_m >

=item * C<gsl_stats_int_absdev >

=item * C<gsl_stats_int_skew >

=item * C<gsl_stats_int_kurtosis >

=item * C<gsl_stats_int_lag1_autocorrelation >

=item * C<gsl_stats_int_covariance >

=item * C<gsl_stats_int_correlation >

=item * C<gsl_stats_int_variance_m >

=item * C<gsl_stats_int_sd_m >

=item * C<gsl_stats_int_absdev_m >

=item * C<gsl_stats_int_skew_m_sd >

=item * C<gsl_stats_int_kurtosis_m_sd >

=item * C<gsl_stats_int_lag1_autocorrelation_m >

=item * C<gsl_stats_int_covariance_m >

=item * C<gsl_stats_int_pvariance >

=item * C<gsl_stats_int_ttest >

=item * C<gsl_stats_int_max >

=item * C<gsl_stats_int_min >

=item * C<gsl_stats_int_minmax >

=item * C<gsl_stats_int_max_index >

=item * C<gsl_stats_int_min_index >

=item * C<gsl_stats_int_minmax_index >

=item * C<gsl_stats_int_median_from_sorted_data >

=item * C<gsl_stats_int_quantile_from_sorted_data >

=item * C<gsl_stats_char_mean >

=item * C<gsl_stats_char_variance >

=item * C<gsl_stats_char_sd >

=item * C<gsl_stats_char_variance_with_fixed_mean >

=item * C<gsl_stats_char_sd_with_fixed_mean >

=item * C<gsl_stats_char_tss >

=item * C<gsl_stats_char_tss_m >

=item * C<gsl_stats_char_absdev >

=item * C<gsl_stats_char_skew >

=item * C<gsl_stats_char_kurtosis >

=item * C<gsl_stats_char_lag1_autocorrelation >

=item * C<gsl_stats_char_covariance >

=item * C<gsl_stats_char_correlation >

=item * C<gsl_stats_char_variance_m >

=item * C<gsl_stats_char_sd_m >

=item * C<gsl_stats_char_absdev_m >

=item * C<gsl_stats_char_skew_m_sd >

=item * C<gsl_stats_char_kurtosis_m_sd >

=item * C<gsl_stats_char_lag1_autocorrelation_m >

=item * C<gsl_stats_char_covariance_m >

=item * C<gsl_stats_char_pvariance >

=item * C<gsl_stats_char_ttest >

=item * C<gsl_stats_char_max >

=item * C<gsl_stats_char_min >

=item * C<gsl_stats_char_minmax >

=item * C<gsl_stats_char_max_index >

=item * C<gsl_stats_char_min_index >

=item * C<gsl_stats_char_minmax_index >

=item * C<gsl_stats_char_median_from_sorted_data >

=item * C<gsl_stats_char_quantile_from_sorted_data >

=back

You have to add the functions you want to use inside the qw /put_funtion_here /. 
You can also write use Math::GSL::Randist qw/:all/; to use all avaible functions of the module. 
Other tags are also avaible, here is a complete list of all tags for this module :

=over

=item all

=item int

=item char

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
