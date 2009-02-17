package Math::GSL::MatrixComplex::Test;
use Test::More tests => 38;
use base q{Test::Class};
use strict;

use Math::GSL                qw/:all/;
use Math::GSL::Test          qw/:all/;
use Math::GSL::Errno         qw/:all/;
use Math::GSL::MatrixComplex qw/:all/;
use Math::GSL::Complex       qw/:all/;
use Math::Complex;
use Test::Exception;
use Data::Dumper;

BEGIN{ gsl_set_error_handler_off(); }

sub make_fixture : Test(setup) {
    my $self = shift;
}

sub teardown : Test(teardown) {
    unlink 'matrix' if -f 'matrix';
}

sub GSL_MATRIX_COMPLEX_NEW: Tests(3) {
    my $u = Math::GSL::MatrixComplex->new(10,20);
    isa_ok($u, 'Math::GSL::MatrixComplex');
    ok( $u->rows ==  10, 'rows');
    ok( $u->cols ==  20, 'cols');
}

sub GSL_MATRIX_COMPLEX_SET : Tests(2) {
    my $u = Math::GSL::MatrixComplex->new(2,2);
    gsl_matrix_complex_set($u->raw, 0, 0, Math::GSL::Complex::gsl_complex_rect(3,5) );
   ok_similar( [ map { Re $_ } $u->row(0)->as_list ], [ 3, 0 ] );
   ok_similar( [ map { Im $_ } $u->row(0)->as_list ], [ 5, 0 ] );
}

sub GSL_MATRIX_COMPLEX_COL : Tests(3) {
    my $u = Math::GSL::MatrixComplex->new(2,2);
    isa_ok( $u->col(0) , 'Math::GSL::MatrixComplex');
    cmp_ok( $u->col(0)->cols, '==', 1 );
    cmp_ok( $u->col(0)->rows, '==', 2 );
}

sub GSL_MATRIX_COMPLEX_ROW : Tests(3) {
    my $u = Math::GSL::MatrixComplex->new(2,2);
    isa_ok( $u->row(0) , 'Math::GSL::MatrixComplex');
    cmp_ok( $u->row(0)->cols, '==', 2 );
    cmp_ok( $u->row(0)->rows, '==', 1 );
}
sub GSL_MATRIX_COMPLEX_SET_OO : Tests(2) {
    my $u = Math::GSL::MatrixComplex->new(2,2);
    $u->set_row(0, [ 1+7*i, 2*i ] )
      ->set_row(1, [ 3*i, -4  ] );
    ok_similar( [ map { Re $_ } $u->as_list ], [ 1, 0, 0, -4 ] );
    ok_similar( [ map { Im $_ } $u->as_list ], [ 7, 2, 3, 0  ] );
}

sub HERMITIAN : Tests(1) {
    my $matrix    = gsl_matrix_complex_alloc(2,2);
    my $transpose = gsl_matrix_complex_alloc(2,2);
    gsl_matrix_complex_set($matrix, 0, 0, gsl_complex_rect(3,0));
    gsl_matrix_complex_set($matrix, 0, 1, gsl_complex_rect(2,1));
    gsl_matrix_complex_set($matrix, 1, 0, gsl_complex_rect(2,-1));
    gsl_matrix_complex_set($matrix, 1, 1, gsl_complex_rect(1,0));
    gsl_matrix_complex_memcpy($transpose, $matrix);
    gsl_matrix_complex_transpose($transpose);

    for my $row (0..1) {
        map { gsl_matrix_complex_set($transpose, $row, $_, gsl_complex_conjugate(gsl_matrix_complex_get($transpose, $row, $_))) } (0..1);
    }

    my $upper_right = gsl_matrix_complex_get($matrix, 0, 1 );
    my $lower_left  = gsl_matrix_complex_get($matrix, 1, 0 );

    ok( gsl_complex_eq( gsl_complex_conjugate($upper_right), $lower_left ), 'hermitian' );
}
sub MULTIPLICATION_OVERLOAD : Tests(2) {
    my $u = Math::GSL::MatrixComplex->new(2,2);
    $u->set_row(0, [ 1+2*i, 2*i ] )
      ->set_row(1, [ 3*i, -4  ] );
    my $t = Math::GSL::MatrixComplex->new(2,2);
    $t->set_row(0, [ 1+4*i, 1 ] )
      ->set_row(1, [ 3*i, -4  ] );
    my $result = $u * $t;
    ok_similar( [ map { Re $_ } $result->as_list ], [ -13, 1, -12, 16 ] );
    ok_similar( [ map { Im $_ } $result->as_list ], [ 6, -6, -9, 3 ] );
}

sub MATRIX_IS_SQUARE : Tests(2) {
    my $A = Math::GSL::MatrixComplex->new(2,2);
    ok( $A->is_square, 'is_square true for 2x2' );
    my $B = Math::GSL::MatrixComplex->new(2,3);
    ok( ! $B->is_square, 'is_square false for 2x3' );
}

sub MATRIX_DETERMINANT : Tests(3) {
    my $A = Math::GSL::MatrixComplex->new(2,2)
                             ->set_row(0, [1,3] )
                             ->set_row(1, [4, 2] );
    isa_ok( $A->det, 'Math::Complex');
    ok_similar( [ $A->det   ], [ -10 ], '->det() 2x2');
    ok_similar( [ $A->lndet ], [ log 10 ], '->lndet() 2x2');

}

sub MATRIX_ZERO : Tests(2) {
    my $A = Math::GSL::MatrixComplex->new(2,2)
                             ->set_row(0, [1, 3] )
                             ->set_row(1, [4, 2] );
    isa_ok($A->zero, 'Math::GSL::MatrixComplex');
    ok_similar( [ $A->zero->as_list ], [ 0, 0, 0, 0 ] );
}

sub MATRIX_IDENTITY : Tests(7) {
    my $A = Math::GSL::MatrixComplex->new(2,2)->identity;
    isa_ok($A, 'Math::GSL::MatrixComplex');
    ok_similar([ $A->as_list ], [ 1, 0, 0, 1 ] );
    ok_similar([ $A->inverse->as_list ], [ 1, 0, 0, 1 ] );
    ok_similar([ Re $A->det     ] ,[ 1 ] );
    ok_similar([ Im $A->det     ] ,[ 0 ] );

    ok_similar([ map { Re $_ } $A->eigenvalues ], [ 1, 1 ], 'identity eigs=1' );
    ok_similar([ map { Im $_ } $A->eigenvalues ], [ 0, 0 ], 'identity eigs=1' );
}

sub MATRIX_IS_HERMITIAN : Tests {
    my $A = Math::GSL::MatrixComplex->new(2,2)
                             ->set_row(0, [1, 3] )
                             ->set_row(1, [4, 2] );
    ok( $A->is_hermitian == 0, 'non hermitian matrix ');
    my $B = Math::GSL::MatrixComplex->new(2,3)
                             ->set_row(0, [1, 3, 4] )
                             ->set_row(1, [4, 2, 8] );
    ok( $B->is_hermitian == 0, 'non square matrix ');
    my $C = Math::GSL::MatrixComplex->new(2,2)
                             ->set_row(0, [3, 2+1*i] )
                             ->set_row(1, [2-1*i, 1] );
    ok( $C->is_hermitian == 1, 'hermitian matrix ');
}

sub MATRIX_INVERSE : Tests(3) {
    my $A = Math::GSL::MatrixComplex->new(2,2)
                             ->set_row(0, [1, 3] )
                             ->set_row(1, [4, 2] );
    my $Ainv = $A->inverse;
    isa_ok( $Ainv, 'Math::GSL::MatrixComplex' );
    ok_similar([ $Ainv->as_list ] , [ map { -$_/10 } ( 2, -3, -4, 1 ) ] );
    my $B = Math::GSL::MatrixComplex->new(2,3)
                             ->set_row(0, [1, 3, 5] )
                             ->set_row(1, [2, 4, 6] );
    dies_ok( sub { $B->inverse } , 'inverse of non square matrix dies' );
}

sub OVERLOAD_EQUAL : Tests(2) {
    my $A = Math::GSL::MatrixComplex->new(2,2)
                             ->set_row(0, [1+2*i, 3] )
                             ->set_row(1, [4, 2] );
    my $B = $A->copy;
    ok ( $A == $B, 'should be equal');
    $B->set_row(0, [1,2]);
    ok ( $A != $B, 'should not be equal');
}

Test::Class->runtests;
