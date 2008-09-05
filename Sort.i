%module "Math::GSL::Sort"
/* Danger Will Robinson! */

%include "typemaps.i"
%include "gsl_typemaps.i"

%typemap(argout) (double * data, const size_t stride, const size_t n) {
    int i=0;
    AV* tempav = newAV();

    while( i < $3 ) {
        av_push(tempav, newSVnv((double) $1[i]));
        i++;
    }

    $result = sv_2mortal( newRV_noinc( (SV*) tempav) );
    //Perl_sv_dump($result);
    argvi++;
}
%typemap(argout) (double * dest, const size_t k, const gsl_vector * v) {
    int i=0;
    AV* tempav = newAV();

    while( i < $2 ) {
        av_push(tempav, newSVnv((double) $1[i]));
        i++;
    }

    $result = sv_2mortal( newRV_noinc( (SV*) tempav) );
    argvi++;
}

%typemap(argout) (double * dest, const size_t k, const double * src, const size_t stride, const size_t n) {
    int i=0;
    AV* tempav = newAV();
    while( i < $2 ) {
        av_push(tempav, newSVnv((double) $1[i]));
        i++;
    }

    $result = sv_2mortal( newRV_noinc( (SV*) tempav) );
    argvi++;
}
%typemap(argout) (size_t * p, const size_t k, const gsl_vector * v)
{
    int i=0;
    AV* tempav = newAV();
    while( i < $2 ) {
        av_push(tempav, newSVnv((double) $1[i]));
        i++;
    }

    $result = sv_2mortal( newRV_noinc( (SV*) tempav) );
    argvi++;
}

%typemap(argout) (size_t * p, const double * data, const size_t stride, const size_t n)
{
    int i=0;
    AV* tempav = newAV();
    while( i < $4 ) {
        av_push(tempav, newSVnv((size_t) $1[i]));
        i++;
    }

    $result = sv_2mortal( newRV_noinc( (SV*) tempav) );
    argvi++;
}

%typemap(argout) (size_t * p, const size_t k, const double * src, const size_t stride, const size_t n)
{
    int i=0;
    AV* tempav = newAV();
    while( i < $2 ) {
        av_push(tempav, newSVnv((size_t) $1[i]));
        i++;
    }

    $result = sv_2mortal( newRV_noinc( (SV*) tempav) );
    argvi++;
} 

%apply double * { double *data, double *dest };

%{
    #include "gsl/gsl_nan.h"
    #include "gsl/gsl_sort.h"
    #include "gsl/gsl_sort_double.h"
    #include "gsl/gsl_sort_int.h"
    #include "gsl/gsl_sort_vector.h"
    #include "gsl/gsl_sort_vector_double.h"
    #include "gsl/gsl_sort_vector_int.h"
    #include "gsl/gsl_permutation.h"
%}
%include "gsl/gsl_nan.h"
%include "gsl/gsl_sort.h"
%include "gsl/gsl_sort_double.h"
%include "gsl/gsl_sort_int.h"
%include "gsl/gsl_sort_vector.h"
%include "gsl/gsl_sort_vector_double.h"
%include "gsl/gsl_sort_vector_int.h"
%include "gsl/gsl_permutation.h"


%perlcode %{
@EXPORT_plain = qw/
                gsl_sort gsl_sort_index 
                gsl_sort_smallest gsl_sort_smallest_index
                gsl_sort_largest gsl_sort_largest_index
                /;
@EXPORT_vector= qw/
                gsl_sort_vector gsl_sort_vector_index 
                gsl_sort_vector_smallest gsl_sort_vector_smallest_index
                gsl_sort_vector_largest gsl_sort_vector_largest_index
                /;
@EXPORT_OK    = ( @EXPORT_plain, @EXPORT_vector );
%EXPORT_TAGS  = (
                 all    => [ @EXPORT_OK     ], 
                 plain  => [ @EXPORT_plain  ], 
                 vector => [ @EXPORT_vector ], 
                );
__END__

=head1 NAME

Math::GSL::Sort - Functions for sorting data

=head1 SYNOPSIS

    use Math::GSL::Sort qw/:all/;
    my $x      = [ 2**15, 1.67, 20e5, 
                    -17, 6900, 1/3 , 42e-10 ];
    my $sorted = gsl_sort($x, 1, $#$x+1 );
    my $array = [2,3];
    my ($status, $smallest) = gsl_sort_smallest($array, 2, $x, 1, $#$x+1);


=head1 DESCRIPTION

Here is a list of all the functions included in this module :

=over

=item * gsl_sort_vector($v) - This function sorts the elements of the vector $v into ascending numerical order. 

=item * gsl_sort_vector_index($p, $v) - This function indirectly sorts the elements of the vector $v into ascending order, storing the resulting permutation in $p. The elements of $p give the index of the vector element which would have been stored in that position if the vector had been sorted in place. The first element of $p gives the index of the least element in $v, and the last element of $p gives the index of the greatest element in $v. The vector $v is not changed. 

=item * gsl_sort_vector_smallest($array, $k, $vector) - This function outputs 0 if the operation succeeded, 1 otherwise and then the $k smallest elements of the vector $v. $k must be less than or equal to the length of the vector $v.

=item * gsl_sort_vector_smallest_index($p, $k, $v) - This function outputs 0 if the operation succeeded, 1 otherwise and then the indices of the $k smallest elements of the vector $v. $p must be a prealocated array reference. This should be removed in further versions. $k must be less than or equal to the length of the vector $v. 

=item * gsl_sort_vector_largest($array, $k, $vector) - This function outputs 0 if the operation succeeded, 1 otherwise and then the $k largest elements of the vector $v. $k must be less than or equal to the length of the vector $v.

=item * gsl_sort_vector_largest_index($p, $k, $v) - This function outputs 0 if the operation succeeded, 1 otherwise and then the indices of the $k largest elements of the vector $v. $p must be a prealocated array reference. This should be removed in further versions. $k must be less than or equal to the length of the vector $v. 

=item * gsl_sort($data, $stride, $n) - This function returns an array reference to the sorted $n elements of the array $data with stride $stride into ascending numerical order.

=item * gsl_sort_index($p, $data, $stride, $n) - This function indirectly sorts the $n elements of the array $data with stride $stride into ascending order, outputting the permutation in the foram of an array. $p must be a prealocated array reference. This should be removed in further versions. The array $data is not changed.

=item * gsl_sort_smallest($array, $k, $data, $stride, $n) - This function outputs 0 if the operation succeeded, 1 otherwise and then the $k smallest elements of the array $data, of size $n and stride $stride, in ascending numerical. The size $k of the subset must be less than or equal to $n. The data $src is not modified by this operation. $array must be a prealocated array reference. This should be removed in further versions.

=item * gsl_sort_smallest_index($p, $k, $src, $stride, $n) - This function outputs 0 if the operation succeeded, 1 otherwise and then the indices of the $k smallest elements of the array $src, of size $n and stride $stride. The indices are chosen so that the corresponding data is in ascending numerical order. $k must be less than or equal to $n. The data $src is not modified by this operation. $p must be a prealocated array reference. This should be removed in further versions. 

=item * gsl_sort_largest($array, $k, $data, $stride, $n) - This function outputs 0 if the operation succeeded, 1 otherwise and then the $k largest elements of the array $data, of size $n and stride $stride, in ascending numerical. The size $k of the subset must be less than or equal to $n. The data $src is not modified by this operation. $array must be a prealocated array reference. This should be removed in further versions.

=item * gsl_sort_largest_index($p, $k, $src, $stride, $n) - This function outputs 0 if the operation succeeded, 1 otherwise and then the indices of the $k largest elements of the array $src, of size $n and stride $stride. The indices are chosen so that the corresponding data is in ascending numerical order. $k must be less than or equal to $n. The data $src is not modified by this operation. $p must be a prealocated array reference. This should be removed in further versions. 

=back

 You have to add the functions you want to use inside the qw /put_funtion_here /. 
 You can also write use Math::GSL::Sort qw/:all/ to use all avaible functions of the module. 
 Other tags are also avaible, here is a complete list of all tags for this module :

=over

=item all

=item plain

=item vector

=back

For more informations on the functions, we refer you to the GSL offcial documentation: 
L<http://www.gnu.org/software/gsl/manual/html_node/>

Tip : search on google: site:http://www.gnu.org/software/gsl/manual/html_node/ name_of_the_function_you_want

=head1 PERFORMANCE

In the source code of Math::GSL, the file "examples/benchmark/sort" compares
the performance of gsl_sort() to Perl's builtin sort() function. It's first
argument is the number of iterations and the second is the size of the array
of numbers to sort. For example, to see a benchmark of 1000 iterations for 
arrays of size 50000 you would type

    ./examples/benchmark/sort 1000 50000

Initial benchmarks indicate just slightly above a 2x performance increase
over sort() for arrays of between 5000 and 50000 elements. This may mostly
be due to the fact that gsl_sort() takes and returns a reference while sort()
takes and returns a plain list.

=head1 AUTHORS

Jonathan Leto <jonathan@leto.net> and Thierry Moisan <thierry.moisan@gmail.com>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2008 Jonathan Leto and Thierry Moisan

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

%}
