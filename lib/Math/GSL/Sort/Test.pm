package Math::GSL::Sort::Test;
use base q{Test::Class};
use Test::More;
use Math::GSL::Sort qw/:plain :vector :all/;
use Math::GSL qw/is_similar/;
use Data::Dumper;
use strict;

sub make_fixture : Test(setup) {
}
sub teardown : Test(teardown) {
}

sub GSL_SORT : Tests {
    my $x = [ 2**15, 1, 42, 17, 6900, 3 ];
    gsl_sort($x, 1, $#$x + 1 );
    print Dumper [ $x ];
    is_deeply ( $x , [ 1, 3, 17 , 42, 6900, 2**15 ], 'gsl_sort' );
    
}

42;
