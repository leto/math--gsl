package Math::GSL::Multimin::Test;
use base q{Test::Class};
use Test::More tests => 1;
use Math::GSL           qw/:all/;
use Math::GSL::Multimin qw/:all/;
use Math::GSL::Test     qw/:all/;
use Math::GSL::Errno    qw/:all/;
use Data::Dumper;
use strict;

BEGIN { gsl_set_error_handler_off(); }

sub make_fixture : Test(setup) {
}

sub teardown : Test(teardown) {
}

sub GSL_MULTIMIN : Tests {
    ok(1);
}

Test::Class->runtests;
