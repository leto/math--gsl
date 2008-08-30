%module "Math::GSL::Eigen"
%{
    #include "gsl/gsl_eigen.h"
    #include "gsl/gsl_complex.h"
    #include "gsl/gsl_vector_complex.h"
%}

%include "gsl/gsl_eigen.h"
%include "gsl/gsl_complex.h"
%include "gsl/gsl_vector_complex.h"

%perlcode %{

@EXPORT_OK = qw/
                gsl_eigen_symm_alloc gsl_eigen_symm_free 
                gsl_eigen_symm gsl_eigen_symmv_alloc gsl_eigen_symmv_free gsl_eigen_symmv 
                gsl_eigen_herm_alloc gsl_eigen_herm_free gsl_eigen_herm gsl_eigen_hermv_alloc 
                gsl_eigen_hermv_free gsl_eigen_hermv gsl_eigen_francis_alloc gsl_eigen_francis_free 
                gsl_eigen_francis_T gsl_eigen_francis gsl_eigen_francis_Z gsl_eigen_nonsymm_alloc 
                gsl_eigen_nonsymm_free gsl_eigen_nonsymm_params gsl_eigen_nonsymm 
                gsl_eigen_nonsymm_Z gsl_eigen_nonsymmv_alloc gsl_eigen_nonsymmv_free 
                gsl_eigen_nonsymmv gsl_eigen_nonsymmv_Z gsl_eigen_gensymm_alloc 
                gsl_eigen_gensymm_free gsl_eigen_gensymm gsl_eigen_gensymm_standardize 
                gsl_eigen_gensymmv_alloc gsl_eigen_gensymmv_free gsl_eigen_gensymmv 
                gsl_eigen_genherm_alloc gsl_eigen_genherm_free gsl_eigen_genherm 
                gsl_eigen_genherm_standardize gsl_eigen_genhermv_alloc gsl_eigen_genhermv_free 
                gsl_eigen_genhermv gsl_eigen_gen_alloc gsl_eigen_gen_free 
                gsl_eigen_gen_params gsl_eigen_gen gsl_eigen_gen_QZ 
                gsl_eigen_genv_alloc gsl_eigen_genv_free gsl_eigen_genv 
                gsl_eigen_genv_QZ gsl_eigen_symmv_sort gsl_eigen_hermv_sort 
                gsl_eigen_nonsymmv_sort gsl_eigen_gensymmv_sort gsl_eigen_genhermv_sort 
                gsl_eigen_genv_sort gsl_schur_gen_eigvals gsl_schur_solve_equation 
                gsl_schur_solve_equation_z gsl_eigen_jacobi gsl_eigen_invert_jacobi 
                $GSL_EIGEN_SORT_VAL_ASC $GSL_EIGEN_SORT_VAL_DESC 
                $GSL_EIGEN_SORT_ABS_ASC $GSL_EIGEN_SORT_ABS_DESC 
            /;
%EXPORT_TAGS = ( all => [ @EXPORT_OK ] );

__END__

=head1 NAME

Math::GSL::Eigen - Functions for computing eigenvalues and eigenvectors of matrices

=head1 SYNOPSIS

use Math::GSL::Eigen qw/:all/;

=head1 DESCRIPTION

Here is a list of all the functions included in this module :

=over

=item gsl_eigen_symm_alloc($n) - This function returns a workspace for computing eigenvalues of n-by-n real symmetric matrices.

=item gsl_eigen_symm_free($w) - This function frees the memory associated with the workspace $w.  

=item gsl_eigen_symm($A, $eval, $w) - This function computes the eigenvalues of the real symmetric matrix $A. Additional workspace of the appropriate size must be provided in $w. The diagonal and lower triangular part of $A are destroyed during the computation, but the strict upper triangular part is not referenced. The eigenvalues are stored in the vector $eval and are unordered. 

=item gsl_eigen_symmv_alloc($n) - This function returns a workspace for computing eigenvalues and eigenvectors of n-by-n real symmetric matrices.

=item gsl_eigen_symmv_free($w) - This function frees the memory associated with the workspace $w. 

=item gsl_eigen_symmv($A, $eval, $evec, $w) - This function computes the eigenvalues and eigenvectors of the real symmetric matrix $A. Additional workspace of the appropriate size must be provided in $w. The diagonal and lower triangular part of $A are destroyed during the computation, but the strict upper triangular part is not referenced. The eigenvalues are stored in the vector $eval and are unordered. The corresponding eigenvectors are stored in the columns of the matrix $evec. 

=item gsl_eigen_herm_alloc($n) - This function returns a workspace for computing eigenvalues of n-by-n complex hermitian matrices.

=item gsl_eigen_herm_free($w) - This function frees the memory associated with the workspace $w.  

=item gsl_eigen_herm($A, $eval, $w) - This function computes the eigenvalues of the complex hermitian matrix $A. Additional workspace of the appropriate size must be provided in $w. The diagonal and lower triangular part of $A are destroyed during the computation, but the strict upper triangular part is not referenced. The imaginary parts of the diagonal are assumed to be zero and are not referenced. The eigenvalues are stored in the vector $eval and are unordered. 

=item gsl_eigen_hermv_alloc($n) - This function returns a workspace for computing eigenvalues and eigenvectors of n-by-n complex hermitian matrices. 

=item gsl_eigen_hermv_free($w) - This function frees the memory associated with the workspace $w. 

=item gsl_eigen_hermv($A, $eval, $evec, $w) - This function computes the eigenvalues and eigenvectors of the complex hermitian matrix $A. Additional workspace of the appropriate size must be provided in $w. The diagonal and lower triangular part of $A are destroyed during the computation, but the strict upper triangular part is not referenced. The imaginary parts of the diagonal are assumed to be zero and are not referenced. The eigenvalues are stored in the vector $eval and are unordered. The corresponding complex eigenvectors are stored in the columns of the matrix $evec.

=item gsl_eigen_francis_alloc($n) - 

=item gsl_eigen_francis_free($w) - This function frees the memory associated with the workspace $w. 

=item gsl_eigen_francis_T

=item gsl_eigen_francis

=item gsl_eigen_francis_Z

=item gsl_eigen_nonsymm_alloc($n) - This function returns a workspace for computing eigenvalues of n-by-n real nonsymmetric matrices. 

=item gsl_eigen_nonsymm_free($w) - This function frees the memory associated with the workspace $w. 

=item gsl_eigen_nonsymm_params($compute_t, $balance, $w) - This function sets some parameters which determine how the eigenvalue problem is solved in subsequent calls to gsl_eigen_nonsymm. If $compute_t is set to 1, the full Schur form T will be computed by gsl_eigen_nonsymm. If it is set to 0, T will not be computed (this is the default setting). If balance is set to 1, a balancing transformation is applied to the matrix prior to computing eigenvalues. This transformation is designed to make the rows and columns of the matrix have comparable norms, and can result in more accurate eigenvalues for matrices whose entries vary widely in magnitude. 

=item gsl_eigen_nonsymm($A, $eval, $w) - This function computes the eigenvalues of the real nonsymmetric matrix $A and stores them in the vector $eval. If T is desired, it is stored in the upper portion of $A on output. Otherwise, on output, the diagonal of $A will contain the 1-by-1 real eigenvalues and 2-by-2 complex conjugate eigenvalue systems, and the rest of $A is destroyed. In rare cases, this function may fail to find all eigenvalues. If this happens, an error code is returned (1) and the number of converged eigenvalues is stored in $w->{n_evals}. The converged eigenvalues are stored in the beginning of $eval.

=item gsl_eigen_nonsymm_Z($A, $eval, $Z, $w) - This function is identical to gsl_eigen_nonsymm except it also computes the Schur vectors and stores them into the $Z matrix. 

=item gsl_eigen_nonsymmv_alloc($n) - This function allocates a workspace for computing eigenvalues and eigenvectors of n-by-n real nonsymmetric matrices.

=item gsl_eigen_nonsymmv_free($w) - This function frees the memory associated with the workspace $w. 

=item gsl_eigen_nonsymmv($A, $eval, $evec, $w) - This function computes eigenvalues and right eigenvectors of the n-by-n real nonsymmetric matrix $A. It first calls gsl_eigen_nonsymm to compute the eigenvalues, Schur form T, and Schur vectors. Then it finds eigenvectors of T and backtransforms them using the Schur vectors. The Schur vectors are destroyed in the process, but can be saved by using gsl_eigen_nonsymmv_Z. The computed eigenvectors are normalized to have unit magnitude. On output, the upper portion of $A contains the Schur form T. If gsl_eigen_nonsymm fails, no eigenvectors are computed, and an error code is returned (1). $eval is a complex vector and $evec is a complex matrix.

=item gsl_eigen_nonsymmv_Z($A, $eval, $evec, $Z, $w) - This function is identical to gsl_eigen_nonsymmv except it also saves the Schur vectors into the $Z matrix. 

=item gsl_eigen_gensymm_alloc($n) - This function allocates a workspace for computing eigenvalues of n-by-n real generalized symmetric-definite eigensystems.

=item gsl_eigen_gensymm_free($w) - This function frees the memory associated with the workspace $w. 

=item gsl_eigen_gensymm($A, $B, $eval, $w) - This function computes the eigenvalues of the real generalized symmetric-definite matrix pair ($A, $B), and stores them in the vector $eval. On output, $B contains its Cholesky decomposition and $A is destroyed. 

=item gsl_eigen_gensymm_standardize 

=item gsl_eigen_gensymmv_alloc($n) - This function allocates a workspace for computing eigenvalues and eigenvectors of n-by-n real generalized symmetric-definite eigensystems.

=item gsl_eigen_gensymmv_free($w) - This function frees the memory associated with the workspace $w. 

=item gsl_eigen_gensymmv($A, $B, $eval, $evec, $w) - This function computes the eigenvalues and eigenvectors of the real generalized symmetric-definite matrix pair ($A, $B), and stores them in $eval vector and $evec matrix respectively. The computed eigenvectors are normalized to have unit magnitude. On output, $B contains its Cholesky decomposition and A is destroyed.  

=item gsl_eigen_genherm_alloc($n) - This function allocates a workspace for computing eigenvalues of n-by-n complex generalized hermitian-definite eigensystems.

=item gsl_eigen_genherm_free($w) - This function frees the memory associated with the workspace $w. 

=item gsl_eigen_genherm($A, $B, $eval, $w) - This function computes the eigenvalues of the complex generalized hermitian-definite matrix pair ($A, $B), and stores them in the $eval vector. On output, $B contains its Cholesky decomposition and $A is destroyed. 

=item gsl_eigen_genherm_standardize

=item gsl_eigen_genhermv_alloc($n) - This function allocates a workspace for computing eigenvalues and eigenvectors of n-by-n complex generalized hermitian-definite eigensystems. 

=item gsl_eigen_genhermv_free($w) - This function frees the memory associated with the workspace $w. 

=item gsl_eigen_genhermv($A, $B, $eval, $evec, $w) - This function computes the eigenvalues and eigenvectors of the complex generalized hermitian-definite matrix pair ($A, $B), and stores them in $eval vector and $evec matrix respectively. The computed eigenvectors are normalized to have unit magnitude. On output, $B contains its Cholesky decomposition and $A is destroyed.

=item gsl_eigen_gen_alloc($n) - This function allocates a workspace for computing eigenvalues of n-by-n real generalized nonsymmetric eigensystems.

=item gsl_eigen_gen_free($w) - This function frees the memory associated with the workspace $w.  

=item gsl_eigen_gen_params($compute_s, $compute_t, $balance, $w) - This function sets some parameters which determine how the eigenvalue problem is solved in subsequent calls to gsl_eigen_gen. If $compute_s is set to 1, the full Schur form S will be computed by gsl_eigen_gen. If it is set to 0, S will not be computed (this is the default setting). S is a quasi upper triangular matrix with 1-by-1 and 2-by-2 blocks on its diagonal. 1-by-1 blocks correspond to real eigenvalues, and 2-by-2 blocks correspond to complex eigenvalues. If $compute_t is set to 1, the full Schur form T will be computed by gsl_eigen_gen. If it is set to 0, T will not be computed (this is the default setting). T is an upper triangular matrix with non-negative elements on its diagonal. Any 2-by-2 blocks in S will correspond to a 2-by-2 diagonal block in T. The $balance parameter is currently ignored, since generalized balancing is not yet implemented. 

=item gsl_eigen_gen($A, $B, $alpha, $beta, $w) - This function computes the eigenvalues of the real generalized nonsymmetric matrix pair ($A, $B), and stores them as pairs in ($alpha, $beta), where $alpha is complex and $beta is real, both are vectors. The elements of $beta are normalized to be non-negative. If S is desired, it is stored in $A on output. If T is desired, it is stored in $B on output. The ordering of eigenvalues in ($alpha, $beta) follows the ordering of the diagonal blocks in the Schur forms S and T. In rare cases, this function may fail to find all eigenvalues. If this occurs, an error code is returned (1). 

=item gsl_eigen_gen_QZ($A, $B, $alpha, $beta, $Q, $Z, $w) - This function is identical to gsl_eigen_gen except it also computes the left and right Schur vectors and stores them into $Q matrix and $Z matrix respectively.  

=item gsl_eigen_genv_alloc($n) - This function allocates a workspace for computing eigenvalues and eigenvectors of n-by-n real generalized nonsymmetric eigensystems.

=item gsl_eigen_genv_free($w) - This function frees the memory associated with the workspace $w. 

=item gsl_eigen_genv($A, $B, $alpha, $beta, $evec, $w) - This function computes eigenvalues and right eigenvectors of the n-by-n real generalized nonsymmetric matrix pair ($A, $B). The eigenvalues are stored in ($alpha, $beta) where $alpha is a complex vector and $beta a real vector and the eigenvectors are stored in $evec complex matrix. It first calls gsl_eigen_gen to compute the eigenvalues, Schur forms, and Schur vectors. Then it finds eigenvectors of the Schur forms and backtransforms them using the Schur vectors. The Schur vectors are destroyed in the process, but can be saved by using gsl_eigen_genv_QZ. The computed eigenvectors are normalized to have unit magnitude. On output, ($A, $B) contains the generalized Schur form (S, T). If gsl_eigen_gen fails, no eigenvectors are computed, and an error code is returned (1). 

=item gsl_eigen_genv_QZ($A, $B, $alpha, $beta, $evec, $Q, $Z, $w) - This function is identical to gsl_eigen_genv except it also computes the left and right Schur vectors and stores them into $Q and $Z matrices respectively.

=item gsl_eigen_symmv_sort($eval, $evec, $sort_type) - This function simultaneously sorts the eigenvalues stored in the vector $eval and the corresponding real eigenvectors stored in the columns of the matrix $evec according to the value of the parameter $sort_type which is one of the constant included in this module.

=item gsl_eigen_hermv_sort($eval, $evec, $sort_type) - This function simultaneously sorts the eigenvalues stored in the vector $eval and the corresponding real eigenvectors stored in the columns of the matrix $evec according to the value of the parameter $sort_type which is one of the constant included in this module. 

=item gsl_eigen_nonsymmv_sort($eval, $evec, $sort_type) - This function simultaneously sorts the eigenvalues stored in the vector $eval and the corresponding complex eigenvectors stored in the columns of the complex matrix $evec into ascending or descending order according to the value of the parameter $sort_type. Only $GSL_EIGEN_SORT_ABS_ASC and $GSL_EIGEN_SORT_ABS_DESC are supported due to the eigenvalues being complex. 

=item gsl_eigen_gensymmv_sort($eval, $evec, $sort_type) - This function simultaneously sorts the eigenvalues stored in the vector $eval and the corresponding real eigenvectors stored in the columns of the matrix $evec according to the value of the parameter $sort_type which is one of the constant included in this module.

=item gsl_eigen_genhermv_sort($eval, $evec, $sort_type) - This function simultaneously sorts the eigenvalues stored in the vector $eval and the corresponding real eigenvectors stored in the columns of the matrix $evec according to the value of the parameter $sort_type which is one of the constant included in this module.

=item gsl_eigen_genv_sort($eval, $evec, $sort_type) - This function simultaneously sorts the eigenvalues stored in the vector $eval and the corresponding complex eigenvectors stored in the columns of the complex matrix $evec into ascending or descending order according to the value of the parameter $sort_type. Only $GSL_EIGEN_SORT_ABS_ASC and $GSL_EIGEN_SORT_ABS_DESC are supported due to the eigenvalues being complex. 

=item gsl_schur_gen_eigvals

=item gsl_schur_solve_equation 

=item gsl_schur_solve_equation_z

=item gsl_eigen_jacobi

=item gsl_eigen_invert_jacobi

=back 

This module also includes these constants : 

=over

=item $GSL_EIGEN_SORT_VAL_ASC - ascending order in numerical value

=item $GSL_EIGEN_SORT_VAL_DESC - descending order in numerical value 

=item $GSL_EIGEN_SORT_ABS_ASC - ascending order in magnitude 

=item $GSL_EIGEN_SORT_ABS_DESC - descending order in magnitude 

=back

For more informations on the functions, we refer you to the GSL offcial documentation: 
L<http://www.gnu.org/software/gsl/manual/html_node/>

Tip : search on google: site:http://www.gnu.org/software/gsl/manual/html_node/ name_of_the_function_you_want

=head1 EXAMPLES

This example shows how to use the gsl_eigen_symmv functions to find the eigenvalues and eigenvectors of a matrix.

 use Math::GSL::Vector qw/:all/;
 use Math::GSL::Matrix qw/:all/;
 use Math::GSL::Eigen qw/:all/;
 my $w = gsl_eigen_symmv_alloc(2);
 my $m = gsl_matrix_alloc(2,2);
 gsl_matrix_set($m, 0, 0, 2);
 gsl_matrix_set($m, 0, 1, 1);
 gsl_matrix_set($m, 1, 0, 1);
 gsl_matrix_set($m, 1, 1, 2);
 my $eval = gsl_vector_alloc(2);
 my $evec = gsl_matrix_alloc(2,2);
 gsl_eigen_symmv($m, $eval, $evec, $w);
 gsl_eigen_gensymmv_sort($eval, $evec, $GSL_EIGEN_SORT_ABS_ASC);
 print "The first eigenvalue is : " . gsl_vector_get($eval, 0) . "\n";
 print "The second eigenvalue is : " . gsl_vector_get($eval, 1) . "\n";
 my $x = gsl_matrix_get($evec, 0, 0);
 my $y = gsl_matrix_get($evec, 0, 1);
 print "The first eigenvector is [$x, $y] \n";
 $x = gsl_matrix_get($evec, 1, 0);
 $y = gsl_matrix_get($evec, 1, 1);
 print "The second eigenvector is [$x, $y] \n";

=head1 AUTHORS

Jonathan Leto <jonathan@leto.net> and Thierry Moisan <thierry.moisan@gmail.com>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2008 Jonathan Leto and Thierry Moisan

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut
%}
