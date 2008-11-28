package Math::GSL::Randist::Test;
use base q{Test::Class};
use Test::More tests => 1;
use Math::GSL::Test    qw/:all/;
use Math::GSL::RNG     qw/:all/;
use Math::GSL::Errno   qw/:all/;
use Math::GSL::Randist qw/:all/;
use Data::Dumper;
use strict;

sub make_fixture : Test(setup) {
    my $self = shift;
    $self->{vector} = gsl_rng_alloc($gsl_rng_default);
}

sub teardown : Test(teardown) {
}

sub GSL_RAN_BERNOULLI_PDF : Tests {
    ok_similar( 0, gsl_ran_bernoulli_pdf(2, 0.5), '=0 at (2,0.5)' );
} 
Test::Class->runtests;
