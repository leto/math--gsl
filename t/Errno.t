use Test::More 'no_plan';
use Math::GSL;
use Math::GSL::Errno qw/:all/;
use Data::Dumper;
use strict;
use warnings;


ok( defined $GSL_SUCCESS, 'GSL_SUCCESS');
ok( defined $GSL_EOF    ,  'GSL_EOF' );

ok( gsl_strerror($GSL_SUCCESS) eq 'success', q{gsl_strerror(GSL_SUCCESS) = 'success'} );
ok( gsl_strerror($GSL_EOF) eq 'end of file', q{gsl_strerror(GSL_EOF) = 'end of file'} );

