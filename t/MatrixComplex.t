package Math::GSL::MatrixComplex::Test;
use base q{Test::Class};
use Test::More tests => 5;
use Math::GSL                qw/:all/;
use Math::GSL::Test          qw/:all/;
use Math::GSL::Errno         qw/:all/;
use Math::GSL::MatrixComplex qw/:all/;
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

sub GSL_MATRIX_COMPLEX_SET : Tests(2) {
    my $u = Math::GSL::MatrixComplex->new(2,2);
    $u->set_row(0, [ 1+7*i, 2*i ] )
      ->set_row(1, [ 3*i, -4  ] );
    ok_similar( [ map { Re $_ } $u->as_list ], [ 1, 0, 0, -4 ] );
    ok_similar( [ map { Im $_ } $u->as_list ], [ 7, 2, 3, 0  ] );
}

Test::Class->runtests;
