%module Vector
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

FILE *fopen(char *, char *);
int fclose(FILE *);

%perlcode %{


@EXPORT_OK  = qw/fopen fclose
                 gsl_vector_alloc gsl_vector_calloc gsl_vector_alloc_from_b gsl_vector_alloc_from_v
                 gsl_vector_free gsl_vector_view_array gsl_vector_view_array_w gsl_vector_const_view_a
                 gsl_vector_const_view_a gsl_vector_subvector gsl_vector_subvector_wi 
                 gsl_vector_const_subvec gsl_vector_const_subvec gsl_vector_get gsl_vector_set
                 gsl_vector_ptr gsl_vector_const_ptr gsl_vector_set_zero gsl_vector_set_all
                 gsl_vector_set_basis gsl_vector_fread gsl_vector_fwrite gsl_vector_fscanf
                 gsl_vector_fprintf gsl_vector_memcpy gsl_vector_reverse gsl_vector_swap 
                 gsl_vector_swap_element gsl_vector_max gsl_vector_min gsl_vector_minmax 
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

%}
