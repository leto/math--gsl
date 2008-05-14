%module Matrix
%{
#include "/usr/local/include/gsl/gsl_matrix.h"
#include "/usr/local/include/gsl/gsl_matrix_double.h"
#include "/usr/local/include/gsl/gsl_matrix_int.h"
#include "/usr/local/include/gsl/gsl_matrix_complex_double.h"
#include "/usr/local/include/gsl/gsl_matrix_complex_long_double.h"
#include "/usr/local/include/gsl/gsl_matrix_complex_float.h" 
%}

%include "/usr/local/include/gsl/gsl_matrix.h"
%include "/usr/local/include/gsl/gsl_matrix_double.h"
%include "/usr/local/include/gsl/gsl_matrix_int.h"
%include "/usr/local/include/gsl/gsl_matrix_complex_double.h"
%include "/usr/local/include/gsl/gsl_matrix_complex_long_double.h"
%include "/usr/local/include/gsl/gsl_matrix_complex_float.h" 

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
		gsl_matrix_complex_long_double_alloc gsl_matrix_complex_long_double_calloc gsl_matrix_complex_long_double_alloc_from_block  
		gsl_matrix_complex_long_double_alloc_from_matrix  gsl_vector_complex_long_double_alloc_row_from_matrix
		gsl_vector_complex_long_double_alloc_col_from_matrix gsl_matrix_complex_long_double_free
		gsl_matrix_complex_long_double_submatrix gsl_matrix_complex_long_double_row gsl_matrix_complex_long_double_column 
		gsl_matrix_complex_long_double_diagonal gsl_matrix_complex_long_double_subdiagonal gsl_matrix_complex_long_double_superdiagonal 
		gsl_matrix_complex_long_double_subrow gsl_matrix_complex_long_double_subcolumn gsl_matrix_complex_long_double_view_array 
		gsl_matrix_complex_long_double_view_array_with_tda gsl_matrix_complex_long_double_view_vector gsl_matrix_complex_long_double_view_vector_with_tda 
		gsl_matrix_complex_long_double_const_submatrix gsl_matrix_complex_long_double_const_row gsl_matrix_complex_long_double_const_column 
		gsl_matrix_complex_long_double_const_diagonal gsl_matrix_complex_long_double_const_subdiagonal gsl_matrix_complex_long_double_const_superdiagonal  
		gsl_matrix_complex_long_double_const_subrow gsl_matrix_complex_long_double_const_subcolumn gsl_matrix_complex_long_double_const_view_array 
		gsl_matrix_complex_long_double_const_view_array_with_tda gsl_matrix_complex_long_double_const_view_vector
		gsl_matrix_complex_long_double_const_view_vector_with_tda 
		gsl_matrix_complex_long_double_set gsl_matrix_complex_long_double_set_zero gsl_matrix_complex_long_double_set_identity 
		gsl_matrix_complex_long_double_set_all gsl_matrix_complex_long_double_fread gsl_matrix_complex_long_double_fwrite 
		gsl_matrix_complex_long_double_fscanf gsl_matrix_complex_long_double_fprintf gsl_matrix_complex_long_double_memcpy 
		gsl_matrix_complex_long_double_swap gsl_matrix_complex_long_double_swap_rows gsl_matrix_complex_long_double_swap_columns 
		gsl_matrix_complex_long_double_swap_rowcol gsl_matrix_complex_long_double_transpose gsl_matrix_complex_long_double_transpose_memcpy 
		gsl_matrix_complex_long_double_isnull gsl_matrix_complex_long_double_ispos gsl_matrix_complex_long_double_isneg 
		gsl_matrix_complex_long_double_add gsl_matrix_complex_long_double_sub gsl_matrix_complex_long_double_mul_elements 
		gsl_matrix_complex_long_double_div_elements gsl_matrix_complex_long_double_scale gsl_matrix_complex_long_double_add_constant 
		gsl_matrix_complex_long_double_add_diagonal 
       		gsl_matrix_complex_float_alloc 
		gsl_matrix_complex_float_calloc 
		gsl_matrix_complex_float_alloc_from_block 
		gsl_matrix_complex_float_alloc_from_matrix gsl_vector_complex_float 
		gsl_vector_complex_float_alloc_row_from_matrix 
		gsl_vector_complex_float_alloc_col_from_matrix 
		gsl_matrix_complex_float_free gsl_matrix_complex_float_submatrix gsl_matrix_complex_float_row 
		gsl_matrix_complex_float_column gsl_matrix_complex_float_diagonal  gsl_matrix_complex_float_subdiagonal 
		gsl_matrix_complex_float_superdiagonal gsl_matrix_complex_float_subrow gsl_matrix_complex_float_subcolumn 
		gsl_matrix_complex_float_view_array gsl_matrix_complex_float_view_array_with_tda gsl_matrix_complex_float_view_vector 
		gsl_matrix_complex_float_view_vector_with_tda gsl_matrix_complex_float_const_submatrix gsl_matrix_complex_float_const_row  
		gsl_matrix_complex_float_const_column gsl_matrix_complex_float_const_diagonal gsl_matrix_complex_float_const_subdiagonal   
		gsl_matrix_complex_float_const_superdiagonal gsl_matrix_complex_float_const_subrow gsl_matrix_complex_float_const_subcolumn 
		gsl_matrix_complex_float_const_view_array gsl_matrix_complex_float_const_view_array_with_tda gsl_matrix_complex_float_const_view_vector   
		gsl_matrix_complex_float_const_view_vector_with_tda gsl_complex_float gsl_matrix_complex_float_set gsl_complex_float gsl_complex_float
		gsl_matrix_complex_float_set_zero gsl_matrix_complex_float_set_identity gsl_matrix_complex_float_set_all 
		gsl_matrix_complex_float_fread gsl_matrix_complex_float_fwrite 
		gsl_matrix_complex_float_fscanf gsl_matrix_complex_float_fprintf  
		gsl_matrix_complex_float_memcpy(gsl_matrix_complex_float gsl_matrix_complex_float_swap  
		gsl_matrix_complex_float_swap_rows gsl_matrix_complex_float_swap_columns gsl_matrix_complex_float_swap_rowcol 
		gsl_matrix_complex_float_transpose gsl_matrix_complex_float_transpose_memcpy 
		gsl_matrix_complex_float_isnull gsl_matrix_complex_float_ispos 
		gsl_matrix_complex_float_isneg  gsl_matrix_complex_float_add 
		gsl_matrix_complex_float_sub gsl_matrix_complex_float_mul_elements gsl_matrix_complex_float_div_elements 
		gsl_matrix_complex_float_scale gsl_matrix_complex_float_add_constant gsl_matrix_complex_float_add_diagonal 
/;
%EXPORT_TAGS = ( all => [ @EXPORT_OK ] );

__END__

=head1 NAME

Math::GSL::Matrix
Mathematical functions concerning Matrices

=head1 SYPNOPSIS

use Math::GSL::Matrix qw / put_functions_here/;

=head1 DESCRIPTION
Here is a list of all the functions included in this module :



For more informations on the functions, we refer you to the GSL offcial documentation: http://www.gnu.org/software/gsl/manual/html_node/
Tip : search on google: site:http://www.gnu.org/software/gsl/manual/html_node/ name_of_the_function_you_want

=head1 EXAMPLES


=head1 AUTHOR

Jonathan Leto <jaleto@gmail.com> and Thierry Moisan <thierry.moisan@gmail.com>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2008 Jonathan Leto and Thierry Moisan

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut
%}
