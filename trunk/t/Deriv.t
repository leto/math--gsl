use Test::More 'no_plan';
use Math::GSL;
use Math::GSL::Deriv;
use Data::Dumper;
use strict;
use warnings;

my ($x,$h,$result,$abserr)=(5,0.01,0,0);


my $x_squared = sub {my $x=shift; $x ** 2};
print Math::GSL::Deriv::gsl_deriv_central ( $x_squared, $x, $h, $result, $abserr); 
print "\n";
print Math::GSL::Deriv::gsl_deriv_backward( $x_squared, $x, $h, $result, $abserr); 
print "\n";
print Math::GSL::Deriv::gsl_deriv_forward ( $x_squared, $x, $h, $result, $abserr); 

ok(0);

