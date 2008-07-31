%module "Math::GSL::Linalg"
%apply int *OUTPUT { int *signum };

%{
    #include "gsl/gsl_linalg.h"
    #include "gsl/gsl_permutation.h"
%}

%include "gsl/gsl_linalg.h"
%include "gsl/gsl_permutation.h"

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

=head1 SYNOPSIS

    use Math::GSL::Linalg qw/:all/;

=head1 DESCRIPTION


Here is a list of all the functions included in this module :
                
=over

=item gsl_linalg_matmult 

=item gsl_linalg_matmult_mod 

=item gsl_linalg_exponential_ss 

=item gsl_linalg_householder_transform 

=item gsl_linalg_complex_householder_transform 

=item gsl_linalg_householder_hm($tau, $v, $A) - This function applies the Householder matrix P defined by the scalar $tau and the vector $v to the left-hand side of the matrix $A. On output the result P A is stored in $A. The function returns 0 if it succeded, 1 otherwise. 

=item gsl_linalg_householder_mh($tau, $v, $A) - This function applies the Householder matrix P defined by the scalar $tau and the vector $v to the right-hand side of the matrix $A. On output the result A P is stored in $A.

=item gsl_linalg_householder_hv($tau, $v, $w) - This function applies the Householder transformation P defined by the scalar $tau and the vector $v to the vector $w. On output the result P w is stored in $w.

=item gsl_linalg_householder_hm1 

=item gsl_linalg_complex_householder_hm($tau, $v, $A) - Does the same operation than gsl_linalg_householder_hm but with the complex matrix $A, the complex value $tau and the complex vector $v. 

=item gsl_linalg_complex_householder_mh($tau, $v, $A) - Does the same operation than gsl_linalg_householder_mh but with the complex matrix $A, the complex value $tau and the complex vector $v. 

=item gsl_linalg_complex_householder_hv($tau, $v, $w) - Does the same operation than gsl_linalg_householder_hv but with the complex value $tau and the complex vectors $v and $w. 

=item gsl_linalg_hessenberg_decomp($A, $tau) - This function computes the Hessenberg decomposition of the matrix $A by applying the similarity transformation H = U^T A U. On output, H is stored in the upper portion of $A. The information required to construct the matrix U is stored in the lower triangular portion of $A. U is a product of N - 2 Householder matrices. The Householder vectors are stored in the lower portion of $A (below the subdiagonal) and the Householder coefficients are stored in the vector $tau. tau must be of length N. The function returns 0 if it succeded, 1 otherwise. 

=item gsl_linalg_hessenberg_unpack($H, $tau, $U) - This function constructs the orthogonal matrix $U from the information stored in the Hessenberg matrix $H along with the vector $tau. $H and $tau are outputs from gsl_linalg_hessenberg_decomp. 

=item gsl_linalg_hessenberg_unpack_accum($H, $tau, $V) - This function is similar to gsl_linalg_hessenberg_unpack, except it accumulates the matrix U into $V, so that V' = VU. The matrix $V must be initialized prior to calling this function. Setting $V to the identity matrix provides the same result as gsl_linalg_hessenberg_unpack. If $H is order N, then $V must have N columns but may have any number of rows.  

=item gsl_linalg_hessenberg_set_zero($H) - This function sets the lower triangular portion of $H, below the subdiagonal, to zero. It is useful for clearing out the Householder vectors after calling gsl_linalg_hessenberg_decomp. 

=item gsl_linalg_hessenberg_submatrix 

=item gsl_linalg_hessenberg 

=item gsl_linalg_hesstri_decomp($A, $B, $U, $V, $work) - This function computes the Hessenberg-Triangular decomposition of the matrix pair ($A, $B). On output, H is stored in $A, and R is stored in $B. If $U and $V are provided (they may be null), the similarity transformations are stored in them. Additional workspace of length N is needed in the vector $work. 

=item gsl_linalg_SV_decomp($A, $V, $S, $work) - This function factorizes the M-by-N matrix $A into the singular value decomposition A = U S V^T for M >= N. On output the matrix $A is replaced by U. The diagonal elements of the singular value matrix S are stored in the vector $S. The singular values are non-negative and form a non-increasing sequence from S_1 to S_N. The matrix $V contains the elements of V in untransposed form. To form the product U S V^T it is necessary to take the transpose of V. A workspace of length N is required in vector $work. This routine uses the Golub-Reinsch SVD algorithm.  

=item gsl_linalg_SV_decomp_mod($A, $X, $V, $S, $work) - This function computes the SVD using the modified Golub-Reinsch algorithm, which is faster for M>>N. It requires the vector $work of length N and the N-by-N matrix $X as additional working space. $A and $V are matrices while $S is a vector.

=item gsl_linalg_SV_decomp_jacobi($A, $V, $S) - This function computes the SVD of the M-by-N matrix $A using one-sided Jacobi orthogonalization for M >= N. The Jacobi method can compute singular values to higher relative accuracy than Golub-Reinsch algorithms. $V is a matrix while $S is a vector.

=item gsl_linalg_SV_solve($U, $V, $S, $b, $x) - This function solves the system A x = b using the singular value decomposition ($U, $S, $V) of A given by gsl_linalg_SV_decomp. Only non-zero singular values are used in computing the solution. The parts of the solution corresponding to singular values of zero are ignored. Other singular values can be edited out by setting them to zero before calling this function. In the over-determined case where A has more rows than columns the system is solved in the least squares sense, returning the solution x which minimizes ||A x - b||_2.  

=item gsl_linalg_LU_decomp($a, $p) - factorize the matrix $a into the LU decomposition PA = LU. On output the diagonal and upper triangular part of the input matrix A contain the matrix U. The lower triangular part of the input matrix (excluding the diagonal) contains L. The diagonal elements of L are unity, and are not stored. The function returns two value, the first is 0 if the operation succeeded, 1 otherwise, and the second is the sign of the permutation. 

=item gsl_linalg_LU_solve($LU, $p, $b, $x) - This function solves the square system A x = b using the LU decomposition of the matrix A into (LU, p) given by gsl_linalg_LU_decomp. $LU is a matrix, $p a permutation and $b and $x are vectors. The function returns 1 if the operation succeded, 0 otherwise.

=item gsl_linalg_LU_svx($LU, $p, $x) - This function solves the square system A x = b in-place using the LU decomposition of A into (LU,p). On input $x should contain the right-hand side b, which is replaced by the solution on output. $LU is a matrix, $p a permutation and $x is a vector. The function returns 1 if the operation succeded, 0 otherwise.

=item gsl_linalg_LU_refine($A, $LU, $p, $b, $x, $residual) - This function apply an iterative improvement to $x, the solution of $A $x = $b, using the LU decomposition of $A into ($LU,$p). The initial residual $r = $A $x - $b (where $x and $b are vectors) is also computed and stored in the vector $residual.  

=item gsl_linalg_LU_invert($LU, $p, $inverse) - This function computes the inverse of a matrix A from its LU decomposition stored in the matrix $LU and the permutation $p, storing the result in the matrix $inverse. 

=item gsl_linalg_LU_det($LU, $signum) - This function returns the determinant of a matrix A from its LU decomposition stored in the $LU matrix. It needs the integer $signum which is the sign of the permutation returned by gsl_linalg_LU_decomp. 

=item gsl_linalg_LU_lndet($LU) - This function returns the logarithm of the absolute value of the determinant of a matrix A, from its LU decomposition stored in the $LU matrix. 

=item gsl_linalg_LU_sgndet($LU, $signum) - This functions computes the sign or phase factor of the determinant of a matrix A, det(A)/|det(A)|, from its LU decomposition, $LU. 

=item gsl_linalg_complex_LU_decomp($A, $p) - Does the same operation than gsl_linalg_LU_decomp but on the complex matrix $A. 

=item gsl_linalg_complex_LU_solve($LU, $p, $b, $x) - This functions solve the square system A x = b using the LU decomposition of A into ($LU, $p) given by  gsl_linalg_complex_LU_decomp.

=item gsl_linalg_complex_LU_svx($LU, $p, $x) - Does the same operation than gsl_linalg_LU_svx but on the complex matrix $LU and the complex vector $x. 

=item gsl_linalg_complex_LU_refine($A, $LU, $p, $b, $x, $residual) - Does the same operation than gsl_linalg_LU_refine but on the complex matrices $A and $LU and with the complex vectors $b, $x and $residual. 

=item gsl_linalg_complex_LU_invert($LU, $p, $inverse) - Does the same operation than gsl_linalg_LU_invert but on the complex matrces $LU and $inverse. 

=item gsl_linalg_complex_LU_det($LU, $signum) - Does the same operation than gsl_linalg_LU_det but on the complex matrix $LU. 

=item gsl_linalg_complex_LU_lndet($LU) - Does the same operation than gsl_linalg_LU_det but on the complex matrix $LU.  

=item gsl_linalg_complex_LU_sgndet($LU, $signum) - Does the same operation than gsl_linalg_LU_sgndet but on the complex matrix $LU. 

=item gsl_linalg_QR_decomp($a, $tau) - factorize the M-by-N matrix A into the QR decomposition A = Q R. On output the diagonal and upper triangular part of the input matrix $a contain the matrix R. The vector $tau and the columns of the lower triangular part of the matrix $a contain the Householder coefficients and Householder vectors which encode the orthogonal matrix Q. The vector tau must be of length k= min(M,N). 

=item gsl_linalg_QR_solve($QR, $tau, $b, $x) - This function solves the square system A x = b using the QR decomposition of A into (QR, tau) given by gsl_linalg_QR_decomp. $QR is matrix, and $tau, $b and $x are vectors. 

=item gsl_linalg_QR_svx($QR, $tau, $x) - This function solves the square system A x = b in-place using the QR decomposition of A into the matrix $QR and the vector $tau given by gsl_linalg_QR_decomp. On input, the vector $x should contain the right-hand side b, which is replaced by the solution on output.  

=item gsl_linalg_QR_lssolve($QR, $tau, $b, $x, $residual) - This function finds the least squares solution to the overdetermined system $A $x = $b where the matrix $A has more rows than columns. The least squares solution minimizes the Euclidean norm of the residual, ||Ax - b||.The routine uses the $QR decomposition of $A into ($QR, $tau) given by gsl_linalg_QR_decomp. The solution is returned in $x. The residual is computed as a by-product and stored in residual. The function returns 0 if it succeded, 1 otherwise.  

=item gsl_linalg_QR_QRsolve($Q, $R, $b, $x) - This function solves the system $R $x = $Q**T $b for $x. It can be used when the $QR decomposition of a matrix is available in unpacked form as ($Q, $R). The function returns 0 if it succeded, 1 otherwise.  

=item gsl_linalg_QR_Rsolve($QR, $b, $x) - This function solves the triangular system R $x = $b for $x. It may be useful if the product b' = Q^T b has already been computed using gsl_linalg_QR_QTvec. 

=item gsl_linalg_QR_Rsvx($QR, $x) - This function solves the triangular system R $x = b for $x in-place. On input $x should contain the right-hand side b and is replaced by the solution on output. This function may be useful if the product b' = Q^T b has already been computed using gsl_linalg_QR_QTvec. The function returns 0 if it succeded, 1 otherwise.

=item gsl_linalg_QR_update($Q, $R, $b, $x) - This function performs a rank-1 update $w $v**T of the QR decomposition ($Q, $R). The update is given by Q'R' = Q R + w v^T where the output matrices Q' and R' are also orthogonal and right triangular. Note that w is destroyed by the update. The function returns 0 if it succeded, 1 otherwise.

=item gsl_linalg_QR_QTvec($QR, $tau, $v) - This function applies the matrix Q^T encoded in the decomposition ($QR,$tau) to the vector $v, storing the result Q^T v in $v. The matrix multiplication is carried out directly using the encoding of the Householder vectors without needing to form the full matrix Q^T. The function returns 0 if it succeded, 1 otherwise.

=item gsl_linalg_QR_Qvec($QR, $tau, $v) - This function applies the matrix Q encoded in the decomposition ($QR,$tau) to the vector $v, storing the result Q v in $v. The matrix multiplication is carried out directly using the encoding of the Householder vectors without needing to form the full matrix Q. The function returns 0 if it succeded, 1 otherwise.

=item gsl_linalg_QR_QTmat($QR, $tau, $A) - This function applies the matrix Q^T encoded in the decomposition ($QR,$tau) to the matrix $A, storing the result Q^T A in $A. The matrix multiplication is carried out directly using the encoding of the Householder vectors without needing to form the full matrix Q^T. The function returns 0 if it succeded, 1 otherwise. 

=item gsl_linalg_QR_unpack($QR, $tau, $Q, $R) - This function unpacks the encoded QR decomposition ($QR,$tau) into the matrices $Q and $R, where $Q is M-by-M and $R is M-by-N. The function returns 0 if it succeded, 1 otherwise.

=item gsl_linalg_R_solve($R, $b, $x) - This function solves the triangular system $R $x = $b for the N-by-N matrix $R. The function returns 0 if it succeded, 1 otherwise.  

=item gsl_linalg_R_svx($R, $x) - This function solves the triangular system $R $x = b in-place. On input $x should contain the right-hand side b, which is replaced by the solution on output. The function returns 0 if it succeded, 1 otherwise. 

=item gsl_linalg_QRPT_decomp($A, $tau, $p, $norm) - This function factorizes the M-by-N matrix $A into the QRP^T decomposition A = Q R P^T. On output the diagonal and upper triangular part of the input matrix contain the matrix R. The permutation matrix P is stored in the permutation $p. There's two value returned by this function : the first is 0 if the operation succeeded, 1 otherwise. The second is sign of the permutation. It has the value (-1)^n, where n is the number of interchanges in the permutation. The vector $tau and the columns of the lower triangular part of the matrix $A contain the Householder coefficients and vectors which encode the orthogonal matrix Q. The vector tau must be of length k=\min(M,N). The matrix Q is related to these components by, Q = Q_k ... Q_2 Q_1 where Q_i = I - \tau_i v_i v_i^T and v_i is the Householder vector v_i = (0,...,1,A(i+1,i),A(i+2,i),...,A(m,i)). This is the same storage scheme as used by lapack. The vector norm is a workspace of length N used for column pivoting. The algorithm used to perform the decomposition is Householder QR with column pivoting (Golub & Van Loan, Matrix Computations, Algorithm 5.4.1).  

=item gsl_linalg_QRPT_decomp2($A, $q, $r, $tau, $p, $norm)  - This function factorizes the matrix $A into the decomposition A = Q R P^T without modifying $A itself and storing the output in the separate matrices $q and $r. For the rest, it operates exactly like gsl_linalg_QRPT_decomp

=item gsl_linalg_QRPT_solve 

=item gsl_linalg_QRPT_svx 

=item gsl_linalg_QRPT_QRsolve 

=item gsl_linalg_QRPT_Rsolve 

=item gsl_linalg_QRPT_Rsvx 

=item gsl_linalg_QRPT_update 

=item gsl_linalg_LQ_decomp 

=item gsl_linalg_LQ_solve_T 

=item gsl_linalg_LQ_svx_T 

=item gsl_linalg_LQ_lssolve_T 

=item gsl_linalg_LQ_Lsolve_T 

=item gsl_linalg_LQ_Lsvx_T 

=item gsl_linalg_L_solve_T 

=item gsl_linalg_LQ_vecQ 

=item gsl_linalg_LQ_vecQT 

=item gsl_linalg_LQ_unpack 

=item gsl_linalg_LQ_update 

=item gsl_linalg_LQ_LQsolve 

=item gsl_linalg_PTLQ_decomp 

=item gsl_linalg_PTLQ_decomp2 

=item gsl_linalg_PTLQ_solve_T 

=item gsl_linalg_PTLQ_svx_T 

=item gsl_linalg_PTLQ_LQsolve_T 

=item gsl_linalg_PTLQ_Lsolve_T 

=item gsl_linalg_PTLQ_Lsvx_T 

=item gsl_linalg_PTLQ_update 

=item gsl_linalg_cholesky_decomp($A) - Factorize the symmetric, positive-definite square matrix $A into the Cholesky decomposition A = L L^T and stores it into the matrix $A. The funtcion returns 0 if the operation succeeded, 0 otherwise.

=item gsl_linalg_cholesky_solve($cholesky, $b, $x) - This function solves the system A x = b using the Cholesky decomposition of A into the matrix $cholesky given by gsl_linalg_cholesky_decomp. $b and $x are vectors. The funtcion returns 0 if the operation succeeded, 0 otherwise.

=item gsl_linalg_cholesky_svx($cholesky, $x) - This function solves the system A x = b in-place using the Cholesky decomposition of A into the matrix $cholesky given by gsl_linalg_cholesky_decomp. On input the vector $x should contain the right-hand side b, which is replaced by the solution on output. The funtcion returns 0 if the operation succeeded, 0 otherwise.   

=item gsl_linalg_cholesky_decomp_unit 

=item gsl_linalg_complex_cholesky_decomp($A) - Factorize the symmetric, positive-definite square matrix $A which contains complex numbers into the Cholesky decomposition A = L L^T and stores it into the matrix $A. The funtcion returns 0 if the operation succeeded, 0 otherwise. 

=item gsl_linalg_complex_cholesky_solve($cholesky, $b, $x) - This function solves the system A x = b using the Cholesky decomposition of A into the matrix $cholesky given by gsl_linalg_complex_cholesky_decomp. $b and $x are vectors. The funtcion returns 0 if the operation succeeded, 0 otherwise.

=item gsl_linalg_complex_cholesky_svx($cholesky, $x) - This function solves the system A x = b in-place using the Cholesky decomposition of A into the matrix $cholesky given by gsl_linalg_complex_cholesky_decomp. On input the vector $x should contain the right-hand side b, which is replaced by the solution on output. The funtcion returns 0 if the operation succeeded, 0 otherwise.    

=item gsl_linalg_symmtd_decomp($A, $tau) - This function factorizes the symmetric square matrix $A into the symmetric tridiagonal decomposition Q T Q^T. On output the diagonal and subdiagonal part of the input matrix $A contain the tridiagonal matrix T. The remaining lower triangular part of the input matrix contains the Householder vectors which, together with the Householder coefficients $tau, encode the orthogonal matrix Q. This storage scheme is the same as used by lapack. The upper triangular part of $A is not referenced. $tau is a vector.  

=item gsl_linalg_symmtd_unpack($A, $tau, $Q, $diag, $subdiag) - This function unpacks the encoded symmetric tridiagonal decomposition ($A, $tau) obtained from gsl_linalg_symmtd_decomp into the orthogonal matrix $Q, the vector of diagonal elements $diag and the vector of subdiagonal elements $subdiag.  

=item gsl_linalg_symmtd_unpack_T($A, $diag, $subdiag) - This function unpacks the diagonal and subdiagonal of the encoded symmetric tridiagonal decomposition ($A, $tau) obtained from gsl_linalg_symmtd_decomp into the vectors $diag and $subdiag.  

=item gsl_linalg_hermtd_decomp($A, $tau) - This function factorizes the hermitian matrix $A into the symmetric tridiagonal decomposition U T U^T. On output the real parts of the diagonal and subdiagonal part of the input matrix $A contain the tridiagonal matrix T. The remaining lower triangular part of the input matrix contains the Householder vectors which, together with the Householder coefficients $tau, encode the orthogonal matrix Q. This storage scheme is the same as used by lapack. The upper triangular part of $A and imaginary parts of the diagonal are not referenced. $A is a complex matrix and $tau a complex vector. 

=item gsl_linalg_hermtd_unpack($A, $tau, $U, $diag, $subdiag) - This function unpacks the encoded tridiagonal decomposition ($A, $tau) obtained from gsl_linalg_hermtd_decomp into the unitary complex  matrix $U, the real vector of diagonal elements $diag and the real vector of subdiagonal elements $subdiag.  

=item gsl_linalg_hermtd_unpack_T($A, $diag, $subdiag) - This function unpacks the diagonal and subdiagonal of the encoded tridiagonal decomposition (A, tau) obtained from the gsl_linalg_hermtd_decomp into the real vectors $diag and $subdiag.  

=item gsl_linalg_HH_solve($a, $b, $x) - This function solves the system $A $x = $b directly using Householder transformations where $A is a matrix, $b and $x vectors. On output the solution is stored in $x and $b is not modified. $A is destroyed by the Householder transformations.  

=item gsl_linalg_HH_svx($A, $x) - This function solves the system $A $x = b in-place using Householder transformations where $A is a matrix, $b is a vector. On input $x should contain the right-hand side b, which is replaced by the solution on output. The matrix $A is destroyed by the Householder transformations.  

=item gsl_linalg_solve_symm_tridiag 

=item gsl_linalg_solve_tridiag 

=item gsl_linalg_solve_symm_cyc_tridiag 

=item gsl_linalg_solve_cyc_tridiag 

=item gsl_linalg_bidiag_decomp 

=item gsl_linalg_bidiag_unpack 

=item gsl_linalg_bidiag_unpack2 

=item gsl_linalg_bidiag_unpack_B 

=item gsl_linalg_balance_matrix 

=item gsl_linalg_balance_accum 

=item gsl_linalg_balance_columns 


 You have to add the functions you want to use inside the qw /put_funtion_here / with spaces between each function. You can also write use Math::GSL::Complex qw/:all/ to use all avaible functions of the module.

For more informations on the functions, we refer you to the GSL offcial documentation: L<http://www.gnu.org/software/gsl/manual/html_node/>
 Tip : search on google: site:http://www.gnu.org/software/gsl/manual/html_node/ name_of_the_function_you_want

=back

=head1 EXAMPLES

This example shows how to compute the determinant of a matrix with the LU decomposition:

 use Math::GSL::Matrix qw/:all/;
 use Math::GSL::Permutation qw/:all/;
 use Math::GSL::Linalg qw/:all/;
 
 my $Matrix = gsl_matrix_alloc(4,4);
 map { gsl_matrix_set($Matrix, 0, $_, $_+1) } (0..3);
 
 gsl_matrix_set($Matrix,1, 0, 2);
 gsl_matrix_set($Matrix, 1, 1, 3);
 gsl_matrix_set($Matrix, 1, 2, 4);
 gsl_matrix_set($Matrix, 1, 3, 1);

 gsl_matrix_set($Matrix, 2, 0, 3);
 gsl_matrix_set($Matrix, 2, 1, 4);
 gsl_matrix_set($Matrix, 2, 2, 1);
 gsl_matrix_set($Matrix, 2, 3, 2);

 gsl_matrix_set($Matrix, 3, 0, 4);
 gsl_matrix_set($Matrix, 3, 1, 1);
 gsl_matrix_set($Matrix, 3, 2, 2);
 gsl_matrix_set($Matrix, 3, 3, 3);
    
 my $permutation = gsl_permutation_alloc(4);
 gsl_permutation_init($permutation);
 my ($result, $signum) = gsl_linalg_LU_decomp($Matrix, $permutation);
 my $det = gsl_linalg_LU_det($Matrix, $signum);
 print "The value of the determinant of the matrix is $det \n";

=head1 AUTHORS

Jonathan Leto <jonathan@leto.net> and Thierry Moisan <thierry.moisan@gmail.com>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2008 Jonathan Leto and Thierry Moisan

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut
%}

