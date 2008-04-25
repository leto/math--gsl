use Test::More 'no_plan';
use Math::GSL;
use Math::GSL::CDF;
use Data::Dumper;
use strict;
use warnings;

{
    my $gsl = Math::GSL->new;
    my $results = { 
                };
    $gsl->verify_results($results);
}
