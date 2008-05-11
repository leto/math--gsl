%module Matrix
%{
#include "/usr/local/include/gsl/gsl_matrix.h"
#include "/usr/local/include/gsl/gsl_matrix_double.h"
#include "/usr/local/include/gsl/gsl_matrix_int.h"
#include "/usr/local/include/gsl/gsl_matrix_complex_double.h"
%}

%include "/usr/local/include/gsl/gsl_matrix.h"
%include "/usr/local/include/gsl/gsl_matrix_double.h"
%include "/usr/local/include/gsl/gsl_matrix_int.h"
%include "/usr/local/include/gsl/gsl_matrix_complex_double.h"

%perlcode %{ 

@EXPORT_OK = qw/
                gsl_matrix_alloc gsl_matrix_calloc gsl_matrix_alloc_from_block
                gsl_matrix_alloc_from_matrix gsl_vector_alloc_row_from_matrix
                gsl_vector_alloc_col_from_matrix gsl_matrix_free gsl_matrix_submatrix
                gsl_matrix_row gsl_matrix_column gsl_matrix_diagonal
                gsl_matrix_subdiagonal gsl_matrix_superdiagonal gsl_matrix_subrow
                gsl_matrix_subcolumn gsl_matrix_view_array
                gsl_matrix_view_array_with_tda gsl_matrix_view_vector
                gsl_matrix_view_vector_with_tda gsl_matrix_const_submatrix
                gsl_matrix_const_row gsl_matrix_const_column gsl_matrix_const_diagonal
                gsl_matrix_const_subdiagonal gsl_matrix_const_superdiagonal
                gsl_matrix_const_subrow gsl_matrix_const_subcolumn
                gsl_matrix_const_view_array gsl_matrix_const_view_array_with_tda
                gsl_matrix_const_view_vector gsl_matrix_const_view_vector_with_tda
                gsl_matrix_get gsl_matrix_set gsl_matrix_ptr gsl_matrix_const_ptr
                gsl_matrix_set_zero gsl_matrix_set_identity gsl_matrix_set_all
                gsl_matrix_fread gsl_matrix_fwrite gsl_matrix_fscanf gsl_matrix_fprintf
                gsl_matrix_memcpy gsl_matrix_swap gsl_matrix_swap_rows
                gsl_matrix_swap_columns gsl_matrix_swap_rowcol gsl_matrix_transpose
                gsl_matrix_transpose_memcpy gsl_matrix_max gsl_matrix_min
                gsl_matrix_minmax gsl_matrix_max_index gsl_matrix_min_index
                gsl_matrix_minmax_index gsl_matrix_isnull gsl_matrix_ispos
                gsl_matrix_isneg gsl_matrix_isnonneg gsl_matrix_add gsl_matrix_sub
                gsl_matrix_mul_elements gsl_matrix_div_elements gsl_matrix_scale
                gsl_matrix_add_constant gsl_matrix_add_diagonal gsl_matrix_get_row
                gsl_matrix_get_col gsl_matrix_set_row gsl_matrix_set_col 
        /;
%EXPORT_TAGS = ( all => [ @EXPORT_OK ] );

%}
