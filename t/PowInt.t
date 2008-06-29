use Test::More 'no_plan';
use Math::GSL qw/:all/;
use Math::GSL::PowInt qw/:all/;
use Data::Dumper;
use strict;
use warnings;
use Test::Exception;


{
    ok( gsl_pow_4(2) == gsl_pow_2(4) , q{%EXPORT_TAGS works} );
}
{
    # SWIG takes care of arg checking, but it's still nice to check
    dies_ok( sub { gsl_pow_2() } ,       'Invalid gsl_pow args');
    dies_ok( sub { gsl_pow_2(1,2) } ,    'Invalid gsl_pow args');
    dies_ok( sub { gsl_pow_2( () ) } ,   'Invalid gsl_pow args');
    dies_ok( sub { gsl_pow_2(qw(1 2)) } ,'Invalid gsl_pow args');
}
{
    ok_similar( [ map { eval $_ } (
                'gsl_pow_2(3.14)'   ,
                'gsl_pow_2(3)'      ,
                'gsl_pow_2(0)'      ,
                'gsl_pow_2(-1)'     ,
                'gsl_pow_3(4)'      ,
                'gsl_pow_4(5)'      ,
                'gsl_pow_5(6)'      ,
                'gsl_pow_6(7)'      ,
                'gsl_pow_7(8)'      ,
                'gsl_pow_8(-4)'     ,
                'gsl_pow_9(4)'      ,
                q{gsl_pow_2('nan')} ,
                q{gsl_pow_2('inf')} ,
                'gsl_pow_int(5,10)' ,
            ) ], [
                    (3.14) ** 2, 3 ** 2, 0 ** 2, (-1) ** 2, 4 ** 3, 5 ** 4, 6 ** 5, 7 ** 6,
                        8 ** 7, (-4) ** 8, 4 ** 9, q{nan}, q{inf}, 5 ** 10,
                ],
    "basic power tests",
    );

}
