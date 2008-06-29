use Test::More 'no_plan';
use Math::GSL;
use Math::GSL::Deriv qw/:all/;
use Data::Dumper;
use strict;
use warnings;



{
    my ($x,$h,$result,$abserr)=(5,0.01,0,0);
    my $x_squared = sub {my $x=shift; $x ** 2};

    gsl_deriv_central ( $x_squared, $x, $h, $result, $abserr);
}

