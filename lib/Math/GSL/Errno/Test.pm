package Math::GSL::Errno::Test;
use base q{Test::Class};
use Test::More;
use Math::GSL::Errno qw/:all/;
use Math::GSL qw/:all/;
use Data::Dumper;
use strict;

sub make_fixture : Test(setup) {
}

sub teardown : Test(teardown) {
}

sub TEST_STRERROR : Tests {

    ok( gsl_strerror($GSL_SUCCESS) eq 'success', q{gsl_strerror(GSL_SUCCESS) = 'success'} );
    ok( gsl_strerror($GSL_EOF) eq 'end of file', q{gsl_strerror(GSL_EOF) = 'end of file'} );
    ok( gsl_strerror($GSL_CONTINUE) eq 'the iteration has not converged yet');
    ok( gsl_strerror($GSL_EDOM) eq 'input domain error');
    ok( gsl_strerror($GSL_ERANGE) eq 'output range error');
    ok( gsl_strerror($GSL_EFAULT) eq 'invalid pointer');
}

sub TEST_HANDLER_OFF:  Tests {
    my $handler = gsl_set_error_handler_off();
    ok(!$@, 'gsl_set_error_handler_off() turns off error handling');

    local $TODO="gsl_set_error_handler_off() does not return a gsl_error_handler_t";
    isa_ok($handler, 'Math::GSL::Errno' );

}


42;
