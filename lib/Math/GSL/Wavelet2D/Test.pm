package Math::GSL::Wavelet2D:Test;
use base q{Test::Class};
use Test::More;
use Math::GSL::Errno qw/:all/;
use Math::GSL::wavelet2D qw/:all/;
use Math::GSL qw/is_similar/;
use strict;

BEGIN{ Errno::gsl_set_error_handler_off(); }

sub make_fixture : Test(setup) {
    my $self = shift;
}

sub teardown : Test(teardown) {
    my $self = shift;
}

sub GSL_WAVELET2D_NEW : Tests {
    my $self = shift;
}

1;
