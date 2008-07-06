%module Histogram2D
%{
    #include "gsl/gsl_histogram2d.h"
%}

%include "gsl/gsl_histogram2d.h"


%perlcode %{
@EXPORT_OK = qw/
               gsl_histogram2d_alloc 
               gsl_histogram2d_calloc 
               gsl_histogram2d_calloc_uniform 
               gsl_histogram2d_free 
               gsl_histogram2d_increment 
               gsl_histogram2d_accumulate 
               gsl_histogram2d_find 
               gsl_histogram2d_get 
               gsl_histogram2d_get_xrange 
               gsl_histogram2d_get_yrange 
               gsl_histogram2d_xmax 
               gsl_histogram2d_xmin 
               gsl_histogram2d_nx 
               gsl_histogram2d_ymax 
               gsl_histogram2d_ymin 
               gsl_histogram2d_ny 
               gsl_histogram2d_reset 
               gsl_histogram2d_calloc_range 
               gsl_histogram2d_set_ranges_uniform 
               gsl_histogram2d_set_ranges 
               gsl_histogram2d_memcpy 
               gsl_histogram2d_clone 
               gsl_histogram2d_max_val 
               gsl_histogram2d_max_bin 
               gsl_histogram2d_min_val 
               gsl_histogram2d_min_bin 
               gsl_histogram2d_xmean 
               gsl_histogram2d_ymean 
               gsl_histogram2d_xsigma 
               gsl_histogram2d_ysigma 
               gsl_histogram2d_cov 
               gsl_histogram2d_sum 
               gsl_histogram2d_equal_bins_p 
               gsl_histogram2d_add 
               gsl_histogram2d_sub 
               gsl_histogram2d_mul 
               gsl_histogram2d_div 
               gsl_histogram2d_scale 
               gsl_histogram2d_shift 
               gsl_histogram2d_fwrite 
               gsl_histogram2d_fread 
               gsl_histogram2d_fprintf 
               gsl_histogram2d_fscanf 
               gsl_histogram2d_pdf_alloc 
               gsl_histogram2d_pdf_init 
               gsl_histogram2d_pdf_free 
               gsl_histogram2d_pdf_sample 
             /;
%EXPORT_TAGS = ( all => [ @EXPORT_OK ] );
%}
