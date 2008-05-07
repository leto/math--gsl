package Math::GSL::Const::Test;
use base q{Test::Class};
use Test::More;
use Math::GSL::Const;
use Math::GSL qw/is_similar/;
use strict;

sub make_fixture : Test(setup) {
    my $self = shift;
    $self->{gsl} = Math::GSL->new;
}

sub teardown : Test(teardown) {
}

sub GSL_CONST_CGS : Test {
    my $self = shift;
    my $results = { '$Math::GSL::Const::GSL_CONST_CGS_SPEED_OF_LIGHT' => 29979245800 };
    $self->{gsl}->verify_results($results);
}
42;
