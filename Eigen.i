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
%}
