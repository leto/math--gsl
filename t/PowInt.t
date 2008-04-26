use Test::More 'no_plan';
use Math::GSL;
use Math::GSL::Errno;
use Math::GSL::PowInt;
use Data::Dumper;
use strict;
use warnings;

{
    my $gsl = Math::GSL->new;
    my $results = { 
                'Math::GSL::PowInt::gsl_pow_2(3)'   =>      3 ** 2,
                'Math::GSL::PowInt::gsl_pow_2(0)'   =>      0 ** 2,
                'Math::GSL::PowInt::gsl_pow_2(-1)'  =>   (-1) ** 2,
                'Math::GSL::PowInt::gsl_pow_3(4)'   =>      4 ** 3,
                'Math::GSL::PowInt::gsl_pow_4(5)'   =>      5 ** 4,
                'Math::GSL::PowInt::gsl_pow_5(6)'   =>      6 ** 5,
                'Math::GSL::PowInt::gsl_pow_6(7)'   =>      7 ** 6,
                'Math::GSL::PowInt::gsl_pow_7(8)'   =>      8 ** 7,
                'Math::GSL::PowInt::gsl_pow_8(-4)'  =>   (-4) ** 8,
                'Math::GSL::PowInt::gsl_pow_9(4)'   =>      4 ** 9,
              };

    $gsl->verify_results($results);
}

