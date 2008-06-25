package Math::GSL::CBLAS::Test;
use base q{Test::Class};
use Test::More;
use Math::GSL::CBLAS qw/:all/;
use Math::GSL qw/:all/;
use Data::Dumper;
use Math::GSL::Errno qw/:all/;
use strict;

sub make_fixture : Test(setup) {
}

sub teardown : Test(teardown) {
}


1;
