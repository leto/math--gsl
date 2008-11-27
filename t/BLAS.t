package Math::GSL::BLAS::Test;
use base q{Test::Class};
use Test::More tests => 99;
use Math::GSL::BLAS    qw/:all/;
use Math::GSL::Vector  qw/:all/;
use Math::GSL::Complex qw/:all/;
use Math::GSL::Matrix  qw/:all/;
use Math::GSL::CBLAS   qw/:all/;
use Math::GSL          qw/:all/;
use Math::GSL::Test    qw/:all/;
use Math::GSL::Errno   qw/:all/;
use Data::Dumper;
use strict;

BEGIN { gsl_set_error_handler_off(); }

sub make_fixture : Test(setup) {
}

sub teardown : Test(teardown) {
}

sub GSL_BLAS_DDOT : Tests {
    my $vec1 = Math::GSL::Vector->new([1,2,3,4,5]);
    my $vec2 = Math::GSL::Vector->new([5,4,3,2,1]);
    my ($x, $result) = gsl_blas_ddot($vec1->raw, $vec2->raw);
    ok_status($x);
    is_similar($result,35);
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
    ok_status(gsl_blas_zdotu($vec1, $vec2, $c));
    is_similar([ gsl_parts($c) ], [3,6]); 
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
    ok_status(gsl_blas_zdotc($vec1, $vec2, $c));
    is_similar([gsl_parts($c)], [7,0]); 
}

sub GSL_BLAS_DNRM2 : Tests {
    my $vec = Math::GSL::Vector->new([3,4]);
    is_similar(gsl_blas_dnrm2($vec->raw), 5);
}
  

sub GSL_BLAS_DZNRM2 : Tests {
    my $vec = gsl_vector_complex_alloc(2);
    my $c = gsl_complex_rect(2,1);
    gsl_vector_complex_set($vec,0,$c); 
    $c = gsl_complex_rect(1,1);
    gsl_vector_complex_set($vec,1,$c); 
    is_similar([gsl_blas_dznrm2($vec)], [sqrt(7)]);
}

sub GSL_BLAS_DASUM : Tests {
    my $vec = Math::GSL::Vector->new([2,-3,4]);
    is_similar(gsl_blas_dasum($vec->raw), 9);
}

sub GSL_BLAS_DZASUM : Tests {
    my $vec = gsl_vector_complex_alloc(2);
    my $c = gsl_complex_rect(2,1);
    gsl_vector_complex_set($vec,0,$c); 
    $c = gsl_complex_rect(1,1);
    gsl_vector_complex_set($vec,1,$c); 
    is_similar(gsl_blas_dzasum($vec), 5);
}

sub GSL_BLAS_DSWAP : Tests {
    my $vec1 = Math::GSL::Vector->new([0,1,2]);
    my $vec2 = Math::GSL::Vector->new([2,1,0]);
    gsl_blas_dswap($vec1->raw, $vec2->raw);
    ok_similar( [0 .. 2], [ $vec2->as_list ] );
    ok_similar( [2, 1,0], [ $vec1->as_list ] );
}

sub GSL_BLAS_ZSWAP : Tests { 
    my $vec1 = gsl_vector_complex_alloc(2);
    my $vec2 = gsl_vector_complex_alloc(2);
    my $c = gsl_complex_rect(5,4);
    gsl_vector_complex_set($vec1,0,$c); 
    $c = gsl_complex_rect(2,2);
    gsl_vector_complex_set($vec1,1, $c);
    $c = gsl_complex_rect(3,3);
    gsl_vector_complex_set($vec2,0, $c);
    $c = gsl_complex_rect(1,1); 
    gsl_vector_complex_set($vec2,1, $c);

    ok_status(gsl_blas_zswap($vec1, $vec2));
    $c = gsl_vector_complex_get($vec1,0);
    local $TODO = "Problem with the output of gsl_vector_complex_get";
    ok( defined $c,"gsl_vector_complex_get");  

    # goes boom
    #is_similar( [gsl_parts($c) ], [ 3,3 ] );
}

sub GSL_BLAS_DCOPY : Tests {
    my $vec1 = Math::GSL::Vector->new([0,1,2]);
    my $vec2 = Math::GSL::Vector->new(3);
    ok_status(gsl_blas_dcopy($vec1->raw, $vec2->raw));
    ok_similar( [ $vec2->as_list ], [ 0 .. 2] );
}

sub GSL_BLAS_DAXPY : Tests { 
    my $vec1 = Math::GSL::Vector->new([0,1,2]);
    my $vec2 = Math::GSL::Vector->new([2,3,4]);
    ok_status(gsl_blas_daxpy(2,$vec1->raw, $vec2->raw));
    is_similar( [ $vec2->as_list ], [ 2, 5, 8 ] );
}

sub GSL_BLAS_DSCAL : Tests {
    my $vec = Math::GSL::Vector->new([0,1,2]);
    gsl_blas_dscal(4, $vec->raw);
    is_similar( [ $vec->as_list ], [0,4,8] );
}

sub GSL_BLAS_DROT : Tests {
    my $x = Math::GSL::Vector->new([1,2,3]);
    my $y = Math::GSL::Vector->new([0,1,2]);
    ok_status(gsl_blas_drot($x->raw,$y->raw,2,3));
    ok_similar( [$x->as_list], [ 2,7,12], 'first vector');
    ok_similar( [$y->as_list], [-3,-4,-5], 'second vector');
}

sub GSL_BLAS_DGER : Tests { 
 my $x = Math::GSL::Vector->new([1,2,3]);
 my $y = Math::GSL::Vector->new([0,1,2]);
 my $A = Math::GSL::Matrix->new(3,3); 
 gsl_matrix_set_zero($A->raw);
 ok_status(gsl_blas_dger(2, $x->raw, $y->raw, $A->raw));
 ok_similar([$A->row(0)->as_list], [0,2,4]);
 ok_similar([$A->row(1)->as_list], [0,4,8]);
 ok_similar([$A->row(2)->as_list], [0,6,12]);
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
    ok_status(gsl_blas_zgeru($alpha, $x, $y, $A));
    
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
    ok_status(gsl_blas_dgemv($CblasNoTrans, 2, $A->raw, $x->raw,2, $y->raw));
    ok_similar( [ $y->as_list ], [  2, 6, 10 ] );
}

sub GSL_BLAS_DTRMV : Tests {
    my $x = Math::GSL::Vector->new([1,2,3]);
    my $A = Math::GSL::Matrix->new(3,3);
    gsl_matrix_set($A->raw, 0,0,3);
    gsl_matrix_set($A->raw, 1,1,3);
    gsl_matrix_set($A->raw, 2,2,3);
    gsl_matrix_set($A->raw, 0,1,2);
    gsl_matrix_set($A->raw, 0,2,3);
    gsl_matrix_set($A->raw, 1,2,4);
    ok_status(gsl_blas_dtrmv($CblasLower, $CblasNoTrans, $CblasNonUnit, $A->raw, $x->raw));
    is_similar( [ $x->as_list ], [ 3, 6, 9 ] );
}

sub GSL_BLAS_DTRSV : Tests {
    my $x = Math::GSL::Vector->new([40,40,40,40]);
    my $A = Math::GSL::Matrix->new(4,4);
    map { gsl_matrix_set($A->raw, $_,0,$_+1); } (0..3);
    map { gsl_matrix_set($A->raw, $_,1,$_+2); } (0..2);
    gsl_matrix_set($A->raw, 3,1,1);
    map { gsl_matrix_set($A->raw, $_,2,$_+3); } (0..1);
    map { gsl_matrix_set($A->raw, $_,2,$_-1); } (2..3);
    map { gsl_matrix_set($A->raw, $_,3,$_); } (1..3);
    gsl_matrix_set($A->raw, 0,3,4);
    ok_status(gsl_blas_dtrsv($CblasLower, $CblasNoTrans, $CblasNonUnit, $A->raw, $x->raw));
    ok_similar([$x->as_list], [40,-40/3,-80/3,-160/9]);
}

sub GSL_BLAS_DROTG : Tests {
    my $a = [1];
    my $b = [2];

    my ($status, $c, $s) = gsl_blas_drotg($a, $b);
    ok_similar( [$c, $s ], [ 1/sqrt(5) , 2/sqrt(5)  ] );
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
    ok_status(gsl_blas_dsymv($CblasLower, 2, $A->raw, $x->raw, 3, $y->raw));
    ok_similar( [$y->as_list], [37,26,23]);
}

sub GSL_BLAS_DSYR : Tests {
    my $x = Math::GSL::Vector->new([1,2,3]);
    my $A = Math::GSL::Matrix->new(3,3);
    gsl_matrix_set_zero($A->raw);

    ok_status(gsl_blas_dsyr($CblasLower, 2, $x->raw, $A->raw));
    ok_similar([ $A->row(0)->as_list ], [2,0,0]);
    ok_similar([ $A->row(1)->as_list ], [4,8,0]);
    ok_similar([ $A->row(2)->as_list ], [6,12,18]);
}

sub GSL_BLAS_ZHER : Tests {
    my $x = gsl_vector_complex_alloc(2);
    my $A = gsl_matrix_complex_alloc(2,2);
    my $alpha = gsl_complex_rect(0,0);

    for my $line (0 .. 1) {
        map { gsl_matrix_complex_set($A, $_, $line, $alpha) } (0..1); 
    }  
    $alpha = gsl_complex_rect(1,2);
    gsl_vector_complex_set($x, 0, $alpha);
    $alpha = gsl_complex_rect(2,2);
    gsl_vector_complex_set($x, 1, $alpha);
    $alpha = gsl_complex_rect(1,1);
    ok_status(gsl_blas_zher($CblasLower, 2, $x, $A));

    ok_similar([ gsl_parts(gsl_matrix_complex_get($A,0,0)) ], [10, 0 ]);
    ok_similar([ gsl_parts(gsl_matrix_complex_get($A,1,0)) ], [12, -4]);
    ok_similar([ gsl_parts(gsl_matrix_complex_get($A,1,1)) ], [16, 0 ]);
    ok_similar([ gsl_parts(gsl_matrix_complex_get($A,0,1)) ], [0 , 0 ]);
}

sub GSL_BLAS_DSYR2 : Tests {
    my $x = Math::GSL::Vector->new([1,2,3]);
    my $y = Math::GSL::Vector->new([3,2,1]);
    my $A = Math::GSL::Matrix->new(3,3);
    gsl_matrix_set_zero($A->raw);
    map { gsl_matrix_set($A->raw, $_, 0, ($_+1)**2) } (0..2);
    map { gsl_matrix_set($A->raw, $_, 1, ($_+1)**2) } (1..2);
    gsl_matrix_set($A->raw, 0, 1, (1)**2);
    gsl_matrix_set($A->raw, 0, 1, 4);
    gsl_matrix_set($A->raw, 0, 2, 9);
    gsl_matrix_set($A->raw, 1, 2, 9);
    gsl_matrix_set($A->raw, 2, 2, 3);
    ok_status(gsl_blas_dsyr2($CblasLower, 2, $x->raw, $y->raw, $A->raw));
    my @got = $A->row(0)->as_list;
    ok_similar([@got], [13, 4, 9]);
    @got = $A->row(1)->as_list;
    ok_similar([@got], [20, 20, 9]);
    @got = $A->row(2)->as_list;
    ok_similar([@got], [29, 25, 15]);
}

sub GSL_BLAS_DGEMM : Tests {
    my $A = Math::GSL::Matrix->new(2,2);
    gsl_matrix_set($A->raw, 0,0,1);
    gsl_matrix_set($A->raw, 1,0,3);
    gsl_matrix_set($A->raw, 0,1,4);
    gsl_matrix_set($A->raw, 1,1,2);
    my $B = Math::GSL::Matrix->new(2,2);
    gsl_matrix_set($B->raw, 0,0,2);
    gsl_matrix_set($B->raw, 1,0,5);
    gsl_matrix_set($B->raw, 0,1,1);
    gsl_matrix_set($B->raw, 1,1,3);
    my $C = Math::GSL::Matrix->new(2,2);
    gsl_matrix_set_zero($C->raw);
    ok_status(gsl_blas_dgemm($CblasNoTrans, $CblasNoTrans, 1, $A->raw, $B->raw, 1, $C->raw));
    my @got = $C->row(0)->as_list;
    ok_similar([@got], [22, 13]);
    @got = $C->row(1)->as_list;
    ok_similar([@got], [16, 9]);
}

sub GSL_BLAS_DSYMM : Tests {
    my $A = Math::GSL::Matrix->new(2,2);
    gsl_matrix_set($A->raw, 0,0,1);
    gsl_matrix_set($A->raw, 1,0,3);
    gsl_matrix_set($A->raw, 0,1,4);
    gsl_matrix_set($A->raw, 1,1,2);
    my $B = Math::GSL::Matrix->new(2,2);
    gsl_matrix_set($B->raw, 0,0,2);
    gsl_matrix_set($B->raw, 1,0,5);
    gsl_matrix_set($B->raw, 0,1,1);
    gsl_matrix_set($B->raw, 1,1,3);
    my $C = Math::GSL::Matrix->new(2,2);
    gsl_matrix_set_zero($C->raw);
    ok_status(gsl_blas_dsymm($CblasLeft, $CblasUpper, 1, $A->raw, $B->raw, 1, $C->raw));
    my @got = $C->row(0)->as_list;
    ok_similar([@got], [22, 13]);
    @got = $C->row(1)->as_list;
    ok_similar([@got], [18, 10]);
}

sub GSL_BLAS_ZGEMM : Tests {
    my $A = gsl_matrix_complex_alloc(2,2);
    my $alpha = gsl_complex_rect(1,2);
    gsl_matrix_complex_set($A, 0,0,$alpha);
    $alpha = gsl_complex_rect(3,1);
    gsl_matrix_complex_set($A, 0,1,$alpha);
    $alpha = gsl_complex_rect(2,2);
    gsl_matrix_complex_set($A, 1,0,$alpha);
    $alpha = gsl_complex_rect(0,2);
    gsl_matrix_complex_set($A, 1,1,$alpha);

    my $B = gsl_matrix_complex_alloc(2,2);
    $alpha = gsl_complex_rect(1,1);
    gsl_matrix_complex_set($B, 0,0,$alpha);
    $alpha = gsl_complex_rect(2,2);
    gsl_matrix_complex_set($B, 0,1,$alpha);
    $alpha = gsl_complex_rect(1,2);
    gsl_matrix_complex_set($B, 1,0,$alpha);
    $alpha = gsl_complex_rect(1,3);
    gsl_matrix_complex_set($B, 1,1,$alpha);

    my $C = gsl_matrix_complex_alloc(2,2);
    $alpha = gsl_complex_rect(0,0);
    map { gsl_matrix_complex_set($C, 0, $_, $alpha) } (0..1);
    map { gsl_matrix_complex_set($C, 1, $_, $alpha) } (0..1);

    $alpha = gsl_complex_rect(2,0);
    my $beta = gsl_complex_rect(1,0);
    ok_status(gsl_blas_zgemm($CblasNoTrans, $CblasNoTrans, $alpha, $A, $B, $beta, $C));
    ok_similar([ gsl_parts(gsl_matrix_complex_get($C, 0, 0))], [0,20]);
    ok_similar([ gsl_parts(gsl_matrix_complex_get($C, 0, 1))], [-4,32]);
    ok_similar([ gsl_parts(gsl_matrix_complex_get($C, 1, 0))], [-8,12]);
    ok_similar([ gsl_parts(gsl_matrix_complex_get($C, 1, 1))], [-12,20]);
}

sub GSL_BLAS_ZSYMM : Tests {
    my $A = gsl_matrix_complex_alloc(2,2);
    my $alpha = gsl_complex_rect(1,2);
    gsl_matrix_complex_set($A, 0,0,$alpha);
    $alpha = gsl_complex_rect(3,1);
    gsl_matrix_complex_set($A, 0,1,$alpha);
    $alpha = gsl_complex_rect(3,1);
    gsl_matrix_complex_set($A, 1,0,$alpha);
    $alpha = gsl_complex_rect(0,2);
    gsl_matrix_complex_set($A, 1,1,$alpha);

    my $B = gsl_matrix_complex_alloc(2,2);
    $alpha = gsl_complex_rect(1,1);
    gsl_matrix_complex_set($B, 0,0,$alpha);
    $alpha = gsl_complex_rect(2,2);
    gsl_matrix_complex_set($B, 0,1,$alpha);
    $alpha = gsl_complex_rect(2,2);
    gsl_matrix_complex_set($B, 1,0,$alpha);
    $alpha = gsl_complex_rect(1,3);
    gsl_matrix_complex_set($B, 1,1,$alpha);

    my $C = gsl_matrix_complex_alloc(2,2);
    $alpha = gsl_complex_rect(0,0);
    map { gsl_matrix_complex_set($C, 0, $_, $alpha) } (0..1);
    map { gsl_matrix_complex_set($C, 1, $_, $alpha) } (0..1);
    
    $alpha = gsl_complex_rect(2,0);
    my $beta = gsl_complex_rect(1,0);
    ok_status(gsl_blas_zsymm($CblasLeft, $CblasUpper, $alpha, $A, $B, $beta, $C));
    ok_similar([ gsl_parts(gsl_matrix_complex_get($C, 0, 0))], [6,22]);
    ok_similar([ gsl_parts(gsl_matrix_complex_get($C, 0, 1))], [-4,32]);
    ok_similar([ gsl_parts(gsl_matrix_complex_get($C, 1, 0))], [-4,16]);
    ok_similar([ gsl_parts(gsl_matrix_complex_get($C, 1, 1))], [-4,20]);
}
sub GSL_BLAS_ZHEMM : Tests {
    my $A = gsl_matrix_complex_alloc(2,2);
    my $alpha = gsl_complex_rect(3,0);
    gsl_matrix_complex_set($A, 0,0,$alpha);
    $alpha = gsl_complex_rect(2,1);
    gsl_matrix_complex_set($A, 0,1,$alpha);
    $alpha = gsl_complex_rect(2,-1);
    gsl_matrix_complex_set($A, 1,0,$alpha);
    $alpha = gsl_complex_rect(1,0);
    gsl_matrix_complex_set($A, 1,1,$alpha);

    my $B = gsl_matrix_complex_alloc(2,2);
    $alpha = gsl_complex_rect(1,0);
    gsl_matrix_complex_set($B, 0,0,$alpha);
    $alpha = gsl_complex_rect(2,2);
    gsl_matrix_complex_set($B, 0,1,$alpha);
    $alpha = gsl_complex_rect(2,-2);
    gsl_matrix_complex_set($B, 1,0,$alpha);
    $alpha = gsl_complex_rect(2,0);
    gsl_matrix_complex_set($B, 1,1,$alpha);

    my $C = gsl_matrix_complex_alloc(2,2);
    $alpha = gsl_complex_rect(0,0);
    map { gsl_matrix_complex_set($C, 0, $_, $alpha) } (0..1);
    map { gsl_matrix_complex_set($C, 1, $_, $alpha) } (0..1);
    
    $alpha = gsl_complex_rect(2,0);
    my $beta = gsl_complex_rect(1,0);
    ok_status(gsl_blas_zhemm($CblasLeft, $CblasUpper, $alpha, $A, $B, $beta, $C));
    ok_similar([ gsl_parts(gsl_matrix_complex_get($C, 0, 0))], [18,-4]);
    ok_similar([ gsl_parts(gsl_matrix_complex_get($C, 0, 1))], [20,16]);
    ok_similar([ gsl_parts(gsl_matrix_complex_get($C, 1, 0))], [8,-6]);
    ok_similar([ gsl_parts(gsl_matrix_complex_get($C, 1, 1))], [16,4]);
}

sub GSL_BLAS_DTRMM : Tests {
    my $A = Math::GSL::Matrix->new(2,2);
    gsl_matrix_set($A->raw, 0,0,1);
    gsl_matrix_set($A->raw, 1,0,3);
    gsl_matrix_set($A->raw, 0,1,4);
    gsl_matrix_set($A->raw, 1,1,2);
    my $B = Math::GSL::Matrix->new(2,2);
    gsl_matrix_set($B->raw, 0,0,2);
    gsl_matrix_set($B->raw, 1,0,5);
    gsl_matrix_set($B->raw, 0,1,1);
    gsl_matrix_set($B->raw, 1,1,3);
    my $C = Math::GSL::Matrix->new(2,2);
    gsl_matrix_set_zero($C->raw);
    ok_status(gsl_blas_dtrmm($CblasLeft, $CblasUpper, $CblasNoTrans, $CblasUnit, 1, $A->raw, $B->raw));
    my @got = $B->row(0)->as_list;
    ok_similar([@got], [22, 13]);
    @got = $B->row(1)->as_list;
    ok_similar([@got], [5, 3]);
}

sub GSL_BLAS_ZTRMM : Tests {
    my $A = gsl_matrix_complex_alloc(2,2);
    my $alpha = gsl_complex_rect(3,1);
    gsl_matrix_complex_set($A, 0,1,$alpha);

    my $B = gsl_matrix_complex_alloc(2,2);
    $alpha = gsl_complex_rect(1,0);
    gsl_matrix_complex_set($B, 0,0,$alpha);
    $alpha = gsl_complex_rect(2,2);
    gsl_matrix_complex_set($B, 0,1,$alpha);
    $alpha = gsl_complex_rect(1,-2);
    gsl_matrix_complex_set($B, 1,0,$alpha);
    $alpha = gsl_complex_rect(4,2);
    gsl_matrix_complex_set($B, 1,1,$alpha);
    
    $alpha = gsl_complex_rect(1,0);
    ok_status(gsl_blas_ztrmm($CblasLeft, $CblasUpper, $CblasNoTrans, $CblasUnit, $alpha, $A, $B));
    ok_similar([gsl_parts(gsl_matrix_complex_get($B, 0, 0))], [6, -5]);
    ok_similar([gsl_parts(gsl_matrix_complex_get($B, 0, 1))], [12, 12]);
    ok_similar([gsl_parts(gsl_matrix_complex_get($B, 1, 0))], [1, -2]);
    ok_similar([gsl_parts(gsl_matrix_complex_get($B, 1, 1))], [4, 2]);
}

sub GSL_BLAS_DSYRK : Tests {
    my $A = Math::GSL::Matrix->new(2,2);
    gsl_matrix_set($A->raw, 0, 0, 1);
    gsl_matrix_set($A->raw, 0, 1, 4);
    gsl_matrix_set($A->raw, 1, 0, 4);
    gsl_matrix_set($A->raw, 1, 1, 3);
    my $C = Math::GSL::Matrix->new(2,2);
    gsl_matrix_set_zero($C->raw);
    ok_status(gsl_blas_dsyrk ($CblasUpper, $CblasNoTrans, 1, $A->raw, 1, $C->raw));
    ok_similar([$C->row(0)->as_list], [17,16]);
    ok_similar([$C->row(1)->as_list], [0,25]);
}

sub GSL_BLAS_ZSYRK : Tests {
    my $A = gsl_matrix_complex_alloc(2,2);
    my $alpha = gsl_complex_rect(3,1);
    gsl_matrix_complex_set($A, 0,0,$alpha);
    $alpha = gsl_complex_rect(2,1);
    gsl_matrix_complex_set($A, 0,1,$alpha);
    gsl_matrix_complex_set($A, 1,0,$alpha);
    $alpha = gsl_complex_rect(1,1);
    gsl_matrix_complex_set($A, 1,1,$alpha);

    my $C = gsl_matrix_complex_alloc(2,2);
    $alpha = gsl_complex_rect(0,0);
    map { gsl_matrix_complex_set($C, 0,$_,$alpha) } (0..1);
    map { gsl_matrix_complex_set($C, 1,$_,$alpha) } (0..1);
    
    $alpha = gsl_complex_rect(1,0);
    my $beta = gsl_complex_rect(1,0);
    ok_status(gsl_blas_zsyrk($CblasUpper, $CblasNoTrans, $alpha, $A, $beta, $C));
    ok_similar([gsl_parts(gsl_matrix_complex_get($C, 0, 0))], [11, 10]);
    ok_similar([gsl_parts(gsl_matrix_complex_get($C, 0, 1))], [6, 8]);
    ok_similar([gsl_parts(gsl_matrix_complex_get($C, 1, 0))], [0, 0]);
    ok_similar([gsl_parts(gsl_matrix_complex_get($C, 1, 1))], [3, 6]);
}

sub GSL_BLAS_ZHERK : Tests {
    my $A = gsl_matrix_complex_alloc(2,2);
    my $alpha = gsl_complex_rect(3,0);
    gsl_matrix_complex_set($A, 0,0,$alpha);
    $alpha = gsl_complex_rect(2,1);
    gsl_matrix_complex_set($A, 0,1,$alpha);
    $alpha = gsl_complex_rect(2,-1);
    gsl_matrix_complex_set($A, 1,0,$alpha);
    $alpha = gsl_complex_rect(1,0);
    gsl_matrix_complex_set($A, 1,1,$alpha);

    my $C = gsl_matrix_complex_alloc(2,2);
    $alpha = gsl_complex_rect(0,0);
    map { gsl_matrix_complex_set($C, 0,$_,$alpha) } (0..1);
    map { gsl_matrix_complex_set($C, 1,$_,$alpha) } (0..1);

    ok_status(gsl_blas_zherk ($CblasUpper, $CblasNoTrans, 1, $A, 1, $C));
    ok_similar([gsl_parts(gsl_matrix_complex_get($C, 0, 0))], [14, 0]);
    ok_similar([gsl_parts(gsl_matrix_complex_get($C, 0, 1))], [8, 4]);
    ok_similar([gsl_parts(gsl_matrix_complex_get($C, 1, 0))], [0, 0]);
    ok_similar([gsl_parts(gsl_matrix_complex_get($C, 1, 1))], [6, 0]);
}

sub GSL_BLAS_ZHER2K : Tests {
    my $A = gsl_matrix_complex_alloc(2,2);
    my $alpha = gsl_complex_rect(3,0);
    gsl_matrix_complex_set($A, 0,0,$alpha);
    $alpha = gsl_complex_rect(2,1);
    gsl_matrix_complex_set($A, 0,1,$alpha);
    $alpha = gsl_complex_rect(2,-1);
    gsl_matrix_complex_set($A, 1,0,$alpha);
    $alpha = gsl_complex_rect(1,0);
    gsl_matrix_complex_set($A, 1,1,$alpha);

    my $B = gsl_matrix_complex_alloc(2,2);
    $alpha = gsl_complex_rect(6,0);
    gsl_matrix_complex_set($A, 0,0,$alpha);
    $alpha = gsl_complex_rect(3,1);
    gsl_matrix_complex_set($A, 0,1,$alpha);
    $alpha = gsl_complex_rect(3,-1);
    gsl_matrix_complex_set($A, 1,0,$alpha);
    $alpha = gsl_complex_rect(5,0);
    gsl_matrix_complex_set($A, 1,1,$alpha);
    
    my $C = gsl_matrix_complex_alloc(2,2);
    $alpha = gsl_complex_rect(0,0);
    map { gsl_matrix_complex_set($C, 0,$_,$alpha) } (0..1);
    map { gsl_matrix_complex_set($C, 1,$_,$alpha) } (0..1);

    $alpha = gsl_complex_rect(1,0);

    ok_status(gsl_blas_zher2k($CblasUpper, $CblasNoTrans, $alpha, $A, $B, 1, $C));
    ok_similar([gsl_parts(gsl_matrix_complex_get($C, 1, 0))], [0, 0]);
    local $TODO = "These results follow the formula given by the documentation, don't know why it fails";
    ok_similar([gsl_parts(gsl_matrix_complex_get($C, 0, 0))], [50, 0]);
    ok_similar([gsl_parts(gsl_matrix_complex_get($C, 0, 1))], [34, 15]);
    ok_similar([gsl_parts(gsl_matrix_complex_get($C, 1, 1))], [24, 0]);
}

sub GSL_BLAS_DSYR2K : Tests {
    my $A = Math::GSL::Matrix->new(2,2);
    gsl_matrix_set($A->raw, 0, 0, 1);
    gsl_matrix_set($A->raw, 0, 1, 4);
    gsl_matrix_set($A->raw, 1, 0, 4);
    gsl_matrix_set($A->raw, 1, 1, 3);
    my $B = Math::GSL::Matrix->new(2,2);
    gsl_matrix_set($B->raw, 0, 0, 2);
    gsl_matrix_set($B->raw, 0, 1, 5);
    gsl_matrix_set($B->raw, 1, 0, 5);
    gsl_matrix_set($B->raw, 1, 1, 1);
    my $C = Math::GSL::Matrix->new(2,2);
    gsl_matrix_set_zero($C->raw);
    ok_status(gsl_blas_dsyr2k ($CblasUpper, $CblasNoTrans, 1, $A->raw, $B->raw, 1, $C->raw, ));
    ok_similar([$C->row(0)->as_list], [44,32]);
    ok_similar([$C->row(1)->as_list], [0,46]);
}

sub GSL_BLAS_ZSYR2K : Tests {
    my $A = gsl_matrix_complex_alloc(2,2);
    my $alpha = gsl_complex_rect(3,0);
    gsl_matrix_complex_set($A, 0,0,$alpha);
    $alpha = gsl_complex_rect(2,1);
    gsl_matrix_complex_set($A, 0,1,$alpha);
    $alpha = gsl_complex_rect(2,1);
    gsl_matrix_complex_set($A, 1,0,$alpha);
    $alpha = gsl_complex_rect(1,0);
    gsl_matrix_complex_set($A, 1,1,$alpha);

    my $B = gsl_matrix_complex_alloc(2,2);
    $alpha = gsl_complex_rect(6,0);
    gsl_matrix_complex_set($A, 0,0,$alpha);
    $alpha = gsl_complex_rect(3,1);
    gsl_matrix_complex_set($A, 0,1,$alpha);
    $alpha = gsl_complex_rect(3,1);
    gsl_matrix_complex_set($A, 1,0,$alpha);
    $alpha = gsl_complex_rect(5,0);
    gsl_matrix_complex_set($A, 1,1,$alpha);
    
    my $C = gsl_matrix_complex_alloc(2,2);
    $alpha = gsl_complex_rect(0,0);
    map { gsl_matrix_complex_set($C, 0,$_,$alpha) } (0..1);
    map { gsl_matrix_complex_set($C, 1,$_,$alpha) } (0..1);

    $alpha = gsl_complex_rect(1,0);
    my $beta = gsl_complex_rect(1,0);

    ok_status(gsl_blas_zsyr2k($CblasUpper, $CblasNoTrans, $alpha, $A, $B, $beta, $C));
    ok_similar([gsl_parts(gsl_matrix_complex_get($C, 1, 0))], [0, 0]);
    local $TODO = "These results follow the formula given by the documentation, don't know why it fails";
    ok_similar([gsl_parts(gsl_matrix_complex_get($C, 0, 0))], [46, 10]);
    ok_similar([gsl_parts(gsl_matrix_complex_get($C, 0, 1))], [34, 15]);
    ok_similar([gsl_parts(gsl_matrix_complex_get($C, 1, 1))], [24, 4]);
}

Test::Class->runtests;
