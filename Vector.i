%module "Math::GSL::Vector"

%include "typemaps.i"

%apply int *OUTPUT { size_t *imin, size_t *imax };

%apply double *OUTPUT { double * min_out, double * max_out };

%typemap(in) double *v {
    AV *tempav;
    I32 len;
    int i;
    SV **tv;
    if (!SvROK($input))
        croak("Math::GSL : $input is not a reference!");
    if (SvTYPE(SvRV($input)) != SVt_PVAV)
        croak("Math::GSL : $input is not an array ref!");
        
    tempav = (AV*)SvRV($input);
    len = av_len(tempav);
    $1 = (double *) malloc((len+1)*sizeof(double));
    for (i = 0; i <= len; i++) {
        tv = av_fetch(tempav, i, 0);
        $1[i] = (double) SvNV(*tv);
    }
}

FILE * fopen(char *, char *);
int fclose(FILE *);

%{
    #include "gsl/gsl_nan.h"
    #include "gsl/gsl_vector.h"
    #include "gsl/gsl_vector_char.h"
    #include "gsl/gsl_vector_complex.h"
    #include "gsl/gsl_vector_complex_double.h"
    #include "gsl/gsl_vector_double.h"
    #include "gsl/gsl_vector_float.h"
    #include "gsl/gsl_vector_int.h"
%}

%include "gsl/gsl_nan.h"
%include "gsl/gsl_vector.h"
%include "gsl/gsl_vector_char.h"
%include "gsl/gsl_vector_complex.h"
%include "gsl/gsl_vector_complex_double.h"
%include "gsl/gsl_vector_double.h"
%include "gsl/gsl_vector_int.h"



%perlcode %{
use Scalar::Util 'blessed';
use Carp qw/croak/;
use overload 
    '*'      => \&_multiplication,
    fallback => 1,
;

@EXPORT_OK  = qw/fopen fclose
                 gsl_vector_alloc gsl_vector_calloc gsl_vector_alloc_from_block gsl_vector_alloc_from_vector
                 gsl_vector_free gsl_vector_view_array gsl_vector_view_array_with_stride
                 gsl_vector_const_view_array_with_stride gsl_vector_subvector gsl_vector_subvector_wi gsl_vector_subvector_with_stride
                 gsl_vector_const_subvec gsl_vector_const_subvec gsl_vector_get gsl_vector_set
                 gsl_vector_ptr gsl_vector_const_ptr gsl_vector_set_zero gsl_vector_set_all
                 gsl_vector_set_basis gsl_vector_fread gsl_vector_fwrite gsl_vector_fscanf
                 gsl_vector_fprintf gsl_vector_memcpy gsl_vector_reverse gsl_vector_swap 
                 gsl_vector_swap_elements gsl_vector_max gsl_vector_min gsl_vector_minmax 
                 gsl_vector_max_index gsl_vector_min_index gsl_vector_minmax_index
                 gsl_vector_add gsl_vector_sub gsl_vector_mul gsl_vector_div
                 gsl_vector_scale gsl_vector_add_constant gsl_vector_isnull
                 gsl_vector_ispos gsl_vector_isneg gsl_vector_isnonneg
                 gsl_vector_float_alloc gsl_vector_float_calloc gsl_vector_float_alloc_from_block 
                 gsl_vector_float_alloc_from_vector gsl_vector_float_free gsl_vector_float_view_array
                 gsl_vector_float_view_array_with_stride gsl_vector_float_const_view_array gsl_vector_float_const_view_array_with_stride
                 gsl_vector_float_subvector gsl_vector_float_subvector_with_stride gsl_vector_float_const_subvector
                 gsl_vector_float_const_subvector_with_stride gsl_vector_float_get gsl_vector_float_set gsl_vector_float_ptr
                 gsl_vector_float_const_ptr gsl_vector_float_set_zero gsl_vector_float_set_all gsl_vector_float_set_basis
                 gsl_vector_float_fread gsl_vector_float_fwrite gsl_vector_float_fscanf gsl_vector_float_fprintf
                 gsl_vector_float_memcpy gsl_vector_float_reverse gsl_vector_float_swap gsl_vector_float_swap_elements
                 gsl_vector_float_max gsl_vector_float_min gsl_vector_float_minmax gsl_vector_float_max_index gsl_vector_float_min_index
                 gsl_vector_float_minmax_index gsl_vector_float_add gsl_vector_float_sub gsl_vector_float_mul gsl_vector_float_div gsl_vector_float_scale
                 gsl_vector_float_add_constant gsl_vector_float_isnull gsl_vector_float_ispos gsl_vector_float_isneg gsl_vector_float_isnonneg
                 gsl_vector_complex_alloc gsl_vector_complex_calloc gsl_vector_complex_alloc_from_block gsl_vector_complex_alloc_from_vector
                 gsl_vector_complex_free gsl_vector_complex_view_array gsl_vector_complex_view_array_with_stride gsl_vector_complex_const_view_array
                 gsl_vector_complex_const_view_array_with_stride gsl_vector_complex_subvector gsl_vector_complex_subvector_with_stride
                 gsl_vector_complex_const_subvector gsl_vector_complex_const_subvector_with_stride gsl_vector_complex_real gsl_vector_complex_imag
                 gsl_vector_complex_const_real gsl_vector_complex_const_imag gsl_vector_complex_get gsl_vector_complex_set
                 gsl_vector_complex_ptr gsl_vector_complex_const_ptr gsl_vector_complex_set_zero gsl_vector_complex_set_all
                 gsl_vector_complex_set_basis gsl_vector_complex_fread gsl_vector_complex_fwrite gsl_vector_complex_fscanf
                 gsl_vector_complex_fprintf gsl_vector_complex_memcpy gsl_vector_complex_reverse gsl_vector_complex_swap
                 gsl_vector_complex_swap_elements gsl_vector_complex_isnull gsl_vector_complex_ispos gsl_vector_complex_isneg                                      
/;
%EXPORT_TAGS = ( all => [ @EXPORT_OK ] );

=head1 NAME

Math::GSL::Vector - Functions concerning vectors

=head1 SYNOPSIS

    use Math::GSL::Vector qw/:all/;
    my $vec1 = Math::GSL::Vector->new([1, 7, 94, 15 ]);
    my $vec2 = $vec1 * 5; 
    my $vec3 = Math::GSL::Vector>new(10);   # 10 element zero vector 

    # set the element at index 1 to 9
    # and the element at index 3 to 8
    $vec3->set([ 1, 3 ], [ 9, 8 ]);   

    my @vec = $vec2->as_list;               # return elements as Perl list

    my $dot_product = $vec1 * $vec2;
    my $length      = $vec2->length;
    my $first       = $vec1->get(0);


=cut

=head1 Objected Oriented Interface to GSL Math::GSL::Vector

=head2 Math::GSL::Vector->new()

Creates a new Vector of the given size.

    my $vector = Math::GSL::Matrix->new(3);

You can also create and set directly the values of the vector like this :

   my $vector = Math::GSL::Vector->new([2,4,1]);

=cut
sub new {
    my ($class, $values) = @_;
    my $length  = $#$values;
    my $this = {}; 
    my $vector;
    if ( ref $values eq 'ARRAY' ){
        die __PACKAGE__.'::new($x) - $x must be a nonempty array reference' if $length == -1;
        $vector  = gsl_vector_alloc($length+1);
        map { gsl_vector_set($vector, $_, $values->[$_] ) }  (0 .. $length);
        $this->{_length} = $length+1;
    } elsif ( (int($values) == $values) && ($values > 0)) {
        $vector  = gsl_vector_alloc($values);
        gsl_vector_set_zero($vector);
        $this->{_length} = $values;
    } else {
        die __PACKAGE__.'::new($x) - $x must be an int or array reference';
    }
    $this->{_vector} = $vector; 
    bless $this, $class;
}
=head2 raw()

Get the underlying GSL vector object created by SWIG, useful for using gsl_vector_* functions which do not have an OO counterpart.

    my $vector    = Math::GSL::vector->new(3);
    my $gsl_vector = $vector->raw;
    my $stuff      = gsl_vector_get($gsl_vector, 1);

=cut

sub raw { (shift)->{_vector} }

=head2 min()

Returns the minimum value contained in the vector.

   my $vector = Math::GSL::Vector->new([2,4,1]);
   my $minimum = $vector->min;

=cut 

sub min {
    my $self=shift;
    return gsl_vector_min($self->raw);
}

=head2 max()

Returns the minimum value contained in the vector.

   my $vector = Math::GSL::Vector->new([2,4,1]);
   my $maximum = $vector->max;

=cut 

sub max {
    my $self=shift;
    return gsl_vector_max($self->raw);
}

=head2 length()

Returns the number of elements contained in the vector.

   my $vector = Math::GSL::Vector->new([2,4,1]);
   my $length = $vector->length;

=cut 

sub length { my $self=shift; $self->{_length} }

=head2  as_list() 

Gets the content of a Math::GSL::Vector object as a Perl list.

    my $vector = Math::GSL::vector->new(3);
    ...
    my @values = $vector->as_list;
=cut

sub as_list {
    my $self=shift;
    $self->get( [ 0 .. $self->length - 1  ] );
}

=head2  get() 

Gets the value of an of a Math::GSL::Vector object.

    my $vector = Math::GSL::vector->new(3);
    ...
    my @values = $vector->get(2);

You can also enter an array of indices to receive their corresponding values:

    my $vector = Math::GSL::vector->new(3);
    ...
    my @values = $vector->get([0,2]);

=cut

sub get {
    my ($self, $indices) = @_;
    return  map {  gsl_vector_get($self->{_vector}, $_ ) } @$indices ;
}

=head2  set() 

Sets values of an of a Math::GSL::Vector object.

    my $vector = Math::GSL::vector->new(3);
    $vector->set([1,2], [8,23]);

This sets the second and third value to 8 and 23.

=cut

sub set {
    my ($self, $indices, $values) = @_;
    die (__PACKAGE__.'::set($indices, $values) - $indices and $values must be array references of the same length') 
        unless ( ref $indices eq 'ARRAY' && ref $values eq 'ARRAY' &&  $#$indices == $#$values );
    eval { 
        map {  gsl_vector_set($self->{_vector}, $indices->[$_], $values->[$_] ) } (0..$#$indices);
    }; 
    return;
}

sub _multiplication {
    my ($left,$right) = @_;
    if ( blessed $right && $right->isa('Math::GSL::Vector') ) {
        return $left->dot_product($right);
    } else {
        gsl_vector_scale($left->raw, $right);
    }
    return $left;
}

sub dot_product {
    my ($left,$right) = @_;
    my $sum=0;
    if ( blessed $right && $right->isa('Math::GSL::Vector') && 
         blessed $left  && $left->isa('Math::GSL::Vector') && 
         $left->length == $right->length ) {
         my @l = $left->as_list;
         my @r = $right->as_list;
         map { $sum += $l[$_] * $r[$_] } (0..$#l);
        return $sum;
    } else {
        croak "dot_product() must be called with two vectors";
    }
}

=head1 DESCRIPTION

Here is a list of all the functions included in this module :

=over 1

=item C<gsl_vector_alloc($x)> - create a vector of size $x

=item C<gsl_vector_calloc($x)> - create a vector of size $x and initializes all the elements of the vector to zero

=item C<gsl_vector_alloc_from_block> 

=item C<gsl_vector_alloc_from_vector> 

=item C<gsl_vector_free($v)> - free a previously allocated vector $v

=item C<gsl_vector_view_array> 

=item C<gsl_vector_view_array_with_stride> 

=item C<gsl_vector_const_view_array_with_stride> 

=item C<gsl_vector_subvector($v, $offset, $n)> - return a vector_view type which contains a subvector of $v, with a size of $size, starting from the $offset position

=item C<gsl_vector_subvector_with_stride($v, $offset, $stride, $size)> - return a vector_view type which contains a subvector of $v, with a size of $size, starting from the $offset position and with a $stride step between each element of $v

=item C<gsl_vector_const_subvector> 

=item C<gsl_vector_get($v, $i)> - return the $i-th element of a vector $v

=item C<gsl_vector_set($v, $i, $x)> - return the vector $v with his $i-th element set to $x

=item C<gsl_vector_ptr> 

=item C<gsl_vector_const_ptr> 

=item C<gsl_vector_set_zero($v)> - set all the elements of $v to 0

=item C<gsl_vector_set_all($v, $x)> - set all the elements of $v to $x

=item C<gsl_vector_set_basis($v, $i)> - set all the elements of $v to 0 except for the $i-th element which is set to 1 and return 0 if the operation succeded, 1 otherwise.

=item C<gsl_vector_fread($file, $v)> - This function reads into the vector $v from the open stream $file opened with fopen in binary format. The vector $v must be preallocated with the correct length since the function uses the size of $v to determine how many bytes to read. The return value is 0 for success and 1 if there was a problem reading from the file.

=item C<gsl_vector_fwrite($file, $v)> - This function writes the elements of the vector $v to the stream $file opened with fopen in binary format. The return value is 0 for success and 1 if there was a problem writing to the file. Since the data is written in the native binary format it may not be portable between different architectures. 

=item C<gsl_vector_fscanf($file, $v)> This function reads formatted data from the stream $file opened with fopen into the vector $v. The vector $v must be preallocated with the correct length since the function uses the size of $v to determine how many numbers to read. The function returns 0 for success and 1 if there was a problem reading from the file. 

=item C<gsl_vector_fprintf($file, $v, $format)> -This function writes the elements of the vector $v line-by-line to the stream $file opened with fopen using the format specifier format, which should be one of the "%g", "%e" or "%f" formats for floating point numbers and "%d" for integers. The function returns 0 for success and 1 if there was a problem writing to the file.  

=item C<gsl_vector_memcpy($dest, $src)> - This function copies the elements of the vector $src into the vector $dest and return 0 if the opertaion succeded, 1 otherwise. The two vectors must have the same length.  

=item C<gsl_vector_reverse($v)> - reverse the order of the elements of the vector $v and return 0 if the opertaion succeded, 1 otherwise

=item C<gsl_vector_swap($v, $v2)> - swap the values of the vectors $v and $v2 and return 0 if the opertaion succeded, 1 otherwise 

=item C<gsl_vector_swap_elements($v, $i, $j)> - permute the elements at position $i and $j in the vector $v and return 0 if the operation succeded, 1 otherwise.

=item C<gsl_vector_max($v)> - return the maximum value in the vector $v

=item C<gsl_vector_min($v)> - return the minimum value in the vector $v

=item C<gsl_vector_minmax($v)> - return two values, the first is the minimum value in the vector $v and the second is the maximum value.

=item C<gsl_vector_max_index($v)> - return the position of the maximum value in the vector $v

=item C<gsl_vector_min_index($v)> - return the position of the minimum value in the vector $v

=item C<gsl_vector_minmax_index> -  return two values, the first is the position of the minimum value in the vector $v and the second is the position of the maximum value.

=item C<gsl_vector_add($v, $v2)> - add the elements of $v2 to the elements of $v, the two vectors must have the same lenght and return 0 if the operation succeded, 1 otherwise.

=item C<gsl_vector_sub($v, $v2)> - substract the elements of $v2 from the elements of $v, the two vectors must have the same lenght and return 0 if the operation succeded, 1 otherwise.

=item C<gsl_vector_mul($v, $v2)> - multiply the elements of $v by the elements of $v2, the two vectors must have the same lenght and return 0 if the operation succeded, 1 otherwise.

=item C<gsl_vector_div($v, $v2)> - divides the elements of $v by the elements of $v2, the two vectors must have the same lenght and return 0 if the operation succeded, 1 otherwise.

=item C<gsl_vector_scale($v, $x)> - multiplty the elements of the vector $v by a constant $x and return 0 if the operation succeded, 1 otherwise.

=item C<gsl_vector_add_constant($v, $x)> - add a constant $x to the elements of the vector $v and return 0 if the operation succeded, 1 otherwise.

=item C<gsl_vector_isnull($v)> - verify if all the elements of the vector $v are null, return 0 if it's the case, 1 otherwise.

=item C<gsl_vector_ispos($v)> - verify if all the elements of the vector $v are positive, return 0 if it's the case, 1 otherwise.

=item C<gsl_vector_isneg($v)> - verify if all the elements of the vector $v are negative, return 0 if it's the case, 1 otherwise.

=item C<gsl_vector_isnonneg($v)> - verify if all the elements the vector $v are not negative, return 0 if it's the case, 1 otherwise.

=back

You have to add the functions you want to use inside the qw /put_funtion_here / with spaces between each function. You can also write use Math::GSL::Complex qw/:all/ to use all avaible functions of the module.


Precision on the vector_view type : every modification you'll make on a vector_view will also modify the original vector. 
For example, the following code will zero the even elements of the vector $v of length $size, while leaving the odd elements untouched :

=over 1

=item C<$v_even= gsl_vector_subvector_with_stride ($v, 0, 2, $size/2);>

=item C<gsl_vector_set_zero ($v_even-E<gt>{vector});>

=back

For more informations on the functions, we refer you to the GSL offcial documentation: L<http://www.gnu.org/software/gsl/manual/html_node/>
Tip : search on google: site:http://www.gnu.org/software/gsl/manual/html_node/ name_of_the_function_you_want

=head1 EXAMPLES

 use Math::GSL::Vector qw/:all/;
 print "We'll create this vector : [0,1,4,9,16] \n";
 my $vector = Math::GSL::Vector->new([0,1,4,9,16]);
 my ($min, $max) = gsl_vector_minmax_index($vector->raw);
 print "We then check the index value of the maximum and minimum values of the vector. \n";
 print "The index of the maximum should be 4 and we received $max \n";
 print "The index of the minimum should be 0 and we received $min \n";
 print "We'll then swap the first and the third elements of the vector \n";
 gsl_vector_swap_elements($vector->raw, 0, 3);
 my @got = $vector->as_list;
 print "The vector should now be like this : [9,1,4,0,16] \n";
 print "and we received : [";
 for (my $element=0; $element<4; $element++) {
 print "$got[$element],"; }
 print "$got[4]] \n"; 

=head1 AUTHOR

Jonathan Leto <jonathan@leto.net> and Thierry Moisan <thierry.moisan@gmail.com>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2008 Jonathan Leto and Thierry Moisan

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut
%}
