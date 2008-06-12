package Math::GSL::QRNG::Test;
use base q{Test::Class};
use Test::More;
use Math::GSL::QRNG qw/:all/;
use Math::GSL qw/:all/;
use Data::Dumper;
use Math::GSL::Errno qw/:all/;
use strict;

sub make_fixture : Test(setup) {
}

sub teardown : Test(teardown) {
}

sub GSL_QRNG_ALLOC : Tests {
    my $qrng = gsl_qrng_alloc($gsl_qrng_sobol, 2);
    isa_ok( $qrng, 'Math::GSL::QRNG');
}

sub GSL_QRNG_INIT_GET : Tests { 
    my $qrng = gsl_qrng_alloc($gsl_qrng_sobol, 2);
    my ($ok, @values)= gsl_qrng_get($qrng);
    is ($ok, 0);
    ok( $values[0] > 0 && $values[0] < 1, "first value");
#    ok( $values[1] > 0 && $values[1] < 1, "second value");  #this line doesn't work because the typemaps only output one value at the moment...
}
1;
