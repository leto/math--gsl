package Math::GSL::MatrixComplex::Test;
use Math::GSL::Test qw/:all/;
use base q{Test::Class};
use Test::More;
use Math::GSL::Matrix qw/:all/;
use Math::GSL::VectorComplex qw/:all/;
use Math::GSL::Errno qw/:all/;
use Math::GSL qw/:all/;
use Data::Dumper;
use strict;

BEGIN{ gsl_set_error_handler_off(); }

sub make_fixture : Test(setup) {
    my $self = shift;
}

sub teardown : Test(teardown) {
    unlink 'matrix' if -f 'matrix';
}

sub GSL_MATRIX_COMPLEX_YO: Tests {
    local $TODO = 'make it work';
    ok(0);
}
Test::Class->runtests;
