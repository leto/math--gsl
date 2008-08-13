%module "Math::GSL::Statistics"

%include "typemaps.i"
%include "gsl_typemaps.i"

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

=item * C<gsl_stats_sd >

=item * C<gsl_stats_sd_m >

=item * C<gsl_stats_variance_with_fixed_mean >

=item * C<gsl_stats_sd_with_fixed_mean >

=item * C<gsl_stats_tss >

=item * C<gsl_stats_tss_m >

=item * C<gsl_stats_absdev >

=item * C<gsl_stats_skew >

=item * C<gsl_stats_kurtosis >

=item * C<gsl_stats_lag1_autocorrelation >

=item * C<gsl_stats_covariance >

=item * C<gsl_stats_correlation >

=item * C<gsl_stats_variance_m($data, $stride, $n, $mean)>

=item * C<gsl_stats_absdev_m >

=item * C<gsl_stats_skew_m_sd >

=item * C<gsl_stats_kurtosis_m_sd >

=item * C<gsl_stats_lag1_autocorrelation_m >

=item * C<gsl_stats_covariance_m >

=item * C<gsl_stats_wmean >

=item * C<gsl_stats_wvariance >

=item * C<gsl_stats_wsd >

=item * C<gsl_stats_wvariance_with_fixed_mean >

=item * C<gsl_stats_wsd_with_fixed_mean >

=item * C<gsl_stats_wtss >

=item * C<gsl_stats_wtss_m >

=item * C<gsl_stats_wabsdev >

=item * C<gsl_stats_wskew >

=item * C<gsl_stats_wkurtosis >

=item * C<gsl_stats_wvariance_m >

=item * C<gsl_stats_wsd_m >

=item * C<gsl_stats_wabsdev_m >

=item * C<gsl_stats_wskew_m_sd >

=item * C<gsl_stats_wkurtosis_m_sd >

=item * C<gsl_stats_pvariance >

=item * C<gsl_stats_ttest >

=item * C<gsl_stats_max >

=item * C<gsl_stats_min >

=item * C<gsl_stats_minmax >

=item * C<gsl_stats_max_index >

=item * C<gsl_stats_min_index >

=item * C<gsl_stats_minmax_index >

=item * C<gsl_stats_median_from_sorted_data >

=item * C<gsl_stats_quantile_from_sorted_data >

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
