package Math::GSL::Min::Test;
use base q{Test::Class};
use Test::More;
use Math::GSL::Min qw/:all/;
use Math::GSL qw/is_similar/;
use strict;

sub make_fixture : Test(setup) {
    my $self = shift;
    $self->{min} = gsl_min_fminimizer_alloc($gsl_min_fminimizer_goldensection);
}

sub teardown : Test(teardown) {
}

sub GSL_MIN_NEW : Test {
    my $self = shift;
    my $x = $self->{min};
    ok( defined $x && $x->isa('Math::GSL::Min'), 'gsl_complex' );
}

1;
