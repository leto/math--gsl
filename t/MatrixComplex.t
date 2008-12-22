package Math::GSL::MatrixComplex::Test;
use Test::More tests => 14;
use base q{Test::Class};
use strict;

use Math::GSL                qw/:all/;
use Math::GSL::Test          qw/:all/;
use Math::GSL::Errno         qw/:all/;
use Math::GSL::MatrixComplex qw/:all/;
use Math::GSL::Complex       qw/:all/;
use Math::Complex;
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

Test::Class->runtests;
