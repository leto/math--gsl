package Math::GSL::MatrixComplex::Test;
use base q{Test::Class};
use Test::More tests => 12;
use Math::GSL                qw/:all/;
use Math::GSL::Test          qw/:all/;
use Math::GSL::Errno         qw/:all/;
use Math::GSL::MatrixComplex qw/:all/;
use Math::GSL::Complex       qw/:all/;
use Math::Complex;
use Data::Dumper;
use strict;

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

sub GSL_MATRIX_COMPLEX_SET : Tests(1) {
    my $u = Math::GSL::MatrixComplex->new(2,2);
    gsl_matrix_complex_set($u->raw, 0, 0, Math::GSL::Complex::gsl_complex_rect(3,5) );
    warn Dumper [ $u->as_list ];
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
    local $TODO = qq{set_row with complex numbers goes boom};
    my $u = Math::GSL::MatrixComplex->new(2,2);
    $u->set_row(0, [ 1+7*i, 2*i ] )
      ->set_row(1, [ 3*i, -4  ] );
    ok_similar( [ map { Re $_ } $u->as_list ], [ 1, 0, 0, -4 ] );
    ok_similar( [ map { Im $_ } $u->as_list ], [ 7, 2, 3, 0  ] );
}

Test::Class->runtests;
