%module "Math::GSL::Combination"

%{
    #include "gsl/gsl_types.h"
    #include "gsl/gsl_combination.h"
%}

%include "gsl/gsl_types.h"
%include "gsl/gsl_combination.h"


%perlcode %{
@EXPORT_OK = qw/
               gsl_combination_alloc 
               gsl_combination_calloc 
               gsl_combination_init_first 
               gsl_combination_init_last 
               gsl_combination_free 
               gsl_combination_memcpy 
               gsl_combination_fread 
               gsl_combination_fwrite 
               gsl_combination_fscanf 
               gsl_combination_fprintf 
               gsl_combination_n 
               gsl_combination_k 
               gsl_combination_data 
               gsl_combination_get 
               gsl_combination_valid 
               gsl_combination_next 
               gsl_combination_prev 
             /;
%EXPORT_TAGS = ( all => [ @EXPORT_OK ] );

__END__

=head1 NAME

Math::GSL::Combination - Functions for creating and manipulating combinations

=head1 SYNOPSIS

use Math::GSL::Combination qw /:all/;

=head1 DESCRIPTION

Here is a list of all the functions in this module :

=over

=item * C<gsl_combination_alloc($n, $k)> - This function allocates memory for a new combination with parameters $n, $k. The combination is not initialized and its elements are undefined. Use the function gsl_combination_calloc if you want to create a combination which is initialized to the lexicographically first combination.

=item * C<gsl_combination_calloc($n, $k)> - This function allocates memory for a new combination with parameters $n, $k and initializes it to the lexicographically first combination.

=item * C<gsl_combination_init_first($c)> - This function initializes the combination $c to the lexicographically first combination, i.e. (0,1,2,...,k-1). 

=item * C<gsl_combination_init_last($c)> - This function initializes the combination $c to the lexicographically last combination, i.e. (n-k,n-k+1,...,n-1). 

=item * C<gsl_combination_free($c)> - This function frees all the memory used by the combination $c.

=item * C<gsl_combination_memcpy($dest, $src)> - This function copies the elements of the combination $src into the combination $dest. The two combinations must have the same size.

=item * C<gsl_combination_get($c, $i)> - This function returns the value of the i-th element of the combination $c. If $i lies outside the allowed range of 0 to k-1 then the error handler is invoked and 0 is returned.

=item * C<gsl_combination_fwrite($stream, $c)> - This function writes the elements of the combination $c to the stream $stream, opened with the gsl_fopen function from the Math::GSL module, in binary format. The function returns $GSL_EFAILED if there was a problem writing to the file. Since the data is written in the native binary format it may not be portable between different architectures.

=item * C<gsl_combination_fread($stream, $c)> - This function reads elements from the open stream $stream, opened with the gsl_fopen function from the Math::GSL module, into the combination $c in binary format. The combination $c must be preallocated with correct values of n and k since the function uses the size of $c to determine how many bytes to read. The function returns $GSL_EFAILED if there was a problem reading from the file. The data is assumed to have been written in the native binary format on the same architecture.

=item * C<gsl_combination_fprintf($stream, $c, $format)> - This function writes the elements of the combination $c line-by-line to the stream $stream, opened with the gsl_fopen function from the Math::GSL module, using the format specifier $format, which should be suitable for a type of size_t. In ISO C99 the type modifier z represents size_t, so "%zu\n" is a suitable format. The function returns $GSL_EFAILED if there was a problem writing to the file.

=item * C<gsl_combination_fscanf($stream, $c)> -This function reads formatted data from the stream $stream into the combination $c. The combination $c must be preallocated with correct values of n and k since the function uses the size of $c to determine how many numbers to read. The function returns $GSL_EFAILED if there was a problem reading from the file.

=item * C<gsl_combination_n($c)> - This function returns the range (n) of the combination $c.

=item * C<gsl_combination_k($c)> - This function returns the number of elements (k) in the combination $c.

=item * C<gsl_combination_data($c)> - This function returns a pointer to the array of elements in the combination $c.

=item * C<gsl_combination_valid($c)> - This function checks that the combination $c is valid. The k elements should lie in the range 0 to n-1, with each value occurring once at most and in increasing order.

=item * C<gsl_combination_next($c)> - This function advances the combination $c to the next combination in lexicographic order and returns $GSL_SUCCESS. If no further combinations are available it returns $GSL_FAILURE and leaves $c unmodified. Starting with the first combination and repeatedly applying this function will iterate through all possible combinations of a given order.

=item * C<gsl_combination_prev($c)> - This function steps backwards from the combination $c to the previous combination in lexicographic order, returning $GSL_SUCCESS. If no previous combination is available it returns $GSL_FAILURE and leaves $c unmodified.

=back


For more informations on the functions, we refer you to the GSL offcial
documentation: L<http://www.gnu.org/software/gsl/manual/html_node/>

 Tip : search on google: site:http://www.gnu.org/software/gsl/manual/html_node/ name_of_the_function_you_want


=head1 AUTHORS

Jonathan Leto <jonathan@leto.net> and Thierry Moisan <thierry.moisan@gmail.com>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2008 Jonathan Leto and Thierry Moisan

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

%}
