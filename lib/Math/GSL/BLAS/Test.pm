package Math::GSL::BLAS::Test;
use base q{Test::Class};
use Test::More;
use Math::GSL::BLAS qw/:all/;
use Math::GSL::Vector qw/:all/;
use Math::GSL qw/:all/;
use Data::Dumper;
use Math::GSL::Errno qw/:all/;
use strict;

sub make_fixture : Test(setup) {
}

sub teardown : Test(teardown) {
}

sub GSL_BLAS_SDSDOT : Tests {
 my $vec1 = Math::GSL::Vector->new( [ map { $_ ** 2 } (1..4) ] );
 my $vec2 = Math::GSL::Vector->new( [ map { $_ } (1..4) ] );
 my ($x, $result)= gsl_blas_sdsdot(2, $vec1, $vec2); 
# this part fail because the vectors should be initiated with gsl_vector_float_alloc... still need to add them to Vector.i
} 


1;
