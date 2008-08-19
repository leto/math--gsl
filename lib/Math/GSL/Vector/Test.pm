package Math::GSL::Vector::Test;
use base q{Test::Class};
use Test::More;
use Math::GSL::Vector qw/:all/;
use Math::GSL::Complex qw/:all/;
use Math::GSL qw/:all/;
use Data::Dumper;
use Math::GSL::Errno qw/:all/;
use Test::Exception;
use strict;

# This allows us to eval code
BEGIN{ gsl_set_error_handler_off(); }

sub make_fixture : Test(setup) {
    my $self = shift;
    $self->{vector} = gsl_vector_alloc(5);
    $self->{object} = Math::GSL::Vector->new(5);
}

sub teardown : Test(teardown) {
    unlink 'vector' if -f 'vector';
}

sub GSL_VECTOR_ALLOC : Tests {
    my $vector = gsl_vector_alloc(5);
    isa_ok($vector, 'Math::GSL::Vector');
}
sub GSL_VECTOR_LENGTH: Tests {
    my $self = shift;
    my $vector = $self->{object};
    ok( $vector->length == 5, '$vector->length' );
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

sub GSL_VECTOR_NEW: Tests {
    my $vec = Math::GSL::Vector->new( [ map { $_ ** 2 } (1..10) ] );
    isa_ok( $vec, 'Math::GSL::Vector', 'Math::GSL::Vector->new($values)' );

    dies_ok( sub { Math::GSL::Vector->new(-1) }, 'new takes only positive indices');

    dies_ok( sub { Math::GSL::Vector->new(3.14) },  'new takes only integer indices');

    dies_ok( sub { Math::GSL::Vector->new([]) },'new takes only nonempty array refs');

    $vec = Math::GSL::Vector->new(42);
    ok( $vec->length == 42 , 'new creates empty vectors of a given length');
}
sub GSL_VECTOR_AS_LIST: Tests {
    my $vec = Math::GSL::Vector->new( [ map { $_ ** 2 } (reverse 1..10) ] );
    my @x = $vec->as_list;
    is_deeply( \@x, [map { $_ ** 2 } (reverse 1..10)] );
}

sub GSL_VECTOR_SET: Tests {
    my $vec = Math::GSL::Vector->new( [ map { $_ ** 2 } (1..10) ] );
    $vec->set( [ 0..4] , [ reverse 1..5 ] );
    my ($x) = $vec->get([0]);
    ok( $x == 5, "gsl_vector_set: $x ?= 5" );
}
sub GSL_VECTOR_MIN: Tests {
    my $vec = Math::GSL::Vector->new( [ map { $_ ** 2 } (0..4) ] );
    ok_similar( $vec->min ,0, '$vec->min' );
    ok_similar( gsl_vector_min($vec->raw) ,0, 'gsl_vector_min' );
}

sub GSL_VECTOR_MAX: Tests {
    my $vec = Math::GSL::Vector->new( [ 3, 567, 4200 ]);
    ok_similar( $vec->max ,4200, '$vec->min' );
    ok_similar( gsl_vector_max($vec->raw) ,4200, 'gsl_vector_max' );
}
sub GSL_VECTOR_FREAD_FWRITE: Tests { 
    my $self = shift;
    map { gsl_vector_set($self->{vector}, $_, $_ ** 2 ) } (0..4); ;

    my $fh = gsl_fopen("vector", 'w');
    my $status = gsl_vector_fwrite($fh, $self->{vector} );
    ok( ! $status, 'gsl_vector_fwrite' );
    ok( -f "vector", 'gsl_vector_fwrite' );
    ok_status(fclose($fh));

    map { gsl_vector_set($self->{vector}, $_, $_ ** 3 ) } (0..4); 

    $fh = gsl_fopen("vector", 'r');

    ok_status(gsl_vector_fread($fh, $self->{vector} ));
    is_deeply( [ map { gsl_vector_get($self->{vector}, $_) } (0..4) ],
               [ map { $_ ** 2 } (0..4) ],
             );
    ok_status(gsl_fclose($fh));
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
}

sub GSL_VECTOR_SET_ALL : Tests {
   my $vec = Math::GSL::Vector->new(5);
   gsl_vector_set_all($vec->raw, 4);
   ok_similar( [ $vec->as_list ], [ (4) x 5 ] );
}

sub GSL_VECTOR_SET_ZERO : Tests {
   my $self = shift;
   gsl_vector_set_zero($self->{vector});
   map { is(gsl_vector_get($self->{vector} , $_ ), 0) } (0..4);
}

sub GSL_VECTOR_SET_BASIS : Tests {
   my $self = shift;
   ok_status(gsl_vector_set_basis($self->{vector}, 0));
   is (gsl_vector_get($self->{vector} , 0 ), 1);
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
   my ($min, $max);
   map { gsl_vector_set($self->{vector}, $_, $_ ** 2 ) } (0..4); 
   ($min, $max) = gsl_vector_minmax_index($self->{vector});
   ok_similar( [ 0, 4 ], [ $min, $max], 'gsl_vector_minmax_index' );
}

sub GSL_VECTOR_MINMAX : Tests {
   my ($min, $max);
   my $vector = gsl_vector_alloc(5); 
   map { gsl_vector_set($vector, $_, $_ ** 2 ) } (0..4); 

   ($min, $max) = gsl_vector_minmax($vector);

   ok_similar( [ 0, 16 ], [ $min, $max], 'gsl_vector_minmax' );
}

sub GSL_VECTOR_MEMCPY : Tests {
   my $self = shift;
   my $copy = gsl_vector_alloc(5);
   map { gsl_vector_set($self->{vector}, $_, $_ ** 2 ) } (0..4); ;
   is( gsl_vector_memcpy($copy, $self->{vector}), 0);
   map { is(gsl_vector_get($copy, $_), $_ ** 2 ) } (0..4); ;
}

sub GSL_VECTOR_VIEW_ARRAY : Tests {
   my @array = [1,2,3,4,5,6]; 
   my $vec_view = gsl_vector_view_array(@array, 2);
   map { is(gsl_vector_get($vec_view->{vector}, $_), $_+1 ) } (0..1); ;
}

sub GSL_VECTOR_REVERSE : Tests {
   my $self = shift;
   map { gsl_vector_set($self->{vector}, $_, $_ ** 2 ) } (0..4); ;
   ok_status( gsl_vector_reverse($self->{vector}));
   ok_similar( [ 16, 9, 4, 1, 0], [ map { gsl_vector_get($self->{vector}, $_) } 0..4 ] );
}

sub GSL_VECTOR_SWAP_ELEMENTS : Tests {
   my $self = shift;
   map { gsl_vector_set($self->{vector}, $_, $_ ** 2 ) } (0..4); ;
   ok_status( gsl_vector_swap_elements($self->{vector}, 0, 4));
   is(gsl_vector_get($self->{vector}, 0), 16);
   is(gsl_vector_get($self->{vector}, 4), 0);
   map { is(gsl_vector_get($self->{vector}, $_), $_ ** 2 ) } (1..3); ;   
}

sub GSL_VECTOR_ADD : Tests {
   my $self = shift;
   my $second_vec = gsl_vector_alloc(5);
   map { gsl_vector_set($self->{vector}, $_, $_ ) } (0..4); ;
   map { gsl_vector_set($second_vec, $_, $_ ) } (0..4); ;
   ok_status(gsl_vector_reverse($second_vec));
   is( gsl_vector_add($self->{vector}, $second_vec), 0);
   map { is(gsl_vector_get($self->{vector}, $_), 4 ) } (0..4); ;   
}

sub GSL_VECTOR_SUB : Tests {
   my $self = shift;
   my $second_vec = gsl_vector_alloc(5);
   map { gsl_vector_set($self->{vector}, $_, $_ ) } (0..4); ;
   map { gsl_vector_set($second_vec, $_, 1) } (0..4); ;
   ok_status( gsl_vector_sub($self->{vector}, $second_vec));
   map { is(gsl_vector_get($self->{vector}, $_), $_ - 1 ) } (0..4); ;   
}

sub GSL_VECTOR_MUL : Tests {
   my $self = shift;
   my $second_vec = gsl_vector_alloc(5);
   map { gsl_vector_set($self->{vector}, $_, $_ ) } (0..4); ;
   map { gsl_vector_set($second_vec, $_, 2) } (0..4); ;
   ok_status( gsl_vector_mul($self->{vector}, $second_vec));
   map { is(gsl_vector_get($self->{vector}, $_), $_ * 2 ) } (0..4); ;   
}

sub GSL_VECTOR_DIV : Tests {
   my $self = shift;
   my $second_vec = gsl_vector_alloc(5);
   map { gsl_vector_set($self->{vector}, $_, $_*2 ) } (0..4); ;
   map { gsl_vector_set($second_vec, $_, 2) } (0..4); ;
   ok_status( gsl_vector_div($self->{vector}, $second_vec));
   map { is(gsl_vector_get($self->{vector}, $_), $_ ) } (0..4); ;   
}

sub GSL_VECTOR_SCALE : Tests {
   my $v = Math::GSL::Vector->new([0..4]);
   ok_status(gsl_vector_scale($v->raw, 2));
   ok_similar( [ $v->as_list ], [ 0,2,4,6,8 ] );
}

sub GSL_VECTOR_SCALE_OVERLOAD : Tests {
   my $v = Math::GSL::Vector->new([0..4]);
   my $expected = [ map { $_*5} (0..4) ];
   $v = 5 * $v;
   ok_similar( [ $v->as_list ],  $expected );

   my $w = Math::GSL::Vector->new([0..4]);
   $w = $w * 5;
   ok_similar( [ $w->as_list ], $expected );
}

sub GSL_VECTOR_DOT_PRODUCT : Tests {
   my $v = Math::GSL::Vector->new([0..4]);
   my $w = Math::GSL::Vector->new([0..4]);

   ok_similar( $v * $w ,  4*4 + 3*3 + 2*2 + 1*1 );

   my $z = Math::GSL::Vector->new([0..10]);
   dies_ok( sub { $z * $v; }, 'dot_product checks vector length' );

   my $q = Math::GSL::Vector->new(5);
   ok_similar ( $q * $q, 0, 'newly created vectors are zero-filled');
}

sub GSL_VECTOR_SWAP : Tests {

   my @idx  = (0..(5+int rand(5)));
   my $vec1 = gsl_vector_alloc($#idx+1);
   my $vec2 = gsl_vector_alloc($#idx+1);

   map { gsl_vector_set($vec1, $_, $_**2 ) } @idx;
   map { gsl_vector_set($vec2, $_, $_)     } @idx;

   ok_status( gsl_vector_swap($vec1, $vec2));

   ok_similar( [ map { gsl_vector_get($vec1, $_)  } @idx ], 
               [ @idx ],
             );
   ok_similar( [ map { gsl_vector_get($vec2, $_)  } @idx ], 
               [ map { $_**2 } @idx ],
             );
}

sub GSL_VECTOR_FPRINTF_FSCANF : Tests {  
   my $vec1 = Math::GSL::Vector->new([ map { $_ ** 2 } (0..4) ]);

   my $fh = gsl_fopen("vector", 'w');
   ok( defined $fh, 'fopen -  write');
   ok_status(gsl_vector_fprintf($fh, $vec1->raw, "%f"));
   ok_status(gsl_fclose($fh));

   my $vec2 = Math::GSL::Vector->new([ map { $_ ** 3 } (0..4) ]);

   $fh = gsl_fopen("vector", 'r');   
   ok( defined $fh, 'fopen  - readonly');
   
   ok_status(gsl_vector_fscanf($fh, $vec2->raw));

   ok_similar( [ $vec2->as_list ], [ map { $_ ** 2 } (0..4) ]);
   ok_status(gsl_fclose($fh) ); 
}

sub GSL_VECTOR_COMPLEX_ALLOC : Tests {
  my $vec = gsl_vector_complex_alloc(5);
  isa_ok($vec, 'Math::GSL::Vector');
}

sub GSL_VECTOR_COMPLEX_CALLOC : Tests {
  my $vec = gsl_vector_complex_calloc(5);
  isa_ok($vec, 'Math::GSL::Vector');
}

sub GSL_VECTOR_COMPLEX_SET_GET : Tests {
  my $vec = gsl_vector_complex_calloc(5);
  my $complex = gsl_complex_rect(2,1);
  gsl_vector_complex_set($vec, 0, $complex);
  my $result = gsl_complex_rect(5,5);
  $result = gsl_vector_complex_get($vec, 0);
  isa_ok($result, 'Math::GSL::Complex');
  #print Dumper [ $result ];
  local $TODO = "don't know why the complex returned gsl_vector_complex_get is not usable";
  #my @got = gsl_parts($result);
}
1;
