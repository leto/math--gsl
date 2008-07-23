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
    fprintf(stderr, "matched argout\n");
    int i=0;
    AV* tempav = newAV();

    while( i < $2 ) {
        av_push(tempav, newSVnv((double) $1[i]));
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


=head1 DESCRIPTION

Here is a list of all the functions included in this module :

=over

=item gsl_sort_vector($v) - This function sorts the elements of the vector v into ascending numerical order. 

=item gsl_sort_vector_index 

=item gsl_sort_vector_smallest

=item gsl_sort_vector_smallest_index

=item gsl_sort_vector_largest

=item gsl_sort_vector_largest_index

=item gsl_sort

=item gsl_sort_index 

=item gsl_sort_smallest

=item gsl_sort_smallest_index

=item gsl_sort_largest

=item gsl_sort_largest_index

=back

 You have to add the functions you want to use inside the qw /put_funtion_here /. 
 You can also write use Math::GSL::Sort qw/:all/ to use all avaible functions of the module. 
 Other tags are also avaible, here is a complete list of all tags for this module :

=over

=item all

=item plain

=item vector

=back

 For more informations on the functions, we refer you to the GSL offcial documentation: http://www.gnu.org/software/gsl/manual/html_node/
 Tip : search on google: site:http://www.gnu.org/software/gsl/manual/html_node/ name_of_the_function_you_want

=head1 EXAMPLES

=head1 AUTHORS

Jonathan Leto <jonathan@leto.net> and Thierry Moisan <thierry.moisan@gmail.com>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2008 Jonathan Leto and Thierry Moisan

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

%}
