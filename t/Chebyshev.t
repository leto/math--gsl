package Math::GSL::Chebyshev::Test;
use strict;
use warnings;
use base q{Test::Class};
use Math::GSL::Chebyshev qw/:all/;
use Math::GSL::Test      qw/:all/;
use Math::GSL            qw/:all/;
use Test::More;

sub make_fixture : Test(setup) {
    my $self = shift;
    $self->{cheb} = gsl_cheb_alloc(40);
}

sub teardown : Test(teardown) {
}

sub GSL_CHEB_ALLOC : Tests {
    my $self = shift;
    isa_ok($self->{cheb}, 'Math::GSL::Chebyshev');
}
Test::Class->runtests;

1;
