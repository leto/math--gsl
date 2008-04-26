use Test::More 'no_plan';
use Math::GSL;
use Math::GSL::Deriv;
use Data::Dumper;
use strict;
use warnings;



{
    my ($x,$h,$result,$abserr)=(5,0.01,0,0);
    my $x_squared = sub {my $x=shift; $x ** 2};

    for my $f (qw/central backward forward/) {
        eval {
            Math::GSL::_assert_dies( 
                sub { Math::GSL::Deriv::gsl_deriv_$f ( $x_squared, $x, $h, $result, $abserr)  } );
        }
    }
}

