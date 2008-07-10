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

sub make_fixture : Test(setup) {
}

sub teardown : Test(teardown) {
}

sub GSL_SORT_VECTOR : Tests {
   my $vec = Math::GSL::Vector->new([4,2,3,1,5]);
   gsl_sort_vector($vec->raw);
   ok_similar( [ $vec->as_list ], [ 1 .. 5 ] );
} 

sub GSL_SORT_VECTOR_INDEX : Tests {
  local $TODO =  "gsl_permutation_struct vs gsl_permutation *";
  my $vec = Math::GSL::Vector->new([4,2,3,1,5]);
  my $p = Math::GSL::Permutation->new(5);
  ok(0);
  #ok_status(gsl_sort_vector_index($p->raw, $vec->raw),$GSL_SUCCESS);
  #ok_similar( [ $p->as_list ], [ 1 .. 5] );

}

sub GSL_SORT : Tests {
   my @x = [ 2**15, 1, 42, 17, 6900, 3 ];
   my @sorted = gsl_sort(@x, 1, 6 );
   ok_similar ( @sorted , [ 1, 3, 17 , 42, 6900, 2**15 ], 'gsl_sort' );    
}

42;
