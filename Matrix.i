%module Matrix
%{
#include "/usr/local/include/gsl/gsl_matrix.h"
#include "/usr/local/include/gsl/gsl_matrix_double.h"
#include "/usr/local/include/gsl/gsl_matrix_int.h"
#include "/usr/local/include/gsl/gsl_matrix_complex_double.h"
#include "/usr/local/include/gsl/gsl_matrix_char.h" 
%}

%include "/usr/local/include/gsl/gsl_matrix.h"
%include "/usr/local/include/gsl/gsl_matrix_double.h"
%include "/usr/local/include/gsl/gsl_matrix_int.h"
%include "/usr/local/include/gsl/gsl_matrix_complex_double.h"
%include "/usr/local/include/gsl/gsl_matrix_char.h"

FILE *fopen(char *, char *);
int fclose(FILE *);
 
%perlcode %{ 

@EXPORT_OK = qw/fopen fclose
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
                gsl_matrix_add_constant gsl_matrix_add_diagonal
		gsl_matrix_char_alloc gsl_matrix_char_calloc  gsl_matrix_char_alloc_from_block
		gsl_matrix_char_alloc_from_matrix gsl_vector_char_alloc_row_from_matrix gsl_vector_char_alloc_col_from_matrix 
		gsl_matrix_char_free gsl_matrix_char_submatrix 
		gsl_matrix_char_row  gsl_matrix_char_column 
		gsl_matrix_char_diagonal gsl_matrix_char_subdiagonal gsl_matrix_char_superdiagonal 
		gsl_matrix_char_subrow gsl_matrix_char_subcolumn gsl_matrix_char_view_array 
		gsl_matrix_char_view_array_with_tda gsl_matrix_char_view_vector gsl_matrix_char_view_vector_with_tda 
		gsl_matrix_char_const_submatrix gsl_matrix_char_const_row gsl_matrix_char_const_column 
		gsl_matrix_char_const_diagonal gsl_matrix_char_const_subdiagonal gsl_matrix_char_const_superdiagonal 
		gsl_matrix_char_const_subrow gsl_matrix_char_const_subcolumn gsl_matrix_char_const_view_array 
		gsl_matrix_char_const_view_array_with_tda gsl_matrix_char_const_view_vector gsl_matrix_char_const_view_vector_with_tda 
		gsl_matrix_char_get gsl_matrix_char_set gsl_matrix_char_ptr gsl_matrix_char_const_ptr 
		gsl_matrix_char_set_zero gsl_matrix_char_set_identity 
		gsl_matrix_char_set_all  gsl_matrix_char_fread 
		gsl_matrix_char_fwrite gsl_matrix_char_fscanf gsl_matrix_char_fprintf 
		gsl_matrix_char_memcpy gsl_matrix_char_swap 
		gsl_matrix_char_swap_rows gsl_matrix_char_swap_columns
		gsl_matrix_char_swap_rowcol gsl_matrix_char_transpose gsl_matrix_char_transpose_memcpy 
		gsl_matrix_char_max gsl_matrix_char_min 
		gsl_matrix_char_minmax  gsl_matrix_char_max_index 
		gsl_matrix_char_min_index gsl_matrix_char_minmax_index  
		gsl_matrix_char_isnull gsl_matrix_char_ispos gsl_matrix_char_isneg 
		gsl_matrix_char_isnonneg  gsl_matrix_char_add 
		gsl_matrix_char_sub gsl_matrix_char_mul_elements gsl_matrix_char_div_elements 
		gsl_matrix_char_scale gsl_matrix_char_add_constant gsl_matrix_char_add_diagonal 
		gsl_matrix_int_alloc gsl_matrix_int_calloc gsl_matrix_int_alloc_from_block 
		gsl_matrix_int_alloc_from_matrix gsl_vector_int_alloc_row_from_matrix gsl_vector_int_alloc_col_from_matrix 
		gsl_matrix_int_free gsl_matrix_int_submatrix gsl_matrix_int_row 
		gsl_matrix_int_column gsl_matrix_int_diagonal gsl_matrix_int_subdiagonal 
		gsl_matrix_int_superdiagonal gsl_matrix_int_subrow gsl_matrix_int_subcolumn gsl_matrix_int_view_array 
		gsl_matrix_int_view_array_with_tda gsl_matrix_int_view_vector gsl_matrix_int_view_vector_with_tda 
		gsl_matrix_int_const_submatrix gsl_matrix_int_const_row gsl_matrix_int_const_column 
		gsl_matrix_int_const_diagonal gsl_matrix_int_const_subdiagonal gsl_matrix_int_const_superdiagonal 
		gsl_matrix_int_const_subrow gsl_matrix_int_const_subcolumn gsl_matrix_int_const_view_array 
		gsl_matrix_int_const_view_array_with_tda gsl_matrix_int_const_view_vector gsl_matrix_int_const_view_vector_with_tda 
		gsl_matrix_int_get gsl_matrix_int_set 
		gsl_matrix_int_ptr gsl_matrix_int_const_ptr 
		gsl_matrix_int_set_zero gsl_matrix_int_set_identity gsl_matrix_int_set_all 
		gsl_matrix_int_fread gsl_matrix_int_fwrite 
		gsl_matrix_int_fscanf gsl_matrix_int_fprintf 
		gsl_matrix_int_memcpy gsl_matrix_int_swap 
		gsl_matrix_int_swap_rows gsl_matrix_int_swap_columns gsl_matrix_int_swap_rowcol
		gsl_matrix_int_transpose gsl_matrix_int_transpose_memcpy  
		gsl_matrix_int_max gsl_matrix_int_min gsl_matrix_int_minmax 
		gsl_matrix_int_max_index gsl_matrix_int_min_index 
		gsl_matrix_int_minmax_index  gsl_matrix_int_isnull 
		gsl_matrix_int_ispos gsl_matrix_int_isneg gsl_matrix_int_isnonneg 
		gsl_matrix_int_add gsl_matrix_int_sub 
		gsl_matrix_int_mul_elements gsl_matrix_int_div_elements gsl_matrix_int_scale 
		gsl_matrix_int_add_constant gsl_matrix_int_add_diagonal 
/;
%EXPORT_TAGS = ( all => [ @EXPORT_OK ], char => [gsl_matrix_char_alloc, gsl_matrix_char_calloc, gsl_matrix_char_alloc_from_block, gsl_matrix_char_alloc_from_matrix, gsl_vector_char_alloc_row_from_matrix, gsl_vector_char_alloc_col_from_matrix, gsl_matrix_char_free, gsl_matrix_char_submatrix, gsl_matrix_char_row,  gsl_matrix_char_column, gsl_matrix_char_diagonal, gsl_matrix_char_subdiagonal, gsl_matrix_char_superdiagonal, gsl_matrix_char_subrow, gsl_matrix_char_subcolumn, gsl_matrix_char_view_array, gsl_matrix_char_view_array_with_tda, gsl_matrix_char_view_vector, gsl_matrix_char_view_vector_with_tda, gsl_matrix_char_const_submatrix, gsl_matrix_char_const_row, gsl_matrix_char_const_column, gsl_matrix_char_const_diagonal, gsl_matrix_char_const_subdiagonal, gsl_matrix_char_const_superdiagonal, gsl_matrix_char_const_subrow, gsl_matrix_char_const_subcolumn, gsl_matrix_char_const_view_array, gsl_matrix_char_const_view_array_with_tda, gsl_matrix_char_const_view_vector, gsl_matrix_char_const_view_vector_with_tda, gsl_matrix_char_get, gsl_matrix_char_set, gsl_matrix_char_ptr, gsl_matrix_char_const_ptr, gsl_matrix_char_set_zero, gsl_matrix_char_set_identity, gsl_matrix_char_set_all,  gsl_matrix_char_fread, gsl_matrix_char_fwrite, gsl_matrix_char_fscanf, gsl_matrix_char_fprintf, gsl_matrix_char_memcpy, gsl_matrix_char_swap, gsl_matrix_char_swap_rows, gsl_matrix_char_swap_columns, gsl_matrix_char_swap_rowcol, gsl_matrix_char_transpose, gsl_matrix_char_transpose_memcpy, gsl_matrix_char_max, gsl_matrix_char_min, gsl_matrix_char_minmax,  gsl_matrix_char_max_index, gsl_matrix_char_min_index, gsl_matrix_char_minmax_index, gsl_matrix_char_isnull, gsl_matrix_char_ispos, gsl_matrix_char_isneg, gsl_matrix_char_isnonneg, gsl_matrix_char_add, gsl_matrix_char_sub, gsl_matrix_char_mul_elements, gsl_matrix_char_div_elements, gsl_matrix_char_scale, gsl_matrix_char_add_constant, gsl_matrix_char_add_diagonal], double => [ gsl_matrix_alloc, gsl_matrix_calloc, gsl_matrix_alloc_from_block, gsl_matrix_alloc_from_matrix, gsl_vector_alloc_row_from_matrix, gsl_vector_alloc_col_from_matrix, gsl_matrix_free, gsl_matrix_submatrix, gsl_matrix_row, gsl_matrix_column, gsl_matrix_diagonal, gsl_matrix_subdiagonal, gsl_matrix_superdiagonal, gsl_matrix_subrow, gsl_matrix_subcolumn, gsl_matrix_view_array, gsl_matrix_view_array_with_tda, gsl_matrix_view_vector, gsl_matrix_view_vector_with_tda, gsl_matrix_const_submatrix, gsl_matrix_const_row, gsl_matrix_const_column, gsl_matrix_const_diagonal, gsl_matrix_const_subdiagonal, gsl_matrix_const_superdiagonal, gsl_matrix_const_subrow, gsl_matrix_const_subcolumn, gsl_matrix_const_view_array, gsl_matrix_const_view_array_with_tda, gsl_matrix_const_view_vector, gsl_matrix_const_view_vector_with_tda, gsl_matrix_get, gsl_matrix_set, gsl_matrix_ptr, gsl_matrix_const_ptr, gsl_matrix_set_zero, gsl_matrix_set_identity, gsl_matrix_set_all, gsl_matrix_fread, gsl_matrix_fwrite, gsl_matrix_fscanf, gsl_matrix_fprintf, gsl_matrix_memcpy, gsl_matrix_swap, gsl_matrix_swap_rows, gsl_matrix_swap_columns, gsl_matrix_swap_rowcol, gsl_matrix_transpose, gsl_matrix_transpose_memcpy, gsl_matrix_max, gsl_matrix_minmax, gsl_matrix_max_index, gsl_matrix_min_index, gsl_matrix_minmax_index, gsl_matrix_isnull, gsl_matrix_ispos, gsl_matrix_isneg, gsl_matrix_isnonneg, gsl_matrix_add, gsl_matrix_mul_elements, gsl_matrix_div_elements, gsl_matrix_scale, gsl_matrix_add_constant, gsl_matrix_add_diagonal], int => [gsl_matrix_int_alloc, gsl_matrix_int_alloc_from_matrix, gsl_matrix_int_free, gsl_matrix_int_column, gsl_matrix_int_superdiagonal, gsl_matrix_int_view_array_with_tda, gsl_matrix_int_const_submatrix, gsl_matrix_int_const_diagonal, gsl_matrix_int_const_subrow, gsl_matrix_int_const_view_array_with_tda, gsl_matrix_int_get, gsl_matrix_int_ptr, gsl_matrix_int_set_zero, gsl_matrix_int_fread, gsl_matrix_int_fscanf, gsl_matrix_int_memcpy, gsl_matrix_int_swap_rows, gsl_matrix_int_transpose, gsl_matrix_int_max, gsl_matrix_int_max_index, gsl_matrix_int_minmax_index, gsl_matrix_int_ispos, gsl_matrix_int_add, gsl_matrix_int_mul_elements, gsl_matrix_int_add_constant]);

__END__

=head1 NAME

Math::GSL::Matrix
Mathematical functions concerning Matrices

=head1 SYPNOPSIS

use Math::GSL::Matrix qw / put_functions_here/;

=head1 DESCRIPTION
Here is a list of all the functions included in this module :

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
gsl_matrix_add_constant gsl_matrix_add_diagonal
gsl_matrix_char_alloc gsl_matrix_char_calloc  gsl_matrix_char_alloc_from_block
gsl_matrix_char_alloc_from_matrix gsl_vector_char_alloc_row_from_matrix gsl_vector_char_alloc_col_from_matrix 
gsl_matrix_char_free gsl_matrix_char_submatrix 
gsl_matrix_char_row  gsl_matrix_char_column 
gsl_matrix_char_diagonal gsl_matrix_char_subdiagonal gsl_matrix_char_superdiagonal 
gsl_matrix_char_subrow gsl_matrix_char_subcolumn gsl_matrix_char_view_array 
gsl_matrix_char_view_array_with_tda gsl_matrix_char_view_vector gsl_matrix_char_view_vector_with_tda 
gsl_matrix_char_const_submatrix gsl_matrix_char_const_row gsl_matrix_char_const_column 
gsl_matrix_char_const_diagonal gsl_matrix_char_const_subdiagonal gsl_matrix_char_const_superdiagonal 
gsl_matrix_char_const_subrow gsl_matrix_char_const_subcolumn gsl_matrix_char_const_view_array 
gsl_matrix_char_const_view_array_with_tda gsl_matrix_char_const_view_vector gsl_matrix_char_const_view_vector_with_tda 
gsl_matrix_char_get gsl_matrix_char_set gsl_matrix_char_ptr gsl_matrix_char_const_ptr 
gsl_matrix_char_set_zero gsl_matrix_char_set_identity 
gsl_matrix_char_set_all  gsl_matrix_char_fread 
gsl_matrix_char_fwrite gsl_matrix_char_fscanf gsl_matrix_char_fprintf 
gsl_matrix_char_memcpy gsl_matrix_char_swap 
gsl_matrix_char_swap_rows gsl_matrix_char_swap_columns
gsl_matrix_char_swap_rowcol gsl_matrix_char_transpose gsl_matrix_char_transpose_memcpy 
gsl_matrix_char_max gsl_matrix_char_min 
gsl_matrix_char_minmax  gsl_matrix_char_max_index 
gsl_matrix_char_min_index gsl_matrix_char_minmax_index  
gsl_matrix_char_isnull gsl_matrix_char_ispos gsl_matrix_char_isneg 
gsl_matrix_char_isnonneg  gsl_matrix_char_add 
gsl_matrix_char_sub gsl_matrix_char_mul_elements gsl_matrix_char_div_elements 
gsl_matrix_char_scale gsl_matrix_char_add_constant gsl_matrix_char_add_diagonal 
gsl_matrix_int_alloc gsl_matrix_int_calloc gsl_matrix_int_alloc_from_block 
gsl_matrix_int_alloc_from_matrix gsl_vector_int_alloc_row_from_matrix gsl_vector_int_alloc_col_from_matrix 
gsl_matrix_int_free gsl_matrix_int_submatrix gsl_matrix_int_row 
gsl_matrix_int_column gsl_matrix_int_diagonal gsl_matrix_int_subdiagonal 
gsl_matrix_int_superdiagonal gsl_matrix_int_subrow gsl_matrix_int_subcolumn gsl_matrix_int_view_array 
gsl_matrix_int_view_array_with_tda gsl_matrix_int_view_vector gsl_matrix_int_view_vector_with_tda 
gsl_matrix_int_const_submatrix gsl_matrix_int_const_row gsl_matrix_int_const_column 
gsl_matrix_int_const_diagonal gsl_matrix_int_const_subdiagonal gsl_matrix_int_const_superdiagonal 
gsl_matrix_int_const_subrow gsl_matrix_int_const_subcolumn gsl_matrix_int_const_view_array 
gsl_matrix_int_const_view_array_with_tda gsl_matrix_int_const_view_vector gsl_matrix_int_const_view_vector_with_tda 
gsl_matrix_int_get gsl_matrix_int_set 
gsl_matrix_int_ptr gsl_matrix_int_const_ptr 
gsl_matrix_int_set_zero gsl_matrix_int_set_identity gsl_matrix_int_set_all 
gsl_matrix_int_fread gsl_matrix_int_fwrite 
gsl_matrix_int_fscanf gsl_matrix_int_fprintf 
gsl_matrix_int_memcpy gsl_matrix_int_swap 
gsl_matrix_int_swap_rows gsl_matrix_int_swap_columns gsl_matrix_int_swap_rowcol
gsl_matrix_int_transpose gsl_matrix_int_transpose_memcpy  
gsl_matrix_int_max gsl_matrix_int_min gsl_matrix_int_minmax 
gsl_matrix_int_max_index gsl_matrix_int_min_index 
gsl_matrix_int_minmax_index  gsl_matrix_int_isnull 
gsl_matrix_int_ispos gsl_matrix_int_isneg gsl_matrix_int_isnonneg 
gsl_matrix_int_add gsl_matrix_int_sub 
gsl_matrix_int_mul_elements gsl_matrix_int_div_elements gsl_matrix_int_scale 
gsl_matrix_int_add_constant gsl_matrix_int_add_diagonal

You have to add the functions you want to use inside the qw /put_funtion_here /. You can also write use Math::GSL::PowInt qw/:name_of_tag/ to use all avaible functions of the module. Other tags are also avaible, here is a complete list of all tags for this module :

all
int
double
char

For more informations on the functions, we refer you to the GSL offcial documentation: http://www.gnu.org/software/gsl/manual/html_node/
Tip : search on google: site:http://www.gnu.org/software/gsl/manual/html_node/ name_of_the_function_you_want

=head1 EXAMPLES

Most of the examples from this section are perl versions of the examples there : http://www.gnu.org/software/gsl/manual/html_node/Example-programs-for-matrices.html


The program below shows how to allocate, initialize and read from a matrix using the functions gsl_matrix_alloc, gsl_matrix_set and gsl_matrix_get. 

use Math::GSL::Matrix qw/:all/;
$m = gsl_matrix_alloc (10,3);
for($i = 0; $i< 10; $i++){
	for($j = 0; $j<3; $j++){
	gsl_matrix_set($m, $i, $j, 0.23 + 100*$i + $j); 
	}
}
for($i = 0; $i< 100; $i++){ # OUT OF RANGE ERROR
	for($j=0; $j<3; $j++){
	print "m($i, $j) = " . gsl_matrix_get ($m, $i, $j) . "\n";;
	}
}
gsl_matrix_free ($m);


use Math::GSL::Matrix qw/:all/;
$m = gsl_matrix_alloc (100, 100);
$a = gsl_matrix_alloc (100, 100);

for($i = 0; $i < 100; $i++){
	for($j = 0; $j < 100; $j++){
	gsl_matrix_set ($m, $i, $j, 0.23 + $i + $j);
	}
}

The next program shows how to write a matrix to a file. 

$out = fopen("test.dat", "wb");
gsl_matrix_fwrite ($out, $m);
fclose ($out);

$in = fopen("test.dat", "rb");
gsl_matrix_fread ($in, $a);
fclose($in);

$k=0;
for($i = 0; $i < 100; $i++){
	for($j = 0; $j < 100; $j++){
	$mij = gsl_matrix_get ($m, $i, $j);
	$aij = gsl_matrix_get ($a, $i, $j);
	if ($mij != $aij){ $k++ };
	}
}

gsl_matrix_free($m);
gsl_matrix_free($a);

print "differences = $k (should be zero)\n";

=head1 AUTHOR

Jonathan Leto <jaleto@gmail.com> and Thierry Moisan <thierry.moisan@gmail.com>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2008 Jonathan Leto and Thierry Moisan

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut
%}
