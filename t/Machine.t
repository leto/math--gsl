package Math::GSL::Machine::Test;
use base q{Test::Class};
use Test::More tests=>2;
use Math::GSL          qw/:all/;
use Math::GSL::Machine qw/:all/;
use Math::GSL::Test    qw/:all/;
use Math::GSL::Errno   qw/:all/;
use Data::Dumper;
use strict;
BEGIN { gsl_set_error_handler_off() }

sub GSL_MACHINE_CONST: Tests {
    ok( defined $GSL_MACH_EPS, "GSL_MACH_EPS=$GSL_MACH_EPS" );
    ok( defined $GSL_DBL_MIN,  "GSL_DBL_MIN=$GSL_DBL_MIN" );
}

Test::Class->runtests;
