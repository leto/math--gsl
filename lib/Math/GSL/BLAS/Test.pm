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
 my $vec1 = gsl_vector_float_alloc(4);
 my $vec2 = gsl_vector_float_alloc(4);
 map { gsl_vector_float_set($vec1, $_, ($_+1)**2) } (0..3);
 map { gsl_vector_float_set($vec2, $_, $_+1) } (0..3);
 my ($x, $result)= gsl_blas_sdsdot(2, $vec1, $vec2); 
# this part fail because the vectors should be initiated with gsl_vector_float_alloc...
# however, the gsl_vector_float_alloc function seems to be deprecated, how should I use BLAS level1 function then?
# there's no test suite yet for the BLAS functions in GSL...
} 


1;
