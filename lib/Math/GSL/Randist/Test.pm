package Math::GSL::Randist::Test;
use base q{Test::Class};
use Test::More;
use Math::GSL::Randist qw/:all/;
use Math::GSL::RNG qw/:all/;
use Math::GSL qw/:all/;
use Data::Dumper;
use Math::GSL::Errno qw/:all/;
use strict;

sub make_fixture : Test(setup) {
    my $self = shift;
    $self->{vector} = gsl_rng_alloc($gsl_rng_default);
}

sub teardown : Test(teardown) {
}

sub GSL_RAN_BERNOULLI_PDF : Tests {
    my $x = gsl_ran_bernoulli_pdf(2, 0.5);
    is($x, 0);
} 
1;
