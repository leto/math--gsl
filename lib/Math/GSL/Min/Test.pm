package Math::GSL::Min::Test;
use base q{Test::Class};
use Test::More;
use Math::GSL::Min qw/:all/;
use Math::GSL qw/:all/;
use strict;

sub make_fixture : Test(setup) {
    my $self = shift;
    $self->{min} = gsl_min_fminimizer_alloc($gsl_min_fminimizer_goldensection);
}

sub teardown : Test(teardown) {
}

sub GSL_MIN_TYPES : Tests { 

    my $m = gsl_min_fminimizer_alloc($gsl_min_fminimizer_goldensection);
    isa_ok($m, 'Math::GSL::Min');

    my $n = gsl_min_fminimizer_alloc($gsl_min_fminimizer_brent);
    isa_ok($n, 'Math::GSL::Min');
}

sub GSL_MIN_NEW_FREE : Tests {
    my $self = shift;
    my $min = $self->{min};
    isa_ok($min, 'Math::GSL::Min');

    gsl_min_fminimizer_free($min);
    ok(!$@, 'gsl_min_fminimizer_free');
}

1;
