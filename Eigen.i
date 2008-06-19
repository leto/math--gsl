%module Eigen
%{
    #include "/usr/local/include/gsl/gsl_eigen.h"
%}

%include "/usr/local/include/gsl/gsl_eigen.h"

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

=head1 SYPNOPSIS

use Math::GSL::Eigen qw/:all/;

=head1 DESCRIPTION

 Here is a list of all the functions included in this module :
 gsl_eigen_symm_alloc($n) - This function returns a workspace for computing eigenvalues of n-by-n real symmetric matrices.
 gsl_eigen_symm_free($w) - This function frees the memory associated with the workspace $w.  
 gsl_eigen_symm($A, $eval, $w) - This function computes the eigenvalues of the real symmetric matrix $A. Additional workspace of the appropriate size must be provided in $w. The diagonal and lower triangular part of $A are destroyed during the computation, but the strict upper triangular part is not referenced. The eigenvalues are stored in the vector $eval and are unordered. 
 gsl_eigen_symmv_alloc($n) - This function returns a workspace for computing eigenvalues and eigenvectors of n-by-n real symmetric matrices.
 gsl_eigen_symmv_free($w) - This function frees the memory associated with the workspace $w. 
 gsl_eigen_symmv($A, $eval, $evec, $w) - This function computes the eigenvalues and eigenvectors of the real symmetric matrix $A. Additional workspace of the appropriate size must be provided in $w. The diagonal and lower triangular part of $A are destroyed during the computation, but the strict upper triangular part is not referenced. The eigenvalues are stored in the vector $eval and are unordered. The corresponding eigenvectors are stored in the columns of the matrix $evec. 
 gsl_eigen_herm_alloc
 gsl_eigen_herm_free
 gsl_eigen_herm
 gsl_eigen_hermv_alloc 
 gsl_eigen_hermv_free
 gsl_eigen_hermv
 gsl_eigen_francis_alloc
 gsl_eigen_francis_free 
 gsl_eigen_francis_T
 gsl_eigen_francis
 gsl_eigen_francis_Z
 gsl_eigen_nonsymm_alloc 
 gsl_eigen_nonsymm_free
 gsl_eigen_nonsymm_params
 gsl_eigen_nonsymm 
 gsl_eigen_nonsymm_Z
 gsl_eigen_nonsymmv_alloc
 gsl_eigen_nonsymmv_free 
 gsl_eigen_nonsymmv
 gsl_eigen_nonsymmv_Z
 gsl_eigen_gensymm_alloc 
 gsl_eigen_gensymm_free
 gsl_eigen_gensymm
 gsl_eigen_gensymm_standardize 
 gsl_eigen_gensymmv_alloc
 gsl_eigen_gensymmv_free
 gsl_eigen_gensymmv 
 gsl_eigen_genherm_alloc
 gsl_eigen_genherm_free
 gsl_eigen_genherm 
 gsl_eigen_genherm_standardize
 gsl_eigen_genhermv_alloc
 gsl_eigen_genhermv_free 
 gsl_eigen_genhermv
 gsl_eigen_gen_alloc
 gsl_eigen_gen_free 
 gsl_eigen_gen_params
 gsl_eigen_gen
 gsl_eigen_gen_QZ 
 gsl_eigen_genv_alloc
 gsl_eigen_genv_free
 gsl_eigen_genv 
 gsl_eigen_genv_QZ
 gsl_eigen_symmv_sort($eval, $evec, $sort_type) - This function simultaneously sorts the eigenvalues stored in the vector $eval and the corresponding real eigenvectors stored in the columns of the matrix $evec according to the value of the parameter $sort_type which is one of the constant included in this module.
 gsl_eigen_hermv_sort($eval, $evec, $sort_type) - This function simultaneously sorts the eigenvalues stored in the vector $eval and the corresponding real eigenvectors stored in the columns of the matrix $evec according to the value of the parameter $sort_type which is one of the constant included in this module. 
 gsl_eigen_nonsymmv_sort($eval, $evec, $sort_type) - This function simultaneously sorts the eigenvalues stored in the vector $eval and the corresponding complex eigenvectors stored in the columns of the complex matrix $evec into ascending or descending order according to the value of the parameter $sort_type. Only $GSL_EIGEN_SORT_ABS_ASC and $GSL_EIGEN_SORT_ABS_DESC are supported due to the eigenvalues being complex. 
 gsl_eigen_gensymmv_sort($eval, $evec, $sort_type) - This function simultaneously sorts the eigenvalues stored in the vector $eval and the corresponding real eigenvectors stored in the columns of the matrix $evec according to the value of the parameter $sort_type which is one of the constant included in this module.
 gsl_eigen_genhermv_sort($eval, $evec, $sort_type) - This function simultaneously sorts the eigenvalues stored in the vector $eval and the corresponding real eigenvectors stored in the columns of the matrix $evec according to the value of the parameter $sort_type which is one of the constant included in this module.
 gsl_eigen_genv_sort($eval, $evec, $sort_type) - This function simultaneously sorts the eigenvalues stored in the vector $eval and the corresponding complex eigenvectors stored in the columns of the complex matrix $evec into ascending or descending order according to the value of the parameter $sort_type. Only $GSL_EIGEN_SORT_ABS_ASC and $GSL_EIGEN_SORT_ABS_DESC are supported due to the eigenvalues being complex. 
 gsl_schur_gen_eigvals
 gsl_schur_solve_equation 
 gsl_schur_solve_equation_z
 gsl_eigen_jacobi
 gsl_eigen_invert_jacobi
 
 This module also includes these constants : 
 $GSL_EIGEN_SORT_VAL_ASC - ascending order in numerical value
 $GSL_EIGEN_SORT_VAL_DESC - descending order in numerical value 
 $GSL_EIGEN_SORT_ABS_ASC - ascending order in magnitude 
 $GSL_EIGEN_SORT_ABS_DESC - descending order in magnitude 

For more informations on the functions, we refer you to the GSL offcial documentation: http://www.gnu.org/software/gsl/manual/html_node/
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
