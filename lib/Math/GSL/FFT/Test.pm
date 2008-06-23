package Math::GSL::FFT::Test;
use base q{Test::Class};
use Test::More;
use Math::GSL::FFT qw/:all/;
use Math::GSL qw/:all/;
use Data::Dumper;
use Math::GSL::Errno qw/:all/;
use strict;

sub make_fixture : Test(setup) {
}

sub teardown : Test(teardown) {
    unlink 'fft' if -f 'fft';
}




1;
