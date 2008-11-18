package Math::GSL::VectorComplex::Test;
use Math::GSL::Test          qw/:all/;
use base q{Test::Class};
use Test::More;
use Math::GSL                qw/:all/;
use Math::GSL::VectorComplex qw/:all/;
use Math::GSL::Complex       qw/:all/;
use Math::GSL::Errno         qw/:all/;
use Data::Dumper;
use Test::Exception;
use strict;

BEGIN{ gsl_set_error_handler_off(); }

sub make_fixture : Test(setup) {
    my $self = shift;
}

sub teardown : Test(teardown) {
    unlink 'vector' if -f 'vectorcomplex';
}

sub GSL_VECTOR_COMPLEX : Tests {
    local $TODO = 'make it work, fool';
    ok(0);
}
Test::Class->runtests;
