%module "Math::GSL::Statistics"
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
%}
