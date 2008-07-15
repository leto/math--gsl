package Math::GSL::BLAS::Test;
use base q{Test::Class};
use Test::More;
use Math::GSL::BLAS qw/:all/;
use Math::GSL::Vector qw/:all/;
use Math::GSL::Complex qw/:all/;
use Math::GSL::Matrix qw/:all/;
use Math::GSL::CBLAS qw/:all/;
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

sub GSL_BLAS_ZSWAP : Tests { 
  local $TODO = "Problem with the output of gsl_vector_complex_get";
  my $vec1 = gsl_vector_complex_alloc(2);
  my $vec2 = gsl_vector_complex_alloc(2);
  my $c = gsl_complex_rect(5,4);
  gsl_vector_complex_set($vec1,0,$c); 
  $c = gsl_complex_rect(2,2);
  gsl_vector_complex_set($vec1,1, $c);
  $c = gsl_complex_rect(3,3);
  print Dumper [ $c ]; 
  gsl_vector_complex_set($vec2,0, $c);
  $c = gsl_complex_rect(1,1); 
  gsl_vector_complex_set($vec2,1, $c);

  is(gsl_blas_zswap($vec1, $vec2), 0);
  $c = gsl_vector_complex_get($vec1,0);
  print Dumper [ $c ];
#  is( gsl_real($c), 3);
#  is( gsl_imag($x), 3);
}

sub GSL_BLAS_DCOPY : Tests {
 my $vec1 = Math::GSL::Vector->new([0,1,2]);
 my $vec2 = Math::GSL::Vector->new(3);
 is(gsl_blas_dcopy($vec1->raw, $vec2->raw),0);
 my @got = $vec2->as_list;
 map { is($got[$_], $_) } (0..2);
}

sub GSL_BLAS_DAXPY : Tests { 
 my $vec1 = Math::GSL::Vector->new([0,1,2]);
 my $vec2 = Math::GSL::Vector->new([2,3,4]);
 is(gsl_blas_daxpy(2,$vec1->raw, $vec2->raw),0);
 my @got = $vec2->as_list;
 is($got[0], 2);
 is($got[1], 5); 
 is($got[2], 8);
}

sub GSL_BLAS_DSCAL : Tests {
 my $vec = Math::GSL::Vector->new([0,1,2]);
 gsl_blas_dscal(4, $vec->raw);
 my @got = $vec->as_list;
 map { is($got[$_], $_*4) } (0..2); 
}

sub GSL_BLAS_DROT : Tests {
 my $x = Math::GSL::Vector->new([1,2,3]);
 my $y = Math::GSL::Vector->new([0,1,2]);
 is(gsl_blas_drot($x->raw,$y->raw,2,3),0);
 ok_similar( [$x->as_list], [ 2,7,12], 'first vector');
 ok_similar( [$y->as_list], [-3,-4,-5], 'second vector');
}

sub GSL_BLAS_DGER : Tests { 
 my $x = Math::GSL::Vector->new([1,2,3]);
 my $y = Math::GSL::Vector->new([0,1,2]);
 my $A = Math::GSL::Matrix->new(3,3); 
 gsl_matrix_set_zero($A->raw);
 is(gsl_blas_dger(2, $x->raw, $y->raw, $A->raw),0);
 my @got = $A->as_list_row(0);
 map { is($got[$_], 0) } (0..2);
 @got = $A->as_list_row(1);
 map { is($got[$_], ($_+1)*2) } (0..2);
 @got = $A->as_list_row(2);
 map { is($got[$_], ($_+1)*4) } (0..2); 
}

sub GSL_BLAS_ZGERU : Tests {
 my $x = gsl_vector_complex_alloc(2);
 my $y = gsl_vector_complex_alloc(2);
 my $A = gsl_matrix_complex_alloc(2,2);
 my $alpha = gsl_complex_rect(2,2);
 gsl_vector_complex_set($x, 0, $alpha);
 $alpha = gsl_complex_rect(1,2);
 gsl_vector_complex_set($x, 1, $alpha);
 gsl_vector_complex_set($y, 0, $alpha);
 $alpha = gsl_complex_rect(3,2);
 gsl_vector_complex_set($y, 1, $alpha);
 $alpha = gsl_complex_rect(0,0);
 for (my $line=0; $line<2; $line++) {
 map { gsl_matrix_complex_set($A, $line, $_, $alpha) } (0..1); }
 $alpha = gsl_complex_rect(1,0);
 is(gsl_blas_zgeru($alpha, $x, $y, $A),0);
 
 $alpha= gsl_matrix_complex_get($A, 0,0);
 ok_similar([gsl_parts($alpha)], [-2, 6]);
 $alpha= gsl_matrix_complex_get($A, 1,0);
 ok_similar([gsl_parts($alpha)], [-3, 4]);
 $alpha= gsl_matrix_complex_get($A, 1,0);
 ok_similar([gsl_parts($alpha)], [-3, 4]);
 $alpha= gsl_matrix_complex_get($A, 0,1); 
 ok_similar([gsl_parts($alpha)], [2, 10]);
 $alpha= gsl_matrix_complex_get($A, 1,1); 
 ok_similar([gsl_parts($alpha)], [-1, 8]);
}

sub GSL_BLAS_DGEMV : Tests {
 my $x = Math::GSL::Vector->new([1,2,3]);
 my $y = Math::GSL::Vector->new([0,1,2]);
 my $A = Math::GSL::Matrix->new(3,3);
 gsl_matrix_set_identity($A->raw);
 is(gsl_blas_dgemv($CblasNoTrans, 2, $A->raw, $x->raw,2, $y->raw),0);
 my @got = $y->as_list;
 is($got[0], 2);
 is($got[1], 6);
 is($got[2], 10);
}

sub GSL_BLAS_DTRMV : Tests {
 local $TODO = "The function seems to only multiplicates by the diagonal of the matrix, is it normal?";
 my $x = Math::GSL::Vector->new([1,2,3]);
 my $A = Math::GSL::Matrix->new(3,3);
 gsl_matrix_set($A->raw, 0,0,3);
 gsl_matrix_set($A->raw, 1,1,3);
 gsl_matrix_set($A->raw, 2,2,3);
 gsl_matrix_set($A->raw, 0,1,2);
 gsl_matrix_set($A->raw, 0,2,3);
 gsl_matrix_set($A->raw, 1,2,4);
 is(gsl_blas_dtrmv($CblasLower, $CblasNoTrans, $CblasNonUnit, $A->raw, $x->raw),0);
 my @got = $x->as_list;
 is($got[0], 3);
 is($got[1], 6);
 is($got[2], 9);
}

sub GSL_BLAS_DTRSV : Tests {
 local $TODO = "I don't understand what the result is supposed to be...";
 my $x = Math::GSL::Vector->new([40,40,40,40]);
 my $A = Math::GSL::Matrix->new(4,4);
 map { gsl_matrix_set($A->raw, $_,0,$_+1); } (0..3);
 map { gsl_matrix_set($A->raw, $_,1,$_+2); } (0..2);
 gsl_matrix_set($A->raw, 3,1,1);
 map { gsl_matrix_set($A->raw, $_,2,$_+3); } (0..1);
 map { gsl_matrix_set($A->raw, $_,2,$_-1); } (2..3);
 map { gsl_matrix_set($A->raw, $_,3,$_); } (1..3);
 gsl_matrix_set($A->raw, 0,3,4);
 is(gsl_blas_dtrsv($CblasLower, $CblasNoTrans, $CblasNonUnit, $A->raw, $x->raw),0);
 my @got = $A->as_list_row(0);
}

sub GSL_BLAS_DROTG : Tests {
 local $TODO = "need a typemap for outputting arrays";
 my $a = [1];
 my $b = [2];
 my $c = [0];
 my $s = [0];
 is(gsl_blas_drotg($a, $b, $c, $s), 0);
 is($c, 1/sqrt(5));
 is($s, 2/sqrt(5));
}

sub GSL_BLAS_DSYMV : Tests {
 my $x = Math::GSL::Vector->new([1,2,3]);
 my $y = Math::GSL::Vector->new([3,2,1]);
 my $A = Math::GSL::Matrix->new(3,3);
 map { gsl_matrix_set($A->raw, $_,0,$_+1); } (0..2);
 gsl_matrix_set($A->raw, 0, 1, 2); 
 gsl_matrix_set($A->raw, 1, 1, 1); 
 gsl_matrix_set($A->raw, 2, 1, 2); 
 gsl_matrix_set($A->raw, 0, 2, 3); 
 gsl_matrix_set($A->raw, 1, 2, 2); 
 gsl_matrix_set($A->raw, 2, 2, 1); 
 is(gsl_blas_dsymv($CblasLower, 2, $A->raw, $x->raw, 3, $y->raw),0);
 is(gsl_vector_get($y->raw, 0), 37);
 is(gsl_vector_get($y->raw, 1), 26);
 is(gsl_vector_get($y->raw, 2), 23);
}
1;
