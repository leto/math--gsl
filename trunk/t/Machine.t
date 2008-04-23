use Test::More tests=>2;
use Math::GSL;
use Math::GSL::Machine;
use Data::Dumper;
use strict;
use warnings;

ok( defined $Math::GSL::Machine::GSL_MACH_EPS, 'GSL_MACH_EPS');
ok( defined $Math::GSL::Machine::GSL_DBL_MIN,  'GSL_DBL_MIN' );

