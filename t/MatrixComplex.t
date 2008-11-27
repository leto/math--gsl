package Math::GSL::MatrixComplex::Test;
use base q{Test::Class};
use Test::More tests => 3;
use Math::GSL                qw/:all/;
use Math::GSL::Test          qw/:all/;
use Math::GSL::Errno         qw/:all/;
use Math::GSL::MatrixComplex qw/:all/;
use Data::Dumper;
use strict;

BEGIN{ gsl_set_error_handler_off(); }

sub make_fixture : Test(setup) {
    my $self = shift;
}

sub teardown : Test(teardown) {
    unlink 'matrix' if -f 'matrix';
}

sub GSL_MATRIX_COMPLEX_NEW: Tests {
    my $u = Math::GSL::MatrixComplex->new(10,20);
    isa_ok($u, 'Math::GSL::MatrixComplex');
    ok( $u->rows ==  10, 'rows');
    ok( $u->cols ==  20, 'cols');
}

Test::Class->runtests;
