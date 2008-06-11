package Math::GSL::Vector::Test;
use base q{Test::Class};
use Test::More;
use Math::GSL::Vector qw/:all/;
use Math::GSL qw/:all/;
use Data::Dumper;
use Math::GSL::Errno qw/:all/;
use strict;

# This allows us to eval code
BEGIN{ gsl_set_error_handler_off(); }

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
sub GSL_VECTOR_GET: Tests {
    my $vec = Math::GSL::Vector->new( [ map { $_ ** 2 } (reverse 1..10) ] );
    my @x = $vec->get([0..9]);
    is_deeply( \@x, [map { $_ ** 2 } (reverse 1..10)] );
}

sub GSL_VECTOR_SET: Tests {
    my $vec = Math::GSL::Vector->new( [ map { $_ ** 2 } (1..10) ] );
    $vec->set( [ 0..4] , [ reverse 1..5 ] );
    my ($x) = $vec->get([0]);
    ok( $x == 5, "gsl_vector_set: $x ?= 5" );
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
    fclose($fh);
}

sub GSL_VECTOR_SUBVECTOR : Tests {
    my $self = shift;
    map { gsl_vector_set($self->{vector}, $_, $_ ** 2 ) } (0..4); ;
    my $vec_sub = gsl_vector_subvector($self->{vector}, 2, 3);

    ok_similar( [ map { gsl_vector_get($vec_sub->{vector}, $_) } (0..2) ], 
                [ 4, 9, 16 ], 
              );
}

sub GSL_VECTOR_CALLOC : Tests {
   my $vector = gsl_vector_calloc(5);
   isa_ok($vector, 'Math::GSL::Vector');
   
   my @got = map { gsl_vector_get($vector, $_) } (0..4);

   map { is($got[$_] , 0 ) } (0..4);
}

sub GSL_VECTOR_SET_ALL : Tests {
   my $self = shift;
   gsl_vector_set_all($self->{vector}, 4);
   map { is(gsl_vector_get($self->{vector} , $_ ), 4) } (0..4);
}

sub GSL_VECTOR_SET_ZERO : Tests {
   my $self = shift;
   gsl_vector_set_zero($self->{vector});
   map { is(gsl_vector_get($self->{vector} , $_ ), 0) } (0..4);
}

sub GSL_VECTOR_SET_BASIS : Tests {
   my $self = shift;
   my $x = gsl_vector_set_basis($self->{vector}, 0);
   is (gsl_vector_get($self->{vector} , 0 ), 1);
   is ($x, 0, "output");
   map { is(gsl_vector_get($self->{vector} , $_ ), 0) } (1..4);
}

sub GSL_VECTOR_SUBVECTOR_WITH_STRIDE : Tests {
   my $self = shift;
   map { gsl_vector_set($self->{vector}, $_, $_ ** 2 ) } (0..4); ;
   my $sub_stride = gsl_vector_subvector_with_stride($self->{vector}, 0, 2, 3);
   is(gsl_vector_get($sub_stride->{vector} , 0 ), 0, "first element");
   is(gsl_vector_get($sub_stride->{vector} , 1 ), 4, "second element");
   is(gsl_vector_get($sub_stride->{vector} , 2 ), 16, "third element");
}

sub GSL_VECTOR_MAX_INDEX : Tests {
   my $self = shift;
   map { gsl_vector_set($self->{vector}, $_, $_ ** 2 ) } (0..4); ;
   my $index = gsl_vector_max_index($self->{vector});
   is($index, 4, "Position of the maximum"); 
}

sub GSL_VECTOR_MIN_INDEX : Tests {
   my $self = shift;
   map { gsl_vector_set($self->{vector}, $_, $_ ** 2 ) } (0..4); ;
   my $index = gsl_vector_min_index($self->{vector});
   is($index, 0, "Position of the minimum"); 
}

sub GSL_VECTOR_MINMAX_INDEX : Tests {
   my $self = shift;
   my ($min,$max)=(0,0);
   map { gsl_vector_set($self->{vector}, $_, $_ ** 2 ) } (0..4); ;

   ($min, $max) = Math::GSL::Vector::gsl_vector_minmax_index($self->{vector}, $min, $max);
   ok_similar( [ 0, 4 ], [ $min, $max], 'gsl_vector_minmax_index' );
}

sub GSL_VECTOR_MINMAX : Tests {
   my ($min, $max) = (17,42);
   my $vector->{vector} = gsl_vector_alloc(5); 
   map { gsl_vector_set($vector->{vector}, $_, $_ ** 2 ) } (0..4); ;

   ($min, $max) = Math::GSL::Vector::gsl_vector_minmax($vector->{vector}, $min, $max);

   ok_similar( [ 0, 16 ], [ $min, $max], 'gsl_vector_minmax' );
}

sub GSL_VECTOR_MEMCPY : Tests {
   my $self = shift;
   my $copy->{vector} = gsl_vector_alloc(5);
   map { gsl_vector_set($self->{vector}, $_, $_ ** 2 ) } (0..4); ;
   is( gsl_vector_memcpy($copy->{vector}, $self->{vector}), 0);
   map { is(gsl_vector_get($copy->{vector}, $_), $_ ** 2 ) } (0..4); ;
}

sub GSL_VECTOR_VIEW_ARRAY : Tests {
   my @array = [1,2,3,4,5,6];
   my $vec_view->{vector} = gsl_vector_alloc(2);
   $vec_view = gsl_vector_view_array(@array, 2);
   map { is(gsl_vector_get($vec_view->{vector}, $_), $_+1 ) } (0..1); ;
}

sub GSL_VECTOR_REVERSE : Tests {
   my $self = shift;
   map { gsl_vector_set($self->{vector}, $_, $_ ** 2 ) } (0..4); ;
   is( gsl_vector_reverse($self->{vector}), 0);
   ok_similar( [ 16, 9, 4, 1, 0], [ map { gsl_vector_get($self->{vector}, $_) } 0..4 ] );
}

sub GSL_VECTOR_SWAP_ELEMENTS : Tests {
   my $self = shift;
   map { gsl_vector_set($self->{vector}, $_, $_ ** 2 ) } (0..4); ;
   is( gsl_vector_swap_elements($self->{vector}, 0, 4), 0);
   is(gsl_vector_get($self->{vector}, 0), 16);
   is(gsl_vector_get($self->{vector}, 4), 0);
   map { is(gsl_vector_get($self->{vector}, $_), $_ ** 2 ) } (1..3); ;   
}

sub GSL_VECTOR_ADD : Tests {
   my $self = shift;
   my $second_vec->{vector} = gsl_vector_alloc(5);
   map { gsl_vector_set($self->{vector}, $_, $_ ) } (0..4); ;
   map { gsl_vector_set($second_vec->{vector}, $_, $_ ) } (0..4); ;
   is(gsl_vector_reverse($second_vec->{vector}),0);
   is( gsl_vector_add($self->{vector}, $second_vec->{vector}), 0);
   map { is(gsl_vector_get($self->{vector}, $_), 4 ) } (0..4); ;   
}

sub GSL_VECTOR_SUB : Tests {
   my $self = shift;
   my $second_vec->{vector} = gsl_vector_alloc(5);
   map { gsl_vector_set($self->{vector}, $_, $_ ) } (0..4); ;
   map { gsl_vector_set($second_vec->{vector}, $_, 1) } (0..4); ;
   is( gsl_vector_sub($self->{vector}, $second_vec->{vector}), 0);
   map { is(gsl_vector_get($self->{vector}, $_), $_ - 1 ) } (0..4); ;   
}

sub GSL_VECTOR_MUL : Tests {
   my $self = shift;
   my $second_vec->{vector} = gsl_vector_alloc(5);
   map { gsl_vector_set($self->{vector}, $_, $_ ) } (0..4); ;
   map { gsl_vector_set($second_vec->{vector}, $_, 2) } (0..4); ;
   is( gsl_vector_mul($self->{vector}, $second_vec->{vector}), 0);
   map { is(gsl_vector_get($self->{vector}, $_), $_ * 2 ) } (0..4); ;   
}

sub GSL_VECTOR_DIV : Tests {
   my $self = shift;
   my $second_vec->{vector} = gsl_vector_alloc(5);
   map { gsl_vector_set($self->{vector}, $_, $_*2 ) } (0..4); ;
   map { gsl_vector_set($second_vec->{vector}, $_, 2) } (0..4); ;
   is( gsl_vector_div($self->{vector}, $second_vec->{vector}), 0);
   map { is(gsl_vector_get($self->{vector}, $_), $_ ) } (0..4); ;   
}

sub GSL_VECTOR_SCALE : Tests {
   my $self = shift;
   map { gsl_vector_set($self->{vector}, $_, $_ ) } (0..4); ;
   is( gsl_vector_scale($self->{vector}, 2), 0);
   map { is(gsl_vector_get($self->{vector}, $_), $_ * 2 ) } (0..4); ;   
}

sub GSL_VECTOR_SWAP : Tests {

   my @idx  = (0..(5+int rand(5)));
   my $vec1 = gsl_vector_alloc($#idx+1);
   my $vec2 = gsl_vector_alloc($#idx+1);

   map { gsl_vector_set($vec1, $_, $_**2 ) } @idx;
   map { gsl_vector_set($vec2, $_, $_)     } @idx;

   is( gsl_vector_swap($vec1, $vec2), 0);

   ok_similar( [ map { gsl_vector_get($vec1, $_)  } @idx ], 
               [ @idx ],
             );
   ok_similar( [ map { gsl_vector_get($vec2, $_)  } @idx ], 
               [ map { $_**2 } @idx ],
             );
}

sub GSL_VECTOR_FPRINTF_FSCANF : Tests {  
   my $self = shift;
   map { gsl_vector_set($self->{vector}, $_, $_**2) } (0..4); 

   my $fh = fopen("vector", "w");
   is( gsl_vector_fprintf($fh, $self->{vector}, "%f"), 0);
   fclose($fh);

   map { gsl_vector_set($self->{vector}, $_, $_**3) } (0..4);

   $fh = fopen("vector", "r");   
   
   is(gsl_vector_fscanf($fh, $self->{vector}), 0);
   map { is(gsl_vector_get($self->{vector}, $_), $_**2) } (0..4);
   fclose($fh); 
}
1;
