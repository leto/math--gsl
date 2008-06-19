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
                gsl_linalg_LU_decomp($a, $p) - factorize the matrix $a into the LU decomposition PA = LU. On output the diagonal and upper triangular part of the input matrix A contain the matrix U. The lower triangular part of the input matrix (excluding the diagonal) contains L. The diagonal elements of L are unity, and are not stored. The function returns two value, the first is 0 if the operation succeeded, 1 otherwise, and the second is the sign of the permutation. 
                gsl_linalg_LU_solve($LU, $p, $b, $x) - This function solves the square system A x = b using the LU decomposition of the matrix A into (LU, p) given by gsl_linalg_LU_decomp. $LU is a matrix, $p a permutation and $b and $x are vectors. The function returns 1 if the operation succeded, 0 otherwise.
                gsl_linalg_LU_svx($LU, $p, $x) - This function solves the square system A x = b in-place using the LU decomposition of A into (LU,p). On input $x should contain the right-hand side b, which is replaced by the solution on output. $LU is a matrix, $p a permutation and $x is a vector. The function returns 1 if the operation succeded, 0 otherwise.
                gsl_linalg_LU_refine 
                gsl_linalg_LU_invert($LU, $p, $inverse) - This function computes the inverse of a matrix A from its LU decomposition stored in the matrix $LU and the permutation $p, storing the result in the matrix $inverse. 
                gsl_linalg_LU_det($LU, $signum) - This function returns the determinant of a matrix A from its LU decomposition stored in the $LU matrix. It needs the integer $signum which is the sign of the permutation returned by gsl_linalg_LU_decomp. 
                gsl_linalg_LU_lndet($LU) - This function returns the logarithm of the absolute value of the determinant of a matrix A, from its LU decomposition stored in the $LU matrix. 
                gsl_linalg_LU_sgndet 
                gsl_linalg_complex_LU_decomp
                gsl_linalg_complex_LU_solve 
                gsl_linalg_complex_LU_svx 
                gsl_linalg_complex_LU_refine 
                gsl_linalg_complex_LU_invert 
                gsl_linalg_complex_LU_det 
                gsl_linalg_complex_LU_lndet 
                gsl_linalg_complex_LU_sgndet 
                gsl_linalg_QR_decomp($a, $tau) - factorize the M-by-N matrix A into the QR decomposition A = Q R. On output the diagonal and upper triangular part of the input matrix $a contain the matrix R. The vector $tau and the columns of the lower triangular part of the matrix $a contain the Householder coefficients and Householder vectors which encode the orthogonal matrix Q. The vector tau must be of length k= min(M,N). 
                gsl_linalg_QR_solve($QR, $tau, $b, $x) - This function solves the square system A x = b using the QR decomposition of A into (QR, tau) given by gsl_linalg_QR_decomp. $QR is matrix, and $tau, $b and $x are vectors. 
                gsl_linalg_QR_svx($QR, $tau, $x) - This function solves the square system A x = b in-place using the QR decomposition of A into the matrix $QR and the vector $tau given by gsl_linalg_QR_decomp. On input, the vector $x should contain the right-hand side b, which is replaced by the solution on output.  
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
                gsl_linalg_cholesky_decomp($A) - Factorize the symmetric, positive-definite square matrix $A into the Cholesky decomposition A = L L^T and stores it into the matrix $A. The funtcion returns 0 if the operation succeeded, 0 otherwise.
                gsl_linalg_cholesky_solve($cholesky, $b, $x) - This function solves the system A x = b using the Cholesky decomposition of A into the matrix $cholesky given by gsl_linalg_cholesky_decomp. $b and $x are vectors. The funtcion returns 0 if the operation succeeded, 0 otherwise.
                gsl_linalg_cholesky_svx($cholesky, $x) - This function solves the system A x = b in-place using the Cholesky decomposition of A into the matrix $cholesky given by gsl_linalg_cholesky_decomp. On input the vector $x should contain the right-hand side b, which is replaced by the solution on output. The funtcion returns 0 if the operation succeeded, 0 otherwise.   
                gsl_linalg_cholesky_decomp_unit 
                gsl_linalg_complex_cholesky_decomp($A) - Factorize the symmetric, positive-definite square matrix $A which contains complex numbers into the Cholesky decomposition A = L L^T and stores it into the matrix $A. The funtcion returns 0 if the operation succeeded, 0 otherwise. 
                gsl_linalg_complex_cholesky_solve($cholesky, $b, $x) - This function solves the system A x = b using the Cholesky decomposition of A into the matrix $cholesky given by gsl_linalg_complex_cholesky_decomp. $b and $x are vectors. The funtcion returns 0 if the operation succeeded, 0 otherwise.
                gsl_linalg_complex_cholesky_svx($cholesky, $x) - This function solves the system A x = b in-place using the Cholesky decomposition of A into the matrix $cholesky given by gsl_linalg_complex_cholesky_decomp. On input the vector $x should contain the right-hand side b, which is replaced by the solution on output. The funtcion returns 0 if the operation succeeded, 0 otherwise.    
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

