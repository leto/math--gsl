package Math::GSL::VectorComplex::Test;
use base q{Test::Class};
use Test::More tests => 7;
use Math::GSL::Test          qw/:all/;
use Math::GSL                qw/:all/;
use Math::GSL::VectorComplex qw/:all/;
use Math::GSL::Complex       qw/:all/;
use Math::GSL::Errno         qw/:all/;
use Math::GSL::Const         qw/:all/;
use Test::Exception;
use Data::Dumper;
use Math::Complex;
use strict;

BEGIN{ gsl_set_error_handler_off(); }

sub make_fixture : Test(setup) {
    my $self = shift;
}

sub teardown : Test(teardown) {
    unlink 'vector' if -f 'vectorcomplex';
}

sub GSL_VECTOR_COMPLEX_NEW : Tests(7) {
    my $u = Math::GSL::VectorComplex->new(10);
    isa_ok($u, 'Math::GSL::VectorComplex');
    ok( $u->length ==  10, 'length');

    my $z = Math::Complex->make(0,2);
    my $v = Math::GSL::VectorComplex->new([ $z, $z ** 2 ] );
    isa_ok($v, 'Math::GSL::VectorComplex');

    my $e0 = gsl_vector_complex_get($v->raw,0);
    ok_similar( gsl_complex_abs($e0), 2, 'first element: new gets abs correct');
    ok_similar( gsl_complex_arg($e0), $M_PI/2, 'first element: new gets arg correct');

    my $e1 = gsl_vector_complex_get($v->raw,1);
    ok_similar( gsl_complex_abs($e1), 4, '2nd element: new get abs correct');
    ok_similar( gsl_complex_arg($e1), $M_PI, '2nd element: new get arg correct');
}

Test::Class->runtests;
