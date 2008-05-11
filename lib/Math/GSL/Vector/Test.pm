package Math::GSL::Vector::Test;
use base q{Test::Class};
use Test::More;
use Math::GSL::Vector qw/:all/;
use Math::GSL qw/is_similar/;
use Data::Dumper;
use strict;

sub make_fixture : Test(setup) {
    my $self = shift;
    $self->{vector} = gsl_vector_alloc(5);
}

sub teardown : Test(teardown) {
    unlink 'vector' if -f 'vector';
}

sub GSL_VECTOR_ALLOC : Tests {
    my $vector = gsl_vector_alloc(5);
    isa_ok($vector, 'Math::GSL::Vector');
}
sub GSL_VECTOR_SET_GET: Tests { 
    my $self = shift;
    gsl_vector_set($self->{vector}, 0, 42 );
    my $elem   = gsl_vector_get($self->{vector}, 0);
    ok( $elem == 42, 'gsl_vector_set/gsl_vector_get' );
}

sub GSL_VECTOR_FREAD_FWRITE: Tests { 
    my $self = shift;
    map { gsl_vector_set($self->{vector}, $_, $_ ** 2 ) } (0..4); ;

    my $fh = fopen("vector", "w");
    my $status = gsl_vector_fwrite($fh, $self->{vector} );
    ok( ! $status, 'gsl_vector_fwrite' );
    ok( -f "vector", 'gsl_vector_fwrite' );
    fclose($fh);

    map { gsl_vector_set($self->{vector}, $_, $_ ** 3 ) } (0..4); 

    $fh = fopen("vector", "r");

    gsl_vector_fread($fh, $self->{vector} );
    is_deeply( [ map { gsl_vector_get($self->{vector}, $_) } (0..4) ],
               [ map { $_ ** 2 } (0..4) ],
             );

}
1;
