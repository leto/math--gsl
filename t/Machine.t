use Test::More tests=>2;
use Math::GSL;
use Math::GSL::Machine qw/:all/;
use Data::Dumper;
use strict;
use warnings;

ok( defined $GSL_MACH_EPS, 'GSL_MACH_EPS');
print "Machine Epsilon=$GSL_MACH_EPS\n" if $ENV{DEBUG};
ok( defined $GSL_DBL_MIN,  'GSL_DBL_MIN' );
print "Machine Double Min=$GSL_DBL_MIN\n" if $ENV{DEBUG};

