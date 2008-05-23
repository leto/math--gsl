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
    my $x = [ 2**10, 1, 42, 17, 6900, 3 ];
    gsl_sort($x, 1, $#$x );
    print Dumper [ $x ];
    
}

42;
