use Test::More tests=>2;
use Math::GSL::Sf;
use File::Spec;
use lib File::Spec->catfile("..","lib");
use Data::Dumper;
use strict;
use warnings;

my $eps = 1e-8;

my %results = ( 
                'gsl_sf_gamma(6.3)' =>  201.813275184748,
                'gsl_sf_erf(5)'     => 0.999999999998463,
              );
}

while (my($k,$v)=each %results){
    my $x = eval $k;
    ok( abs($x - $v) < $eps, "$k ?= $x" );    
}


