%module BLAS
%{
    #include "/usr/local/include/gsl/gsl_blas.h"
    #include "/usr/local/include/gsl/gsl_blas_types.h"
%}

%include "/usr/local/include/gsl/gsl_blas.h"
%include "/usr/local/include/gsl/gsl_blas_types.h"

%perlcode %{

@EXPORT_OK_level1 = qw/
                        gsl_blas_sdsdot gsl_blas_dsdot gsl_blas_sdot gsl_blas_ddot 
                        gsl_blas_cdotu gsl_blas_cdotc gsl_blas_zdotu gsl_blas_zdotc 
                        gsl_blas_snrm2 gsl_blas_sasum gsl_blas_dnrm2 gsl_blas_dasum 
                        gsl_blas_scnrm2 gsl_blas_scasum gsl_blas_dznrm2 gsl_blas_dzasum 
                        gsl_blas_isamax gsl_blas_idamax gsl_blas_icamax gsl_blas_izamax 
                        gsl_blas_sswap gsl_blas_scopy gsl_blas_saxpy gsl_blas_dswap 
                        gsl_blas_dcopy gsl_blas_daxpy gsl_blas_cswap gsl_blas_ccopy 
                        gsl_blas_caxpy gsl_blas_zswap gsl_blas_zcopy gsl_blas_zaxpy 
                        gsl_blas_srotg gsl_blas_srotmg gsl_blas_srot gsl_blas_srotm 
                        gsl_blas_drotg gsl_blas_drotmg gsl_blas_drot gsl_blas_drotm 
                        gsl_blas_sscal gsl_blas_dscal gsl_blas_cscal gsl_blas_zscal 
                        gsl_blas_csscal gsl_blas_zdscal
                    /;
@EXPORT_OK_level2 = qw/
                        gsl_blas_sgemv gsl_blas_strmv 
                        gsl_blas_strsv gsl_blas_dgemv gsl_blas_dtrmv gsl_blas_dtrsv 
                        gsl_blas_cgemv gsl_blas_ctrmv gsl_blas_ctrsv gsl_blas_zgemv 
                        gsl_blas_ztrmv gsl_blas_ztrsv gsl_blas_ssymv gsl_blas_sger 
                        gsl_blas_ssyr gsl_blas_ssyr2 gsl_blas_dsymv gsl_blas_dger 
                        gsl_blas_dsyr gsl_blas_dsyr2 gsl_blas_chemv gsl_blas_cgeru 
                        gsl_blas_cgerc gsl_blas_cher gsl_blas_cher2 gsl_blas_zhemv 
                        gsl_blas_zgeru gsl_blas_zgerc gsl_blas_zher gsl_blas_zher2 
                    /;

@EXPORT_OK_level3 = qw/
                        gsl_blas_sgemm gsl_blas_ssymm gsl_blas_ssyrk gsl_blas_ssyr2k 
                        gsl_blas_strmm gsl_blas_strsm gsl_blas_dgemm gsl_blas_dsymm 
                        gsl_blas_dsyrk gsl_blas_dsyr2k gsl_blas_dtrmm gsl_blas_dtrsm 
                        gsl_blas_cgemm gsl_blas_csymm gsl_blas_csyrk gsl_blas_csyr2k 
                        gsl_blas_ctrmm gsl_blas_ctrsm gsl_blas_zgemm gsl_blas_zsymm 
                        gsl_blas_zsyrk gsl_blas_zsyr2k gsl_blas_ztrmm gsl_blas_ztrsm 
                        gsl_blas_chemm gsl_blas_cherk gsl_blas_cher2k gsl_blas_zhemm 
                        gsl_blas_zherk gsl_blas_zher2k 
                    /;
@EXPORT_OK = (@EXPORT_OK_level1, @EXPORT_OK_level2, @EXPORT_OK_level3);
%EXPORT_TAGS = (
                all    => [ @EXPORT ],
                level1 => [ @EXPORT_OK_level1 ],  
                level2 => [ @EXPORT_OK_level2 ],  
                level3 => [ @EXPORT_OK_level3 ],  
               );

%}
