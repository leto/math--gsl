%module "Math::GSL::Matrix"

%include "typemaps.i"
%include "gsl_typemaps.i"

%apply int *OUTPUT { size_t *imin, size_t *imax, size_t *jmin, size_t *jmax };
%apply double *OUTPUT { double * min_out, double * max_out };

FILE * fopen(char *, char *);
int fclose(FILE *);

%{
    #include "gsl/gsl_matrix.h"
    #include "gsl/gsl_complex.h"
    #include "gsl/gsl_vector_double.h"
    #include "gsl/gsl_matrix_double.h"
    #include "gsl/gsl_matrix_int.h"
    #include "gsl/gsl_matrix_complex_double.h"
    #include "gsl/gsl_matrix_char.h" 
%}

%include "gsl/gsl_matrix.h"
%include "gsl/gsl_complex.h"
%include "gsl/gsl_vector_double.h"
%include "gsl/gsl_matrix_double.h"
%include "gsl/gsl_matrix_int.h"
%include "gsl/gsl_matrix_complex_double.h"
%include "gsl/gsl_matrix_char.h"

 
%perlcode %{ 

no warnings 'redefine';
use Carp qw/croak/;
use Math::GSL qw/:all/;
use Math::GSL::Errno qw/:all/;

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
        gsl_matrix_get_row gsl_matrix_get_col gsl_matrix_set_row gsl_matrix_set_col
        gsl_matrix_complex_alloc gsl_matrix_complex_calloc gsl_matrix_complex_alloc_from_block 
        gsl_matrix_complex_alloc_from_matrix gsl_vector_complex_alloc_row_from_matrix gsl_vector_complex_alloc_col_from_matrix 
        gsl_matrix_complex_free gsl_matrix_complex_submatrix gsl_matrix_complex_row 
        gsl_matrix_complex_column gsl_matrix_complex_diagonal gsl_matrix_complex_subdiagonal 
        gsl_matrix_complex_superdiagonal gsl_matrix_complex_subrow gsl_matrix_complex_subcolumn 
        gsl_matrix_complex_view_array gsl_matrix_complex_view_array_with_tda gsl_matrix_complex_view_vector 
        gsl_matrix_complex_view_vector_with_tda gsl_matrix_complex_const_submatrix gsl_matrix_complex_const_row 
        gsl_matrix_complex_const_column gsl_matrix_complex_const_diagonal gsl_matrix_complex_const_subdiagonal 
        gsl_matrix_complex_const_superdiagonal gsl_matrix_complex_const_subrow gsl_matrix_complex_const_subcolumn 
        gsl_matrix_complex_const_view_array gsl_matrix_complex_const_view_array_with_tda gsl_matrix_complex_const_view_vector 
        gsl_matrix_complex_const_view_vector_with_tda gsl_matrix_complex_get gsl_matrix_complex_set
        gsl_matrix_complex_ptr gsl_matrix_complex_const_ptr gsl_matrix_complex_set_zero 
        gsl_matrix_complex_set_identity gsl_matrix_complex_set_all gsl_matrix_complex_fread 
        gsl_matrix_complex_fwrite gsl_matrix_complex_fscanf gsl_matrix_complex_fprintf 
        gsl_matrix_complex_memcpy gsl_matrix_complex_swap gsl_matrix_complex_swap_rows
        gsl_matrix_complex_swap_columns gsl_matrix_complex_swap_rowcol gsl_matrix_complex_transpose 
        gsl_matrix_complex_transpose_memcpy gsl_matrix_complex_isnull gsl_matrix_complex_ispos 
        gsl_matrix_complex_isneg gsl_matrix_complex_add gsl_matrix_complex_sub 
        gsl_matrix_complex_mul_elements gsl_matrix_complex_div_elements gsl_matrix_complex_scale 
        gsl_matrix_complex_add_constant gsl_matrix_complex_add_diagonal gsl_matrix_complex_get_row
        gsl_matrix_complex_get_col gsl_matrix_complex_set_row gsl_matrix_complex_set_col /;



%EXPORT_TAGS = ( all => [ @EXPORT_OK ], 
                 char => [ qw/
                    gsl_matrix_char_alloc
                    gsl_matrix_char_calloc
                    gsl_matrix_char_alloc_from_block
                    gsl_matrix_char_alloc_from_matrix
                    gsl_vector_char_alloc_row_from_matrix
                    gsl_vector_char_alloc_col_from_matrix
                    gsl_matrix_char_free
                    gsl_matrix_char_submatrix
                    gsl_matrix_char_row
                    gsl_matrix_char_column
                    gsl_matrix_char_diagonal
                    gsl_matrix_char_subdiagonal
                    gsl_matrix_char_superdiagonal
                    gsl_matrix_char_subrow
                    gsl_matrix_char_subcolumn
                    gsl_matrix_char_view_array
                    gsl_matrix_char_view_array_with_tda
                    gsl_matrix_char_view_vector
                    gsl_matrix_char_view_vector_with_tda
                    gsl_matrix_char_const_submatrix
                    gsl_matrix_char_const_row
                    gsl_matrix_char_const_column
                    gsl_matrix_char_const_diagonal
                    gsl_matrix_char_const_subdiagonal
                    gsl_matrix_char_const_superdiagonal
                    gsl_matrix_char_const_subrow
                    gsl_matrix_char_const_subcolumn
                    gsl_matrix_char_const_view_array
                    gsl_matrix_char_const_view_array_with_tda
                    gsl_matrix_char_const_view_vector
                    gsl_matrix_char_const_view_vector_with_tda
                    gsl_matrix_char_get
                    gsl_matrix_char_set
                    gsl_matrix_char_ptr
                    gsl_matrix_char_const_ptr
                    gsl_matrix_char_set_zero
                    gsl_matrix_char_set_identity
                    gsl_matrix_char_set_all
                    gsl_matrix_char_fread
                    gsl_matrix_char_fwrite
                    gsl_matrix_char_fscanf
                    gsl_matrix_char_fprintf
                    gsl_matrix_char_memcpy
                    gsl_matrix_char_swap
                    gsl_matrix_char_swap_rows
                    gsl_matrix_char_swap_columns
                    gsl_matrix_char_swap_rowcol
                    gsl_matrix_char_transpose
                    gsl_matrix_char_transpose_memcpy
                    gsl_matrix_char_max
                    gsl_matrix_char_min
                    gsl_matrix_char_minmax
                    gsl_matrix_char_max_index
                    gsl_matrix_char_min_index
                    gsl_matrix_char_minmax_index
                    gsl_matrix_char_isnull
                    gsl_matrix_char_ispos
                    gsl_matrix_char_isneg
                    gsl_matrix_char_isnonneg
                    gsl_matrix_char_add
                    gsl_matrix_char_sub
                    gsl_matrix_char_mul_elements
                    gsl_matrix_char_div_elements
                    gsl_matrix_char_scale
                    gsl_matrix_char_add_constant
                    gsl_matrix_char_add_diagonal
                     /],

                 double => [ qw/
                    gsl_matrix_alloc
                    gsl_matrix_calloc
                    gsl_matrix_alloc_from_block
                    gsl_matrix_alloc_from_matrix
                    gsl_vector_alloc_row_from_matrix
                    gsl_vector_alloc_col_from_matrix
                    gsl_matrix_free
                    gsl_matrix_submatrix
                    gsl_matrix_row
                    gsl_matrix_column
                    gsl_matrix_diagonal
                    gsl_matrix_subdiagonal
                    gsl_matrix_superdiagonal
                    gsl_matrix_subrow
                    gsl_matrix_subcolumn
                    gsl_matrix_view_array
                    gsl_matrix_view_array_with_tda
                    gsl_matrix_view_vector
                    gsl_matrix_view_vector_with_tda
                    gsl_matrix_const_submatrix
                    gsl_matrix_const_row
                    gsl_matrix_const_column
                    gsl_matrix_const_diagonal
                    gsl_matrix_const_subdiagonal
                    gsl_matrix_const_superdiagonal
                    gsl_matrix_const_subrow
                    gsl_matrix_const_subcolumn
                    gsl_matrix_const_view_array
                    gsl_matrix_const_view_array_with_tda
                    gsl_matrix_const_view_vector
                    gsl_matrix_const_view_vector_with_tda
                    gsl_matrix_get
                    gsl_matrix_set
                    gsl_matrix_ptr
                    gsl_matrix_const_ptr
                    gsl_matrix_set_zero
                    gsl_matrix_set_identity
                    gsl_matrix_set_all
                    gsl_matrix_fread
                    gsl_matrix_fwrite
                    gsl_matrix_fscanf
                    gsl_matrix_fprintf
                    gsl_matrix_memcpy
                    gsl_matrix_swap
                    gsl_matrix_swap_rows
                    gsl_matrix_swap_columns
                    gsl_matrix_swap_rowcol
                    gsl_matrix_transpose
                    gsl_matrix_transpose_memcpy
                    gsl_matrix_max
                    gsl_matrix_minmax
                    gsl_matrix_max_index
                    gsl_matrix_min_index
                    gsl_matrix_minmax_index
                    gsl_matrix_isnull
                    gsl_matrix_ispos
                    gsl_matrix_isneg
                    gsl_matrix_isnonneg
                    gsl_matrix_add
                    gsl_matrix_mul_elements
                    gsl_matrix_div_elements
                    gsl_matrix_scale
                    gsl_matrix_add_constant
                    gsl_matrix_add_diagonal
                    /],
int => [ qw/
                 gsl_matrix_int_alloc
                 gsl_matrix_int_alloc_from_matrix
                 gsl_matrix_int_free
                 gsl_matrix_int_column
                 gsl_matrix_int_superdiagonal
                 gsl_matrix_int_view_array_with_tda
                 gsl_matrix_int_const_submatrix
                 gsl_matrix_int_const_diagonal
                 gsl_matrix_int_const_subrow
                 gsl_matrix_int_const_view_array_with_tda
                 gsl_matrix_int_get
                 gsl_matrix_int_ptr
                 gsl_matrix_int_set_zero
                 gsl_matrix_int_fread
                 gsl_matrix_int_fscanf
                 gsl_matrix_int_memcpy
                 gsl_matrix_int_swap_rows
                 gsl_matrix_int_transpose
                 gsl_matrix_int_max
                 gsl_matrix_int_max_index
                 gsl_matrix_int_minmax_index
                 gsl_matrix_int_ispos
                 gsl_matrix_int_add
                 gsl_matrix_int_mul_elements
                 gsl_matrix_int_add_constant
                 /],
  complex => [ qw/
                 gsl_matrix_complex_alloc
                 gsl_matrix_complex_calloc
                 gsl_matrix_complex_alloc_from_block
                 gsl_matrix_complex_alloc_from_matrix
                 gsl_vector_complex_alloc_row_from_matrix
                 gsl_vector_complex_alloc_col_from_matrix
                 gsl_matrix_complex_free
                 gsl_matrix_complex_submatrix
                 gsl_matrix_complex_row
                 gsl_matrix_complex_column
                 gsl_matrix_complex_diagonal
                 gsl_matrix_complex_subdiagonal
                 gsl_matrix_complex_superdiagonal
                 gsl_matrix_complex_subrow
                 gsl_matrix_complex_subcolumn
                 gsl_matrix_complex_view_array
                 gsl_matrix_complex_view_array_with_tda
                 gsl_matrix_complex_view_vector
                 gsl_matrix_complex_view_vector_with_tda
                 gsl_matrix_complex_const_submatrix
                 gsl_matrix_complex_const_row
                 gsl_matrix_complex_const_column
                 gsl_matrix_complex_const_diagonal
                 gsl_matrix_complex_const_subdiagonal
                 gsl_matrix_complex_const_superdiagonal
                 gsl_matrix_complex_const_subrow
                 gsl_matrix_complex_const_subcolumn
                 gsl_matrix_complex_const_view_array
                 gsl_matrix_complex_const_view_array_with_tda
                 gsl_matrix_complex_const_view_vector
                 gsl_matrix_complex_const_view_vector_with_tda
                 gsl_matrix_complex_get
                 gsl_matrix_complex_set
                 gsl_matrix_complex_ptr
                 gsl_matrix_complex_const_ptr
                 gsl_matrix_complex_set_zero gsl_matrix_complex_set_identity
                 gsl_matrix_complex_set_all
                 gsl_matrix_complex_fread
                 gsl_matrix_complex_fwrite
                 gsl_matrix_complex_fscanf
                 gsl_matrix_complex_fprintf
                 gsl_matrix_complex_memcpygsl_matrix_complex_swap
                 gsl_matrix_complex_swap_rows
                 gsl_matrix_complex_swap_columns
                 gsl_matrix_complex_swap_rowcol
                 gsl_matrix_complex_transpose
                 gsl_matrix_complex_transpose_memcpy
                 gsl_matrix_complex_isnull
                 gsl_matrix_complex_ispos
                 gsl_matrix_complex_isneg
                 gsl_matrix_complex_add
                 gsl_matrix_complex_sub
                 gsl_matrix_complex_mul_elements
                 gsl_matrix_complex_div_elements
                 gsl_matrix_complex_scale
                 gsl_matrix_complex_add_constant
                 gsl_matrix_complex_add_diagonal
                 gsl_matrix_complex_get_row
                 gsl_matrix_complex_get_col
                 gsl_matrix_complex_set_row
                 gsl_matrix_complex_set_col
                 /]);

=head1 NAME

Math::GSL::Matrix - Mathematical functions concerning Matrices

=head1 SYNOPSIS

    use Math::GSL::Matrix qw/:all/;
    my $matrix1 = Math::GSL::Matrix->new(5,5);  # OO interface
    my $matrix2 = gsl_matrix_alloc(5,5);        # standard interface


=head1 Objected Oriented Interface to GSL Math::GSL::Matrix

=head2 Math::GSL::Matrix->new()

Creates a new Matrix of the given size.

    my $matrix = Math::GSL::Matrix->new(10,10);
=cut

sub new 
{
    my ($class, $rows, $cols) = @_;
    my $this = {}; 
    my $matrix;
    if ( defined $rows       && defined $cols && 
        $rows > 0            && $cols > 0     && 
        (int $rows == $rows) && (int $cols == $cols)){

        $matrix  = gsl_matrix_alloc($rows,$cols);
    } else {
        croak( __PACKAGE__.'::new($x,$y) - $x and $y must be positive integers');
    }
    gsl_matrix_set_zero($matrix);
    $this->{_matrix} = $matrix; 
    ($this->{_rows}, $this->{_cols}) = ($rows,$cols);
    bless $this, $class;
}
=head2 raw()

Get the underlying GSL matrix object created by SWIG, useful for using gsl_matrix_* functions which do not have an OO counterpart.

    my $matrix     = Math::GSL::Matrix->new(3,3);
    my $gsl_matrix = $matrix->raw;
    my $stuff      = gsl_matrix_get($gsl_matrix, 1, 2);

=cut
sub raw  { (shift)->{_matrix} }
=head2 rows()

Returns the number of rows in the matrix.

    my $rows = $matrix->rows;
=cut

sub rows { (shift)->{_rows}   }

=head2 cols()

Returns the number of columns in the matrix.

    my $cols = $matrix->cols;
=cut

sub cols { (shift)->{_cols}   }

=head2  as_list() 

Get the contents of a Math::GSL::Matrix object as a Perl list.

    my $matrix = Math::GSL::Matrix->new(3,3);
    ...
    my @matrix = $matrix->as_list;
=cut


sub as_list 
{
    my $self = shift;
    my $line;
    my @part;
    my @total;
    for($line=0; $line<$self->rows; $line++){
       @part = map { 
         gsl_matrix_get($self->raw, $line, $_) 
       } (0 .. $self->cols-1 );
       push(@total, @part);
    }
    return @total;
}

=head2 row()

Returns a row matrix of the row you enter.

    my $matrix = Math::GSL::Matrix->new(3,3);
    ...
    my $matrix_row = $matrix->row(0);

=cut

sub row
{
    my ($self, $row) = @_;
    croak (__PACKAGE__.'::$matrix->row($row) - invalid $row value') 
        unless (($row < $self->rows) and $row >= 0);  

    my $rowvec = Math::GSL::Vector->new($self->cols);
    my $rowmat = Math::GSL::Matrix->new(1,$self->cols);

    my $status = gsl_matrix_get_row($rowvec->raw, $self->raw, $row);
    croak (__PACKAGE__.'::gsl_matrix_get_row - ' . gsl_strerror($status) ) 
        unless ( $status == $GSL_SUCCESS );

    $status = gsl_matrix_set_row($rowmat->raw, 0, $rowvec->raw);

    croak (__PACKAGE__.'::gsl_matrix_set_row - ' . gsl_strerror($status) ) 
        unless ( $status == $GSL_SUCCESS );

    return $rowmat;
}

=head2 col()

Returns a col matrix of the column you enter.

    my $matrix = Math::GSL::Matrix->new(3,3);
    ...
    my $matrix_col = $matrix->col(0);

=cut

sub col 
{
    my ($self, $col) = @_;
    croak (__PACKAGE__."::\$matrix->col(\$col) - $col not a valid column") 
        unless ($col < $self->cols and $col >= 0);  

    my $colvec = Math::GSL::Vector->new($self->cols);
    my $colmat = Math::GSL::Matrix->new($self->rows, 1);

    my $status = gsl_matrix_get_col($colvec->raw, $self->raw, $col);
# return $colvec;
    $status    = gsl_matrix_set_col($colmat->raw, 0, $colvec->raw);
    return $colmat;
}

=head2 set_row()

Sets a the values of a row with the elements of an array.

    my $matrix = Math::GSL::Matrix->new(3,3);
    $matrix->set_row(0, [8, 6, 2]);

You can also set multiple rows at once with chained calls:
    my $matrix = Math::GSL::Matrix->new(3,3);
    $matrix->set_row(0, [8, 6, 2]);
           ->set_row(1, [2, 4, 1]);
    ...

=cut

sub set_row {
 my ($self, $row, $values) = @_;
 my $length = $#$values;
 die __PACKAGE__.'::new($x, $values) - $values must be a nonempty array reference' if $length == -1;
 die __PACKAGE__.'::set_row($x, $values) - $x must be a valid row number' if ($row < 0 || $row >= $self->rows);
 die __PACKAGE__.'::set_row($x, $values) - $values must contains the same number of elements as there is columns in the matrix' if($length != $self->cols-1);
 map { gsl_matrix_set($self->raw, $row, $_, $values->[$_]) } (0..$length);
 return $self;
}

=head2 set_col()

Sets a the values of a column with the elements of an array.

    my $matrix = Math::GSL::Matrix->new(3,3);
    $matrix->set_col(0, [8, 6, 2]);

You can also set multiple columns at once with chained calls:
    my $matrix = Math::GSL::Matrix->new(3,3);
    $matrix->set_col(0, [8, 6, 2]);
           ->set_col(1, [2, 4, 1]);
    ...

=cut

sub set_col {
 my ($self, $col, $values) = @_;
 my $length = $#$values;
 die __PACKAGE__.'::new($x, $values) - $values must be a nonempty array reference' if $length == -1;
 die __PACKAGE__.'::set_row($x, $values) - $x must be a valid column number' if ($col < 0 || $col >= $self->cols);
 die __PACKAGE__.'::set_row($x, $values) - $values must contains the same number of elements as there is rowss in the matrix' if($length != $self->rows-1);
 map { gsl_matrix_set($self->raw, $_, $col, $values->[$_]) } (0..$length);
 return $self;
}

=head1 DESCRIPTION

Here is a list of all the functions included in this module :

=over 1

=item C<gsl_matrix_alloc($i, $j)> - Return a gsl_matrix of $i rows and $j columns

=item C<gsl_matrix_calloc($i, $j)> - Return a gsl_matrix of $i rows and $j columns and initialize all of the elements of the matrix to zero

=item C<gsl_matrix_alloc_from_block> - 

=item C<gsl_matrix_free> - 

=item C<gsl_matrix_alloc_from_matrix > - 

=item C<gsl_vector_alloc_row_from_matrix> - 

=item C<gsl_vector_alloc_col_from_matrix > - 

=item C<gsl_matrix_submatrix($m, $k1, $k2, $n1, $n2)> - Return a matrix view of the matrix $m. The upper-left element of the submatrix is the element ($k1,$k2) of the original matrix. The submatrix has $n1 rows and $n2 columns.

=item C<gsl_matrix_row($m , $i)> - Return a vector view of the $i-th row of the matrix $m

=item C<gsl_matrix_column($m, $j)> - Return a vector view of the $j-th column of the matrix $m

=item C<gsl_matrix_diagonal($m)> - Return a vector view of the diagonal of the vector. The matrix doesn't have to be square.

=item C<gsl_matrix_subdiagonal($m, $k)> - Return a vector view of the $k-th subdiagonal of the matrix $m. The diagonal of the matrix corresponds to k=0.

=item C<gsl_matrix_superdiagonal($m, $k)> - Return a vector view of the $k-th superdiagonal of the matrix $m. The matrix doesn't have to be square.

=item C<gsl_matrix_subrow($m, $i, $offset, $n)> - Return a vector view of the $i-th row of the matrix $m beginning at offset elements and containing n elements.

=item C<gsl_matrix_subcolumn($m, $j, $offset, $n)> - Return a vector view of the $j-th column of the matrix $m beginning at offset elements and containing n elements.

=item C<gsl_matrix_view_array($base, $n1, $n2)> - This function returns a matrix view of the array reference $base. The matrix has $n1 rows and $n2 columns. The physical number of columns in memory is also given by $n2. Mathematically, the (i,j)-th element of the new matrix is given by, m'(i,j) = $base->[i*$n2 + j] where the index i runs from 0 to $n1-1 and the index j runs from 0 to $n2-1. The new matrix is only a view of the array reference $base. When the view goes out of scope the original array reference $base will continue to exist. The original memory can only be deallocated by freeing the original array. Of course, the original array should not be deallocated while the view is still in use. 

=item C<gsl_matrix_view_array_with_tda($base, $n1, $n2, $tda)> - This function returns a matrix view of the array reference $base with a physical number of columns $tda which may differ from the corresponding dimension of the matrix. The matrix has $n1 rows and $n2 columns, and the physical number of columns in memory is given by $tda. Mathematically, the (i,j)-th element of the new matrix is given by, m'(i,j) = $base->[i*$tda + j] where the index i runs from 0 to $n1-1 and the index j runs from 0 to $n2-1. The new matrix is only a view of the array reference $base. When the view goes out of scope the original array reference $base will continue to exist. The original memory can only be deallocated by freeing the original array. Of course, the original array should not be deallocated while the view is still in use.  

=item C<gsl_matrix_view_vector> - 

=item C<gsl_matrix_view_vector_with_tda> - 

=item C<gsl_matrix_const_submatrix> - 

=item C<gsl_matrix_get($m, $i, $j)> - Return the (i,j)-th element of the matrix $m

=item C<gsl_matrix_set($m, $i, $j, $x)> - Set the value of the (i,j)-th element of the matrix $m to $x

=item C<gsl_matrix_ptr> - 

=item C<gsl_matrix_const_ptr> - 

=item C<gsl_matrix_set_zero($m)> - Set all the elements of the matrix $m to zero

=item C<gsl_matrix_set_identity($m)> - Set the elements of the matrix $m to the corresponding elements of the identity matrix

=item C<gsl_matrix_set_all($m, $x)> - Set all the elements of the matrix $m to the value $x

=item C<gsl_matrix_fread($fh, $m)> - Read a file which has been written with gsl_matrix_fwrite from the stream $fh opened with the fopen function and stores the data inside the matrix $m

=item C<gsl_matrix_fwrite($fh, $m)> - Write the elements of the matrix $m in binary format to a stream $fh opened with the fopen function

=item C<gsl_matrix_fscanf($fh, $m)> - Read a file which has been written with gsl_matrix_fprintf from the stream $fh opened with the fopen function and stores the data inside the matrix $m

=item C<gsl_matrix_fprintf($fh, $m, $format)> - Write the elements of the matrix $m in the format $format (for example "%f" is the format for double) to a stream $fh opened with the fopen function

=item C<gsl_matrix_memcpy($dest, $src)> - Copy the elements of the matrix $src to the matrix $dest. The two matrices must have the same size.

=item C<gsl_matrix_swap($m1, $m2)> - Exchange the elements of the matrices $m1 and $m2 by copying. The two matrices must have the same size.

=item C<gsl_matrix_swap_rows($m, $i, $j)> - Exchange the $i-th and $j-th row of the matrix $m. The function returns 0 if the operation suceeded, 1 otherwise.

=item C<gsl_matrix_swap_columns($m, $i, $j)> - Exchange the $i-th and $j-th column of the matrix $m. The function returns 0 if the operation suceeded, 1 otherwise.

=item C<gsl_matrix_swap_rowcol($m, $i, $j)> - Exchange the $i-th row and the $j-th column of the matrix $m. The matrix must be square. The function returns 0 if the operation suceeded, 1 otherwise.

=item C<gsl_matrix_transpose($m)> - This function replaces the matrix m by its transpose by copying the elements of the matrix in-place. The matrix must be square for this operation to be possible.

=item C<gsl_matrix_transpose_memcpy($dest, $src)> - Make the matrix $dest the transpose of the matrix $src. This function works for all matrices provided that the dimensions of the matrix dest match the transposed dimensions of the matrix src. 

=item C<gsl_matrix_max($m)> - Return the maximum value in the matrix $m

=item C<gsl_matrix_min($m)> - Return the minimum value in the matrix $m

=item C<gsl_matrix_minmax($m)> - Return two values, the first is the minimum value of the Matrix $m and the second is the maximum of the same the same matrix.

=item C<gsl_matrix_max_index($m)> - Return two values, the first is the the i indice of the maximum value of the matrix $m and the second is the j indice of the same value.

=item C<gsl_matrix_min_index($m)> - Return two values, the first is the the i indice of the minimum value of the matrix $m and the second is the j indice of the same value.

=item C<gsl_matrix_minmax_index($m)> - Return four values, the first is the i indice of the minimum of the matrix $m, the second is the j indice of the same value, the third is the i indice of the maximum of the matrix $m and the fourth is the j indice of the same value

=item C<gsl_matrix_isnull($m)> - Return 1 if all the elements of the matrix $m are zero, 0 otherwise

=item C<gsl_matrix_ispos($m)> - Return 1 if all the elements of the matrix $m are strictly positve, 0 otherwise

=item C<gsl_matrix_isneg($m)> - Return 1 if all the elements of the matrix $m are strictly negative, 0 otherwise

=item C<gsl_matrix_isnonneg($m)> - Return 1 if all the elements of the matrix $m are non-negatuive, 0 otherwise

=item C<gsl_matrix_add($a, $b)> - Add the elements of matrix $b to the elements of matrix $a

=item C<gsl_matrix_sub($a, $b)> - Subtract the elements of matrix $b from the elements of matrix $a

=item C<gsl_matrix_mul_elements($a, $b)> - Multiplie the elements of matrix $a by the elements of matrix $b

=item C<gsl_matrix_div_elements($a, $b)> - Divide the elements of matrix $a by the elements of matrix $b

=item C<gsl_matrix_scale($a, $x)> - Multiplie the elements of matrix $a by the constant factor $x

=item C<gsl_matrix_add_constant($a, $x)> - Add the constant value $x to the elements of the matrix $a

=item C<gsl_matrix_add_diagonal($a, $x)> - Add the constant value $x to the elements of the diagonal of the matrix $a

=item C<gsl_matrix_get_row($v, $m, $i)> - Copy the elements of the $i-th row of the matrix $m into the vector $v. The lenght of the vector must be of the same as the lenght of the row. The function returns 0 if it succeded, 1 otherwise.

=item C<gsl_matrix_get_col($v, $m, $i)> - Copy the elements of the $j-th column of the matrix $m into the vector $v. The lenght of the vector must be of the same as the lenght of the column. The function returns 0 if it succeded, 1 otherwise.

=item C<gsl_matrix_set_row($m, $i, $v)> - Copy the elements of vector $v into the $i-th row of the matrix $m The lenght of the vector must be of the same as the lenght of the row. The function returns 0 if it succeded, 1 otherwise.

=item C<gsl_matrix_set_col($m, $j, $v)> - Copy the elements of vector $v into the $j-th row of the matrix $m The lenght of the vector must be of the same as the lenght of the column. The function returns 0 if it succeded, 1 otherwise.

=back

The following functions are specific to matrices containing complex numbers : 

=over 1

=item C<gsl_matrix_complex_alloc >

=item C<gsl_matrix_complex_calloc >

=item C<gsl_matrix_complex_alloc_from_block >

=item C<gsl_matrix_complex_alloc_from_matrix >

=item C<gsl_vector_complex_alloc_row_from_matrix >

=item C<gsl_vector_complex_alloc_col_from_matrix >

=item C<gsl_matrix_complex_free >

=item C<gsl_matrix_complex_submatrix >

=item C<gsl_matrix_complex_row >

=item C<gsl_matrix_complex_column >

=item C<gsl_matrix_complex_diagonal >

=item C<gsl_matrix_complex_subdiagonal >

=item C<gsl_matrix_complex_superdiagonal >

=item C<gsl_matrix_complex_subrow >

=item C<gsl_matrix_complex_subcolumn >

=item C<gsl_matrix_complex_view_array >

=item C<gsl_matrix_complex_view_array_with_tda >

=item C<gsl_matrix_complex_view_vector >

=item C<gsl_matrix_complex_view_vector_with_tda >

=item C<gsl_matrix_complex_const_submatrix >

=item C<gsl_matrix_complex_const_row >

=item C<gsl_matrix_complex_const_column >

=item C<gsl_matrix_complex_const_diagonal >

=item C<gsl_matrix_complex_const_subdiagonal >

=item C<gsl_matrix_complex_const_superdiagonal >

=item C<gsl_matrix_complex_const_subrow >

=item C<gsl_matrix_complex_const_subcolumn >

=item C<gsl_matrix_complex_const_view_array >

=item C<gsl_matrix_complex_const_view_array_with_tda >

=item C<gsl_matrix_complex_const_view_vector >

=item C<gsl_matrix_complex_const_view_vector_with_tda >

=item C<gsl_matrix_complex_get>

=item C<gsl_matrix_complex_set>

=item C<gsl_matrix_complex_ptr>

=item C<gsl_matrix_complex_const_ptr>

=item C<gsl_matrix_complex_set_zero >

=item C<gsl_matrix_complex_set_identity >

=item C<gsl_matrix_complex_set_all >

=item C<gsl_matrix_complex_fread >

=item C<gsl_matrix_complex_fwrite >

=item C<gsl_matrix_complex_fscanf >

=item C<gsl_matrix_complex_fprintf >

=item C<gsl_matrix_complex_memcpy>

=item C<gsl_matrix_complex_swap>

=item C<gsl_matrix_complex_swap_rows>

=item C<gsl_matrix_complex_swap_columns>

=item C<gsl_matrix_complex_swap_rowcol>

=item C<gsl_matrix_complex_transpose >

=item C<gsl_matrix_complex_transpose_memcpy >

=item C<gsl_matrix_complex_isnull >

=item C<gsl_matrix_complex_ispos >

=item C<gsl_matrix_complex_isneg >

=item C<gsl_matrix_complex_add >

=item C<gsl_matrix_complex_sub >

=item C<gsl_matrix_complex_mul_elements >

=item C<gsl_matrix_complex_div_elements >

=item C<gsl_matrix_complex_scale >

=item C<gsl_matrix_complex_add_constant >

=item C<gsl_matrix_complex_add_diagonal >

=item C<gsl_matrix_complex_get_row>

=item C<gsl_matrix_complex_get_col>

=item C<gsl_matrix_complex_set_row>

=item C<gsl_matrix_complex_set_col>

=back


The following functions are the same as the previous enonced ones except that they work with other data types than double.

=over 1

=item gsl_matrix_const_row gsl_matrix_const_column gsl_matrix_const_diagonal

=item gsl_matrix_const_subdiagonal gsl_matrix_const_superdiagonal

=item gsl_matrix_const_subrow gsl_matrix_const_subcolumn

=item gsl_matrix_const_view_array gsl_matrix_const_view_array_with_tda

=item gsl_matrix_const_view_vector gsl_matrix_const_view_vector_with_tda gsl_matrix_char_alloc gsl_matrix_char_calloc  gsl_matrix_char_alloc_from_block

=item gsl_matrix_char_alloc_from_matrix gsl_vector_char_alloc_row_from_matrix gsl_vector_char_alloc_col_from_matrix 

=item gsl_matrix_char_free gsl_matrix_char_submatrix gsl_matrix_char_row  gsl_matrix_char_column 

=item gsl_matrix_char_diagonal gsl_matrix_char_subdiagonal gsl_matrix_char_superdiagonal 

=item gsl_matrix_char_subrow gsl_matrix_char_subcolumn gsl_matrix_char_view_array 

=item gsl_matrix_char_view_array_with_tda gsl_matrix_char_view_vector gsl_matrix_char_view_vector_with_tda 

=item gsl_matrix_char_const_submatrix gsl_matrix_char_const_row gsl_matrix_char_const_column 

=item gsl_matrix_char_const_diagonal gsl_matrix_char_const_subdiagonal gsl_matrix_char_const_superdiagonal 

=item gsl_matrix_char_const_subrow gsl_matrix_char_const_subcolumn gsl_matrix_char_const_view_array 

=item gsl_matrix_char_const_view_array_with_tda gsl_matrix_char_const_view_vector gsl_matrix_char_const_view_vector_with_tda 

=item gsl_matrix_char_get gsl_matrix_char_set gsl_matrix_char_ptr gsl_matrix_char_const_ptr 

=item gsl_matrix_char_set_zero gsl_matrix_char_set_identity 

=item gsl_matrix_char_set_all  gsl_matrix_char_fread 

=item gsl_matrix_char_fwrite gsl_matrix_char_fscanf gsl_matrix_char_fprintf 

=item gsl_matrix_char_memcpy gsl_matrix_char_swap 

=item gsl_matrix_char_swap_rows gsl_matrix_char_swap_columns

=item gsl_matrix_char_swap_rowcol gsl_matrix_char_transpose gsl_matrix_char_transpose_memcpy 

=item gsl_matrix_char_max gsl_matrix_char_min 

=item gsl_matrix_char_minmax  gsl_matrix_char_max_index 

=item gsl_matrix_char_min_index gsl_matrix_char_minmax_index  

=item gsl_matrix_char_isnull gsl_matrix_char_ispos gsl_matrix_char_isneg 

=item gsl_matrix_char_isnonneg  gsl_matrix_char_add 

=item gsl_matrix_char_sub gsl_matrix_char_mul_elements gsl_matrix_char_div_elements 

=item gsl_matrix_char_scale gsl_matrix_char_add_constant gsl_matrix_char_add_diagonal 

=item gsl_matrix_int_alloc gsl_matrix_int_calloc gsl_matrix_int_alloc_from_block 

=item gsl_matrix_int_alloc_from_matrix gsl_vector_int_alloc_row_from_matrix gsl_vector_int_alloc_col_from_matrix 

=item gsl_matrix_int_free gsl_matrix_int_submatrix gsl_matrix_int_row 

=item gsl_matrix_int_column gsl_matrix_int_diagonal gsl_matrix_int_subdiagonal gsl_matrix_int_superdiagonal gsl_matrix_int_subrow gsl_matrix_int_subcolumn gsl_matrix_int_view_array gsl_matrix_int_view_array_with_tda gsl_matrix_int_view_vector gsl_matrix_int_view_vector_with_tda 

=item gsl_matrix_int_const_submatrix gsl_matrix_int_const_row gsl_matrix_int_const_column 


=item gsl_matrix_int_const_diagonal gsl_matrix_int_const_subdiagonal gsl_matrix_int_const_superdiagonal 

=item gsl_matrix_int_const_subrow gsl_matrix_int_const_subcolumn gsl_matrix_int_const_view_array 

=item gsl_matrix_int_const_view_array_with_tda gsl_matrix_int_const_view_vector gsl_matrix_int_const_view_vector_with_tda 

=item gsl_matrix_int_get gsl_matrix_int_set 

=item gsl_matrix_int_ptr gsl_matrix_int_const_ptr 

=item gsl_matrix_int_set_zero gsl_matrix_int_set_identity gsl_matrix_int_set_all 

=item gsl_matrix_int_fread gsl_matrix_int_fwrite 

=item gsl_matrix_int_fscanf gsl_matrix_int_fprintf 

=item gsl_matrix_int_memcpy gsl_matrix_int_swap 

=item gsl_matrix_int_swap_rows gsl_matrix_int_swap_columns gsl_matrix_int_swap_rowcol

=item gsl_matrix_int_transpose gsl_matrix_int_transpose_memcpy  

=item gsl_matrix_int_max gsl_matrix_int_min gsl_matrix_int_minmax 

=item gsl_matrix_int_max_index gsl_matrix_int_min_index 

=item gsl_matrix_int_minmax_index  gsl_matrix_int_isnull 

=item gsl_matrix_int_ispos gsl_matrix_int_isneg gsl_matrix_int_isnonneg 

=item gsl_matrix_int_add gsl_matrix_int_sub 

=item gsl_matrix_int_mul_elements gsl_matrix_int_div_elements gsl_matrix_int_scale 

=item gsl_matrix_int_add_constant gsl_matrix_int_add_diagonal

=back

You have to add the functions you want to use inside the qw /put_funtion_here /. 
You can also write use Math::GSL::Matrix qw/:all/ to use all avaible functions of the module. 
Other tags are also avaible, here is a complete list of all tags for this module :

=over 1

=item C<all>

=item C<int>

=item C<double> 

=item C<char> 

=item C<complex>

=back

For more informations on the functions, we refer you to the GSL offcial documentation: http://www.gnu.org/software/gsl/manual/html_node/
Tip : search on google: site:http://www.gnu.org/software/gsl/manual/html_node/name_of_the_function_you_want

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
        print "m($i, $j) = " . gsl_matrix_get ($m, $i, $j) . "\n";
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

Jonathan Leto <jonathan@leto.net> and Thierry Moisan <thierry.moisan@gmail.com>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2008 Jonathan Leto and Thierry Moisan

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

%}
