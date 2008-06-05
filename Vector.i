%module Vector
%include "typemaps.i"

%typemap(in) double * {
    printf("double typemap\n");
}
%{
    #include "/usr/include/stdio.h"
    #include "/usr/local/include/gsl/gsl_vector.h"
    #include "/usr/local/include/gsl/gsl_vector_char.h"
    #include "/usr/local/include/gsl/gsl_vector_complex.h"
    #include "/usr/local/include/gsl/gsl_vector_complex_double.h"
    #include "/usr/local/include/gsl/gsl_vector_double.h"
    #include "/usr/local/include/gsl/gsl_vector_float.h"
    #include "/usr/local/include/gsl/gsl_vector_int.h"
%}
%include "/usr/local/include/gsl/gsl_vector.h"
%include "/usr/local/include/gsl/gsl_vector_char.h"
%include "/usr/local/include/gsl/gsl_vector_complex.h"
%include "/usr/local/include/gsl/gsl_vector_complex_double.h"
%include "/usr/local/include/gsl/gsl_vector_double.h"
%include "/usr/local/include/gsl/gsl_vector_int.h"

/*
%apply double *INPUT { double *min_out, double *max_out };
%{
    extern void gsl_vector_minmax (const gsl_vector *, double *, double *);
%}
extern void gsl_vector_minmax (const gsl_vector * v, double *INPUT, double *INPUT);
*/

FILE *fopen(char *, char *);
int fclose(FILE *);

%perlcode %{


@EXPORT_OK  = qw/fopen fclose
                 gsl_vector_alloc gsl_vector_calloc gsl_vector_alloc_from_b gsl_vector_alloc_from_v
                 gsl_vector_free gsl_vector_view_array gsl_vector_view_array_w
                 gsl_vector_const_view_a gsl_vector_subvector gsl_vector_subvector_wi gsl_vector_subvector_with_stride
                 gsl_vector_const_subvec gsl_vector_const_subvec gsl_vector_get gsl_vector_set
                 gsl_vector_ptr gsl_vector_const_ptr gsl_vector_set_zero gsl_vector_set_all
                 gsl_vector_set_basis gsl_vector_fread gsl_vector_fwrite gsl_vector_fscanf
                 gsl_vector_fprintf gsl_vector_memcpy gsl_vector_reverse gsl_vector_swap 
                 gsl_vector_swap_elements gsl_vector_max gsl_vector_min gsl_vector_minmax 
                 gsl_vector_max_index gsl_vector_min_index gsl_vector_minmax_index
                 gsl_vector_add gsl_vector_sub gsl_vector_mul gsl_vector_div
                 gsl_vector_scale gsl_vector_add_constant gsl_vector_isnull
                 gsl_vector_ispos gsl_vector_isneg gsl_vector_isnonneg 
                 /;
%EXPORT_TAGS = ( all => [ @EXPORT_OK ] );

sub new {
    my ($class, $values) = @_;
    my $length  = $#$values;
    my $vector;
    die __PACKAGE__.'::new($x) - $x must be an int or nonempty array reference'
        if( !(defined $values) || ($length == -1));

    if ( ref $values eq 'ARRAY' ){
        $vector  = gsl_vector_alloc($length+1);
        map { gsl_vector_set($vector, $_, $values->[$_] ) }  (0 .. $length);
    } elsif ( int $values == $values && $values > 0) {
        $vector  = gsl_vector_alloc($length);
    } else {
        die __PACKAGE__.'::new($x) - $x must be an int or array reference';
    }
    my $self = {}; 
    $self->{_vector} = $vector; 
    bless $self, $class;
}

sub get {
    my ($self, $indices) = @_;
    return  map {  gsl_vector_get($self->{_vector}, $_ ) } @$indices ;
}

sub set {
    my ($self, $indices, $values) = @_;
    die (__PACKAGE__.'::set($indices, $values) - $indices and $values must be array references of the same length') 
        unless ( ref $indices eq 'ARRAY' && ref $values eq 'ARRAY' &&  $#$indices == $#$values );
    eval { 
        map {  gsl_vector_set($self->{_vector}, $indices->[$_], $values->[$_] ) } (0..$#$indices);
    }; 
    return;
}

__END__

=head1 NAME

Math::GSL::Vector
Functions concerning Vectors.

=head1 SYPNOPSIS

use Math::GSL::Vector qw/:all/;

=head1 DESCRIPTION

Here is a list of all the functions included in this module :

    gsl_vector_alloc($x) - create a vector of size $x

    gsl_vector_calloc($x) - create a vector of size $x and initializes all the elements of the vector to zero

    gsl_vector_alloc_from_b

    gsl_vector_alloc_from_v

    gsl_vector_free($v) - free a previously allocated vector $v

    gsl_vector_view_array

    gsl_vector_view_array_w

    gsl_vector_const_view_a

    gsl_vector_subvector - return a vector_view type which contains a subvector of $v, with a size of $size, starting from the $offset position

    gsl_vector_subvector_wi 

    gsl_vector_subvector_with_stride($v, $offset, $stride, $size) - return a vector_view type which contains a subvector of $v, with a size of $size, starting from the $offset position and with a $stride step between each element of $v

    gsl_vector_const_subvec

    gsl_vector_get($v, $i) - return the $i-th element of a vector $v

    gsl_vector_set($v, $i, $x) - return the vector $v with his $i-th element set to $x

    gsl_vector_ptr

    gsl_vector_const_ptr

    gsl_vector_set_zero($v) - set all the elements of $v to 0

    gsl_vector_set_all($v, $x) - set all the elements of $v to $x

    gsl_vector_set_basis($v, $i) - set all the elements of $v to 0 except for the $i-th element which is set to 1 and return 0 if the operation succeded, 1 otherwise.

    gsl_vector_fread($file, $v)

    gsl_vector_fwrite

    gsl_vector_fscanf

    gsl_vector_fprintf

    gsl_vector_memcpy

    gsl_vector_reverse($v) - reverse the order of the elements of the vector $v and return 0 if the opertaion succeded, 1 otherwise

    gsl_vector_swap($v, $v2) - swap the values of the vectors $v and $v2 and return 0 if the opertaion succeded, 1 otherwise 

    gsl_vector_swap_elements($v, $i, $j) - permute the elements at position $i and $j in the vector $v and return 0 if the operation succeded, 1 otherwise.

    gsl_vector_max($v) - return the maximum value in the vector $v

    gsl_vector_min($v) - return the minimum value in the vector $v

    gsl_vector_minmax

    gsl_vector_max_index($v) - return the position of the maximum value in the vector $v

    gsl_vector_min_index - return the position of the minimum value in the vector $v

    gsl_vector_minmax_index

    gsl_vector_add($v, $v2) - add the elements of $v2 to the elements of $v, the two vectors must have the same lenght and return 0 if the operation succeded, 1 otherwise.

    gsl_vector_sub($v, $v2) - substract the elements of $v2 from the elements of $v, the two vectors must have the same lenght and return 0 if the operation succeded, 1 otherwise.

    gsl_vector_mul($v, $v2) - multiply the elements of $v by the elements of $v2, the two vectors must have the same lenght and return 0 if the operation succeded, 1 otherwise.

    gsl_vector_div($v, $v2) - divides the elements of $v by the elements of $v2, the two vectors must have the same lenght and return 0 if the operation succeded, 1 otherwise.

    gsl_vector_scale($v, $x) - multiplty the elements of the vector $v by a constant $x and return 0 if the operation succeded, 1 otherwise.

    gsl_vector_add_constant($v, $x) - add a constant $x to the elements of the vector $v and return 0 if the operation succeded, 1 otherwise.

    gsl_vector_isnull($v) - verify if all the elements of the vector $v are null, return 0 if it's the case, 1 otherwise.

    gsl_vector_ispos($v) - verify if all the elements of the vector $v are positive, return 0 if it's the case, 1 otherwise.

    gsl_vector_isneg($v) - verify if all the elements of the vector $v are negative, return 0 if it's the case, 1 otherwise.

    gsl_vector_isnonneg($v) - verify if all the elements the vector $v are not negative, return 0 if it's the case, 1 otherwise.


You have to add the functions you want to use inside the qw /put_funtion_here / with spaces between each function. You can also write use Math::GSL::Complex qw/:all/ to use all avaible functions of the module.


Precision on the vector_view type : every modification you'll make on a vector_view will also modify the original vector. 
For example, the following code will zero the even elements of the vector v of length n, while leaving the odd elements untouched :

$v_even= gsl_vector_subvector_with_stride ($v, 0, 2, $size/2);
gsl_vector_set_zero ($v_even->{vector});


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
