package Math::GSL::Vector::Test;
use base q{Test::Class};
use Test::More;
use Math::GSL::Vector qw/:all/;
use Math::GSL qw/is_similar/;
use Data::Dumper;
use Math::GSL::Errno;
use strict;

BEGIN{ Math::GSL::Errno::gsl_set_error_handler_off(); }

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

sub GSL_VECTOR_ISNONNEG: Tests {
    my $self = shift;
    map { gsl_vector_set($self->{vector}, $_, -1 ) } (0..4); 
    ok( !gsl_vector_isnonneg($self->{vector}),'gsl_vector_isnonneg' );
    map { gsl_vector_set($self->{vector}, $_, 1 ) } (0..4); 
    ok( gsl_vector_isnonneg($self->{vector}),'gsl_vector_isnonneg' );
}

sub GSL_VECTOR_ISNULL: Tests {
    my $self = shift;
    ok( !gsl_vector_isnull($self->{vector}), 'gsl_vector_isnull' );
    map { gsl_vector_set($self->{vector}, $_, 0 ) } (0..4); 
    ok( gsl_vector_isnull($self->{vector}),'gsl_vector_isnull' );
    gsl_vector_set($self->{vector}, 0, 5 );
    ok( !gsl_vector_isnull($self->{vector}), 'gsl_vector_isnull' );
}

sub GSL_VECTOR_ISPOS: Tests {
    my $self = shift;
    map { gsl_vector_set($self->{vector}, $_, -1 ) } (0..4); 
    ok( !gsl_vector_ispos($self->{vector}),'gsl_vector_pos' );
    map { gsl_vector_set($self->{vector}, $_, 1 ) } (0..4); 
    ok( gsl_vector_ispos($self->{vector}),'gsl_vector_pos' );
}

sub GSL_VECTOR_ISNEG: Tests {
    my $self = shift;

    map { gsl_vector_set($self->{vector}, $_, -$_ ) } (0..4); 
    ok( !gsl_vector_isneg($self->{vector}),'gsl_vector_neg' );

    gsl_vector_set($self->{vector}, 0, -1 );

    ok( gsl_vector_isneg($self->{vector}),'gsl_vector_neg' );
}

sub GSL_VECTOR_MAX: Tests {
    my $self = shift;
    map { gsl_vector_set($self->{vector}, $_, $_ ** 2 ) } (0..4); ;
    ok( is_similar( gsl_vector_max($self->{vector}) ,16), 'gsl_vector_max' );
}
sub GSL_VECTOR_NEW: Tests {
    my $vec = Math::GSL::Vector->new( [ map { $_ ** 2 } (1..10) ] );
    isa_ok( $vec, 'Math::GSL::Vector', 'Math::GSL::Vector->new($values)' );

    eval { Math::GSL::Vector->new(-1) };
    ok( $@, 'new takes only positive indices');

    eval { Math::GSL::Vector->new(3.14) };
    ok( $@, 'new takes only integer indices');

    eval { Math::GSL::Vector->new([]) };
    ok( $@, 'new takes only nonempty array refs');
}
sub GSL_VECTOR_MIN: Tests {
    my $self = shift;
    map { gsl_vector_set($self->{vector}, $_, $_ ** 2 ) } (0..4); ;
    ok( is_similar( gsl_vector_min($self->{vector}) ,0), 'gsl_vector_min' );
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
