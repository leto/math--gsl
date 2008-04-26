use Test::More 'no_plan';
use Math::GSL;
use Math::GSL::PowInt qw/:all/;
use Data::Dumper;
use strict;
use warnings;
my $class = qw{Math::GSL::PowInt};

{
    my $results = { 
                'gsl_pow_2(3)'   =>      3 ** 2,
                'gsl_pow_2(0)'   =>      0 ** 2,
                'gsl_pow_2(-1)'  =>   (-1) ** 2,
                'gsl_pow_3(4)'   =>      4 ** 3,
                'gsl_pow_4(5)'   =>      5 ** 4,
                'gsl_pow_5(6)'   =>      6 ** 5,
                'gsl_pow_6(7)'   =>      7 ** 6,
                'gsl_pow_7(8)'   =>      8 ** 7,
                'gsl_pow_8(-4)'  =>   (-4) ** 8,
                'gsl_pow_9(4)'   =>      4 ** 9,
              };
    my $gsl = Math::GSL->new;
    $gsl->verify_results($results, $class);
}
