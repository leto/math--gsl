%module "Math::GSL::Histogram"
%include "typemaps.i"
%include "gsl_typemaps.i"

%{
    #include "gsl/gsl_histogram.h"
%}

%include "gsl/gsl_histogram.h"


%perlcode %{
@EXPORT_OK = qw/
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
%}
