package Math::GSL::DHT::Test;
use base q{Test::Class};
use Test::More;
use Math::GSL::DHT qw/:all/;
use Math::GSL qw/:all/;
use Data::Dumper;
use Math::GSL::Errno qw/:all/;
use strict;

sub make_fixture : Test(setup) {
}

sub teardown : Test(teardown) {
}


sub GSL_DHT_ALLOC : Tests {
    my $dht = gsl_dht_alloc(5);
    isa_ok($dht, 'Math::GSL::DHT');
}


1;
