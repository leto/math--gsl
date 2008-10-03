package Math::GSL::Chebyshev::Test;
use Math::GSL::Test qw/:all/;
use base q{Test::Class};
use Test::More;
use Math::GSL::Chebyshev qw/:all/;
use Math::GSL qw/:all/;
use Data::Dumper;
use strict;

sub make_fixture : Test(setup) {
    my $self = shift;
    $self->{cheb} = gsl_cheb_alloc(40);
}

sub teardown : Test(teardown) {
}

sub GSL_CHEB_ALLOC : Tests {
    my $self = shift;
    isa_ok($self, 'Math::GSL::Chebyshev');
}
1;
