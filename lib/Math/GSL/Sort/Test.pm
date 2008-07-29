package Math::GSL::Sort::Test;
use base q{Test::Class};
use Test::More;
use Math::GSL::Permutation qw/:all/;
use Math::GSL::Sort qw/:all/;
use Math::GSL::Vector qw/:all/;
use Math::GSL qw/:all/;
use Math::GSL::Errno qw/:all/;
use Data::Dumper;
use strict;

BEGIN { gsl_set_error_handler_off(); }

sub make_fixture : Test(setup) {
}

sub teardown : Test(teardown) {
}

sub GSL_SORT_VECTOR : Tests {
   my $vec = Math::GSL::Vector->new([6,4,2,3,1,5]);
   gsl_sort_vector($vec->raw);
   ok_similar( [ $vec->as_list ], [ 1 .. 6 ] );
} 

sub GSL_SORT_VECTOR_LARGEST : Tests {
   my $vec = Math::GSL::Vector->new([reverse 0..50]);
   my $largest10 = [1..10];
   # $largest10 should not have to be passed in
   my ($status, $stuff) = gsl_sort_vector_largest($largest10, 10, $vec->raw);
   ok_status( $status, $GSL_SUCCESS);
   ok_similar( $stuff, [ reverse (41 .. 50) ] );
} 

sub GSL_SORT_VECTOR_SMALLEST : Tests {
   my $vec = Math::GSL::Vector->new([reverse 0..50]);
   my $smallest10 = [1..10];
   # $smallest10 should not have to be passed in
   my ($status, $stuff) = gsl_sort_vector_smallest($smallest10, 10, $vec->raw);
   ok_status( $status, $GSL_SUCCESS);
   ok_similar( $stuff, [ 0 .. 9 ] );
} 

sub GSL_SORT_VECTOR_INDEX : Tests {
  my $vec = Math::GSL::Vector->new([4,2,3,1,5]);
  my $p = Math::GSL::Permutation->new(5);
  ok_status(gsl_sort_vector_index($p->raw, $vec->raw),$GSL_SUCCESS);
  # indices in ascending order
  ok_similar( [ $p->as_list ], [ 3, 1, 2, 0 , 4] );

}

sub GSL_SORT : Tests {
   my $x = [ 2**15, 1, 42.7, -17, 6900, 3e-10 , 4242, 0e0];
   # size of $x should not have to be passed in
   my $sorted = gsl_sort($x, 1, $#$x+1 );
   ok_similar ( $sorted , [ -17, 0e0, 3e-10, 1, 42.7, 4242, 6900, 2**15 ], 'gsl_sort' );    
}

42;
