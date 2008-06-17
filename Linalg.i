%module Linalg
%apply int *OUTPUT { int *signum };

%{
    #include "/usr/local/include/gsl/gsl_linalg.h"
    #include "/usr/local/include/gsl/gsl_permutation.h"
%}

%include "/usr/local/include/gsl/gsl_linalg.h"
%include "/usr/local/include/gsl/gsl_permutation.h"

%perlcode %{
@EXPORT_OK = qw/$GSL_LINALG_MOD_NONE $GSL_LINALG_MOD_TRANSPOSE $GSL_LINALG_MOD_CONJUGATE
                gsl_linalg_matmult gsl_linalg_matmult_mod 
                gsl_linalg_exponential_ss 
                gsl_linalg_householder_transform 
                gsl_linalg_complex_householder_transform 
                gsl_linalg_householder_hm 
                gsl_linalg_householder_mh 
                gsl_linalg_householder_hv 
                gsl_linalg_householder_hm1 
                gsl_linalg_complex_householder_hm 
                gsl_linalg_complex_householder_mh 
                gsl_linalg_complex_householder_hv 
                gsl_linalg_hessenberg_decomp 
                gsl_linalg_hessenberg_unpack 
                gsl_linalg_hessenberg_unpack_accum 
                gsl_linalg_hessenberg_set_zero 
                gsl_linalg_hessenberg_submatrix 
                gsl_linalg_hessenberg 
                gsl_linalg_hesstri_decomp 
                gsl_linalg_SV_decomp 
                gsl_linalg_SV_decomp_mod 
                gsl_linalg_SV_decomp_jacobi 
                gsl_linalg_SV_solve 
                gsl_linalg_LU_decomp 
                gsl_linalg_LU_solve 
                gsl_linalg_LU_svx 
                gsl_linalg_LU_refine 
                gsl_linalg_LU_invert 
                gsl_linalg_LU_det 
                gsl_linalg_LU_lndet 
                gsl_linalg_LU_sgndet 
                gsl_linalg_complex_LU_decomp 
                gsl_linalg_complex_LU_solve 
                gsl_linalg_complex_LU_svx 
                gsl_linalg_complex_LU_refine 
                gsl_linalg_complex_LU_invert 
                gsl_linalg_complex_LU_det 
                gsl_linalg_complex_LU_lndet 
                gsl_linalg_complex_LU_sgndet 
                gsl_linalg_QR_decomp 
                gsl_linalg_QR_solve 
                gsl_linalg_QR_svx 
                gsl_linalg_QR_lssolve 
                gsl_linalg_QR_QRsolve 
                gsl_linalg_QR_Rsolve 
                gsl_linalg_QR_Rsvx 
                gsl_linalg_QR_update 
                gsl_linalg_QR_QTvec 
                gsl_linalg_QR_Qvec 
                gsl_linalg_QR_QTmat 
                gsl_linalg_QR_unpack 
                gsl_linalg_R_solve 
                gsl_linalg_R_svx 
                gsl_linalg_QRPT_decomp 
                gsl_linalg_QRPT_decomp2 
                gsl_linalg_QRPT_solve 
                gsl_linalg_QRPT_svx 
                gsl_linalg_QRPT_QRsolve 
                gsl_linalg_QRPT_Rsolve 
                gsl_linalg_QRPT_Rsvx 
                gsl_linalg_QRPT_update 
                gsl_linalg_LQ_decomp 
                gsl_linalg_LQ_solve_T 
                gsl_linalg_LQ_svx_T 
                gsl_linalg_LQ_lssolve_T 
                gsl_linalg_LQ_Lsolve_T 
                gsl_linalg_LQ_Lsvx_T 
                gsl_linalg_L_solve_T 
                gsl_linalg_LQ_vecQ 
                gsl_linalg_LQ_vecQT 
                gsl_linalg_LQ_unpack 
                gsl_linalg_LQ_update 
                gsl_linalg_LQ_LQsolve 
                gsl_linalg_PTLQ_decomp 
                gsl_linalg_PTLQ_decomp2 
                gsl_linalg_PTLQ_solve_T 
                gsl_linalg_PTLQ_svx_T 
                gsl_linalg_PTLQ_LQsolve_T 
                gsl_linalg_PTLQ_Lsolve_T 
                gsl_linalg_PTLQ_Lsvx_T 
                gsl_linalg_PTLQ_update 
                gsl_linalg_cholesky_decomp 
                gsl_linalg_cholesky_solve 
                gsl_linalg_cholesky_svx 
                gsl_linalg_cholesky_decomp_unit 
                gsl_linalg_complex_cholesky_decomp 
                gsl_linalg_complex_cholesky_solve 
                gsl_linalg_complex_cholesky_svx 
                gsl_linalg_symmtd_decomp 
                gsl_linalg_symmtd_unpack 
                gsl_linalg_symmtd_unpack_T 
                gsl_linalg_hermtd_decomp 
                gsl_linalg_hermtd_unpack 
                gsl_linalg_hermtd_unpack_T 
                gsl_linalg_HH_solve 
                gsl_linalg_HH_svx 
                gsl_linalg_solve_symm_tridiag 
                gsl_linalg_solve_tridiag 
                gsl_linalg_solve_symm_cyc_tridiag 
                gsl_linalg_solve_cyc_tridiag 
                gsl_linalg_bidiag_decomp 
                gsl_linalg_bidiag_unpack 
                gsl_linalg_bidiag_unpack2 
                gsl_linalg_bidiag_unpack_B 
                gsl_linalg_balance_matrix 
                gsl_linalg_balance_accum 
                gsl_linalg_balance_columns 
       /;
%EXPORT_TAGS = ( all =>[ @EXPORT_OK ] );

__END__

=head1 NAME

Math::GSL::Linalg - Functions for solving linear systems

=head1 SYPNOPSIS

    use Math::GSL::Linalg qw/:all/;

=head1 DESCRIPTION


Here is a list of all the functions included in this module :
                gsl_linalg_matmult gsl_linalg_matmult_mod 
                gsl_linalg_exponential_ss 
                gsl_linalg_householder_transform 
                gsl_linalg_complex_householder_transform 
                gsl_linalg_householder_hm 
                gsl_linalg_householder_mh 
                gsl_linalg_householder_hv 
                gsl_linalg_householder_hm1 
                gsl_linalg_complex_householder_hm 
                gsl_linalg_complex_householder_mh 
                gsl_linalg_complex_householder_hv 
                gsl_linalg_hessenberg_decomp 
                gsl_linalg_hessenberg_unpack 
                gsl_linalg_hessenberg_unpack_accum 
                gsl_linalg_hessenberg_set_zero 
                gsl_linalg_hessenberg_submatrix 
                gsl_linalg_hessenberg 
                gsl_linalg_hesstri_decomp 
                gsl_linalg_SV_decomp 
                gsl_linalg_SV_decomp_mod 
                gsl_linalg_SV_decomp_jacobi 
                gsl_linalg_SV_solve 
                gsl_linalg_LU_decomp 
                gsl_linalg_LU_solve 
                gsl_linalg_LU_svx 
                gsl_linalg_LU_refine 
                gsl_linalg_LU_invert 
                gsl_linalg_LU_det 
                gsl_linalg_LU_lndet 
                gsl_linalg_LU_sgndet 
                gsl_linalg_complex_LU_decomp 
                gsl_linalg_complex_LU_solve 
                gsl_linalg_complex_LU_svx 
                gsl_linalg_complex_LU_refine 
                gsl_linalg_complex_LU_invert 
                gsl_linalg_complex_LU_det 
                gsl_linalg_complex_LU_lndet 
                gsl_linalg_complex_LU_sgndet 
                gsl_linalg_QR_decomp 
                gsl_linalg_QR_solve 
                gsl_linalg_QR_svx 
                gsl_linalg_QR_lssolve 
                gsl_linalg_QR_QRsolve 
                gsl_linalg_QR_Rsolve 
                gsl_linalg_QR_Rsvx 
                gsl_linalg_QR_update 
                gsl_linalg_QR_QTvec 
                gsl_linalg_QR_Qvec 
                gsl_linalg_QR_QTmat 
                gsl_linalg_QR_unpack 
                gsl_linalg_R_solve 
                gsl_linalg_R_svx 
                gsl_linalg_QRPT_decomp 
                gsl_linalg_QRPT_decomp2 
                gsl_linalg_QRPT_solve 
                gsl_linalg_QRPT_svx 
                gsl_linalg_QRPT_QRsolve 
                gsl_linalg_QRPT_Rsolve 
                gsl_linalg_QRPT_Rsvx 
                gsl_linalg_QRPT_update 
                gsl_linalg_LQ_decomp 
                gsl_linalg_LQ_solve_T 
                gsl_linalg_LQ_svx_T 
                gsl_linalg_LQ_lssolve_T 
                gsl_linalg_LQ_Lsolve_T 
                gsl_linalg_LQ_Lsvx_T 
                gsl_linalg_L_solve_T 
                gsl_linalg_LQ_vecQ 
                gsl_linalg_LQ_vecQT 
                gsl_linalg_LQ_unpack 
                gsl_linalg_LQ_update 
                gsl_linalg_LQ_LQsolve 
                gsl_linalg_PTLQ_decomp 
                gsl_linalg_PTLQ_decomp2 
                gsl_linalg_PTLQ_solve_T 
                gsl_linalg_PTLQ_svx_T 
                gsl_linalg_PTLQ_LQsolve_T 
                gsl_linalg_PTLQ_Lsolve_T 
                gsl_linalg_PTLQ_Lsvx_T 
                gsl_linalg_PTLQ_update 
                gsl_linalg_cholesky_decomp 
                gsl_linalg_cholesky_solve 
                gsl_linalg_cholesky_svx 
                gsl_linalg_cholesky_decomp_unit 
                gsl_linalg_complex_cholesky_decomp 
                gsl_linalg_complex_cholesky_solve 
                gsl_linalg_complex_cholesky_svx 
                gsl_linalg_symmtd_decomp 
                gsl_linalg_symmtd_unpack 
                gsl_linalg_symmtd_unpack_T 
                gsl_linalg_hermtd_decomp 
                gsl_linalg_hermtd_unpack 
                gsl_linalg_hermtd_unpack_T 
                gsl_linalg_HH_solve 
                gsl_linalg_HH_svx 
                gsl_linalg_solve_symm_tridiag 
                gsl_linalg_solve_tridiag 
                gsl_linalg_solve_symm_cyc_tridiag 
                gsl_linalg_solve_cyc_tridiag 
                gsl_linalg_bidiag_decomp 
                gsl_linalg_bidiag_unpack 
                gsl_linalg_bidiag_unpack2 
                gsl_linalg_bidiag_unpack_B 
                gsl_linalg_balance_matrix 
                gsl_linalg_balance_accum 
                gsl_linalg_balance_columns 

 You have to add the functions you want to use inside the qw /put_funtion_here / with spaces between each function. You can also write use Math::GSL::Complex qw/:all/ to use all avaible functions of the module.

 For more informations on the functions, we refer you to the GSL offcial documentation: L<http://www.gnu.org/software/gsl/manual/html_node/>
 Tip : search on google: site:http://www.gnu.org/software/gsl/manual/html_node/ name_of_the_function_you_want

=head1 EXAMPLES


=head1 AUTHOR

Jonathan Leto <jonathan@leto.net> and Thierry Moisan <thierry.moisan@gmail.com>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2008 Jonathan Leto and Thierry Moisan

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut
%}

