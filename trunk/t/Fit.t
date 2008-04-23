use Test::More tests=>1;
use Math::GSL;
use Math::GSL::Fit;
use Data::Dumper;
use strict;
use warnings;


# needs some more useful tests
{
    #RuntimeError Usage: gsl_fit_linear(x,xstride,y,ystride,n,c0,c1,cov00,cov01,cov11,sumsq);
    Math::GSL::_assert_dies( sub { Math::GSL::Fit::gsl_fit_linear(0,0,0,0) } );
}
