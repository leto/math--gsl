use Test::More tests => 2;
use Math::GSL::Function qw/gsl_max gsl_min/;
use strict;

ok( gsl_max(3,4)==4, 'gsl_max' );
ok( gsl_min(4,3)==3, 'gsl_min' );
