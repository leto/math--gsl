package Math::GSL::Roots::Test;
use base q{Test::Class};
use Test::More;
use Math::GSL::Roots;
use Math::GSL qw/is_similar/;
use strict;

sub make_fixture : Test(setup) {
    my $self = shift;
    $self->{roots} = Math::GSL::Roots::gsl_root_fsolver_alloc($Math::GSL::Roots::gsl_root_fsolver_bisection);
}

sub teardown : Test(teardown) {
}

sub GSL_ROOTS_NEW : Test {
    my $self = shift;
    my $x = $self->{roots};
    isa_ok($x, 'Math::GSL::Roots', 'gsl_root_fsolver_alloc' );
}

1;
