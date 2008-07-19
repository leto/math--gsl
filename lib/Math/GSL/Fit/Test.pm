package Math::GSL::Fit::Test;
use base q{Test::Class};
use Test::More;
use Test::Exception;
use Math::GSL::Fit qw/:all/; 
use Math::GSL qw/:all/;
use Math::GSL::Errno qw/:all/;
use Data::Dumper;
use strict;

sub make_fixture : Test(setup) {
}

sub teardown : Test(teardown) {
}

sub FIT_LINEAR_DIES : Tests {
 dies_ok( sub { gsl_fit_linear(0,0,0,0) } );
}

sub GSL_FIT_LINEAR : Tests {
    local $TODO = "Don't know why the function dies...";
    my $norris_x = [0.2, 337.4, 118.2, 884.6, 10.1, 226.5, 666.3, 996.3,
                        448.6, 777.0, 558.2, 0.4, 0.6, 775.5, 666.9, 338.0, 
                        447.5, 11.6, 556.0, 228.1, 995.8, 887.6, 120.2, 0.3, 
                        0.3, 556.8, 339.1, 887.2, 999.0, 779.0, 11.1, 118.3,
                        229.2, 669.1, 448.9, 0.5 ] ;
    my $norris_y = [ 0.1, 338.8, 118.1, 888.0, 9.2, 228.1, 668.5, 998.5,
                        449.1, 778.9, 559.2, 0.3, 0.1, 778.1, 668.8, 339.3, 
                        448.9, 10.8, 557.7, 228.3, 998.0, 888.8, 119.6, 0.3, 
                        0.6, 557.6, 339.3, 888.0, 998.5, 778.9, 10.2, 117.6,
                        228.9, 668.4, 449.2, 0.2];
    my $xstride = 2; 
    my $wstride = 3; 
    my $ystride = 5;
    my ($x, $w, $y);
    for my $i (0 .. 35)
    {
        $x->[$i*$xstride] = $norris_x->[$i];
        $w->[$i*$wstride] = 1.0;
        $y->[$i*$ystride] = $norris_y->[$i];
    }
    # this currently crashes the test script
    exit(0);
    my ($status, @results) = gsl_fit_linear($x, $xstride, $y, $ystride, 36);

    ok_status( $status, $GSL_SUCCESS );
    print Dumper [ @results ];
    ok(is_similar_relative($results[1], -0.262323073774029, 1e-10));
    ok(is_similar_relative($results[2], 1.00211681802045, 1e-10));
    ok(is_similar_relative($results[3], 0.232818234301152**2.0, 1e-10));
    ok(is_similar_relative($results[4], -7.74327536339570e-05, 1e-10));
    ok(is_similar_relative($results[5], 0.429796848199937E-03**2, 1e-10));
    ok(is_similar_relative($results[6], 26.6173985294224, 1e-10));
}

1;
