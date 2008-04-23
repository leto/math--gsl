use Test::More tests=>3;
use Math::GSL;
use Math::GSL::Errno;
use Data::Dumper;
use strict;
use warnings;

ok( defined $Math::GSL::Errno::GSL_SUCCESS, 'GSL_SUCCESS');
ok( defined $Math::GSL::Errno::GSL_EOF,  'GSL_EOF' );

ok( Math::GSL::Errno::gsl_strerror($Math::GSL::Errno::GSL_SUCCESS) eq 'success',
    q{gsl_strerror(GSL_SUCCESS) = 'success'} );
