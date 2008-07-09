package Math::GSL::BLAS::Test;
use base q{Test::Class};
use Test::More;
use Math::GSL::BLAS qw/:all/;
use Math::GSL::Vector qw/:all/;
use Math::GSL::Complex qw/:all/;
use Math::GSL qw/:all/;
use Data::Dumper;
use Math::GSL::Errno qw/:all/;
use strict;

sub make_fixture : Test(setup) {
}

sub teardown : Test(teardown) {
}

#sub GSL_BLAS_SDSDOT : Tests {
# my $vec1 = gsl_vector_float_alloc(4);
# my $vec2 = gsl_vector_float_alloc(4);
# map { gsl_vector_float_set($vec1, $_, ($_+1)**2) } (0..3);
# map { gsl_vector_float_set($vec2, $_, $_+1) } (0..3);
# my ($x, $result)= gsl_blas_sdsdot(2, $vec1, $vec2); 
# this part fail because the vectors should be initiated with gsl_vector_float_alloc...
# however, the gsl_vector_float_alloc function seems to be deprecated, how should I use BLAS level1 function then?
# there's no test suite yet for the BLAS functions in GSL...
#} 

sub GSL_BLAS_DDOT : Tests {
  my $vec1 = Math::GSL::Vector->new([1,2,3,4,5]);
  my $vec2 = Math::GSL::Vector->new([5,4,3,2,1]);
  my ($x, $result) = gsl_blas_ddot($vec1->raw, $vec2->raw);
  is($x, 0);
  is($result,35);
}

sub GSL_BLAS_ZDOTU : Tests {
  my $vec1 = gsl_vector_complex_alloc(2);
  my $vec2 = gsl_vector_complex_alloc(2);
  my $c = gsl_complex_rect(2,1);
  gsl_vector_complex_set($vec1,0,$c); 
  gsl_vector_complex_set($vec2,0,$c); 
  $c = gsl_complex_rect(1,1);
  gsl_vector_complex_set($vec1,1,$c); 
  gsl_vector_complex_set($vec2,1,$c);
  is(gsl_blas_zdotu($vec1, $vec2, $c),0);
  is(gsl_real($c), 3); 
  is(gsl_imag($c), 6);
}

sub GSL_BLAS_ZDOTC : Tests {
  my $vec1 = gsl_vector_complex_alloc(2);
  my $vec2 = gsl_vector_complex_alloc(2);
  my $c = gsl_complex_rect(2,1);
  gsl_vector_complex_set($vec1,0,$c); 
  gsl_vector_complex_set($vec2,0,$c); 
  $c = gsl_complex_rect(1,1);
  gsl_vector_complex_set($vec1,1,$c); 
  gsl_vector_complex_set($vec2,1,$c);
  is(gsl_blas_zdotc($vec1, $vec2, $c),0);
  is(gsl_real($c), 7); 
  is(gsl_imag($c), 0);
}

sub GSL_BLAS_DNRM2 : Tests {
  my $vec = Math::GSL::Vector->new([3,4]);
  is(gsl_blas_dnrm2($vec->raw), 5);
}
  

sub GSL_BLAS_DZNRM2 : Tests {
  my $vec = gsl_vector_complex_alloc(2);
  my $c = gsl_complex_rect(2,1);
  gsl_vector_complex_set($vec,0,$c); 
  $c = gsl_complex_rect(1,1);
  gsl_vector_complex_set($vec,1,$c); 
  is(gsl_blas_dznrm2($vec), sqrt(7));
}

sub GSL_BLAS_DASUM : Tests {
  my $vec = Math::GSL::Vector->new([2,-3,4]);
  is(gsl_blas_dasum($vec->raw), 9);
}

sub GSL_BLAS_DZASUM : Tests {
  my $vec = gsl_vector_complex_alloc(2);
  my $c = gsl_complex_rect(2,1);
  gsl_vector_complex_set($vec,0,$c); 
  $c = gsl_complex_rect(1,1);
  gsl_vector_complex_set($vec,1,$c); 
  is(gsl_blas_dzasum($vec), 5);
}

sub GSL_BLAS_DSWAP : Tests {
  my $vec1 = Math::GSL::Vector->new([0,1,2]);
  my $vec2 = Math::GSL::Vector->new([2,1,0]);
  gsl_blas_dswap($vec1->raw, $vec2->raw);
  my @got = $vec2->as_list;
  map { is($got[$_], $_) } (0..2);
  @got = $vec1->as_list;
  is($got[0], 2);
  is($got[1], 1);
  is($got[2], 0);
}

1;
