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
 my @norris_x = (0.2, 337.4, 118.2, 884.6, 10.1, 226.5, 666.3, 996.3,
                        448.6, 777.0, 558.2, 0.4, 0.6, 775.5, 666.9, 338.0, 
                        447.5, 11.6, 556.0, 228.1, 995.8, 887.6, 120.2, 0.3, 
                        0.3, 556.8, 339.1, 887.2, 999.0, 779.0, 11.1, 118.3,
                        229.2, 669.1, 448.9, 0.5 ) ;
    my @norris_y = ( 0.1, 338.8, 118.1, 888.0, 9.2, 228.1, 668.5, 998.5,
                        449.1, 778.9, 559.2, 0.3, 0.1, 778.1, 668.8, 339.3, 
                        448.9, 10.8, 557.7, 228.3, 998.0, 888.8, 119.6, 0.3, 
                        0.6, 557.6, 339.3, 888.0, 998.5, 778.9, 10.2, 117.6,
                        228.9, 668.4, 449.2, 0.2);
    my $xstride = 2; 
    my $wstride = 3; 
    my $ystride = 5;
    my ($x, $w, $y);
    for my $i (0 .. 175)
    {
        $x->[$i] = 0;
        $w->[$i] = 0;
        $y->[$i] = 0;
    }

    for my $i (0 .. 35)
    {
        $x->[$i*$xstride] = $norris_x[$i];
        $w->[$i*$wstride] = 1.0;
        $y->[$i*$ystride] = $norris_y[$i];
    }
    my ($status, @results) = gsl_fit_linear($x, $xstride, $y, $ystride, 36); 
# this way of writing the arrays works but it complains
# about a lot of unitialized entries even with the stride correctly set, 
# is there any way to bypass this without having to initialize every element of the array like I do?

    ok_status( $status);
    ok(is_similar_relative($results[0], -0.262323073774029, 10**-10));
    ok(is_similar_relative($results[1], 1.00211681802045, 1e-10));
    ok(is_similar_relative($results[2], 0.232818234301152**2.0, 1e-10));
    ok(is_similar_relative($results[3], -7.74327536339570e-05, 1e-10));
    ok(is_similar_relative($results[4], 0.429796848199937E-03**2, 1e-10));
    ok(is_similar_relative($results[5], 26.6173985294224, 1e-10));
}
sub GSL_FIT_WLINEAR : Tests {
   my @norris_x = (0.2, 337.4, 118.2, 884.6, 10.1, 226.5, 666.3, 996.3,
                        448.6, 777.0, 558.2, 0.4, 0.6, 775.5, 666.9, 338.0, 
                        447.5, 11.6, 556.0, 228.1, 995.8, 887.6, 120.2, 0.3, 
                        0.3, 556.8, 339.1, 887.2, 999.0, 779.0, 11.1, 118.3,
                        229.2, 669.1, 448.9, 0.5 ) ;
    my @norris_y = ( 0.1, 338.8, 118.1, 888.0, 9.2, 228.1, 668.5, 998.5,
                        449.1, 778.9, 559.2, 0.3, 0.1, 778.1, 668.8, 339.3, 
                        448.9, 10.8, 557.7, 228.3, 998.0, 888.8, 119.6, 0.3, 
                        0.6, 557.6, 339.3, 888.0, 998.5, 778.9, 10.2, 117.6,
                        228.9, 668.4, 449.2, 0.2);
    my $xstride = 2; 
    my $wstride = 3; 
    my $ystride = 5;
    my ($x, $w, $y);
    for my $i (0 .. 175)
    {
        $x->[$i] = 0;
        $w->[$i] = 0;
        $y->[$i] = 0;
    }

    for my $i (0 .. 35)
    {
        $x->[$i*$xstride] = $norris_x[$i];
        $w->[$i*$wstride] = 1.0;
        $y->[$i*$ystride] = $norris_y[$i];
    }
 
    my $expected_c0 = -0.262323073774029;
    my $expected_c1 =  1.00211681802045; 
    my $expected_cov00 = 6.92384428759429e-02;  # computed from octave
    my $expected_cov01 = -9.89095016390515e-05; # computed from octave 
    my $expected_cov11 = 2.35960747164148e-07;  # computed from octave
    my $expected_sumsq = 26.6173985294224;
    
    my @got = gsl_fit_wlinear ($x, $xstride, $w, $wstride, $y, $ystride, 36);
  
    ok_status($got[0]);
    ok(is_similar_relative($got[1], $expected_c0, 1e-10), "norris gsl_fit_wlinear c0");
    ok(is_similar_relative($got[2], $expected_c1, 1e-10), "norris gsl_fit_wlinear c1");
    ok(is_similar_relative($got[3], $expected_cov00, 1e-10), "norris gsl_fit_wlinear cov00");
    ok(is_similar_relative($got[4], $expected_cov01, 1e-10), "norris gsl_fit_wlinear cov01");
    ok(is_similar_relative($got[5], $expected_cov11, 1e-10), "norris gsl_fit_wlinear cov11");
    ok(is_similar_relative($got[6], $expected_sumsq, 1e-10), "norris gsl_fit_wlinear sumsq");
}

sub GSL_FIT_MUL : Tests {
    my @noint1_x = ( 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70 );
    my @noint1_y = ( 130, 131, 132, 133, 134, 135, 136, 137, 138, 139, 140);

    my $xstride = 2; 
    my $wstride = 3; 
    my $ystride = 5;
    my ($x, $w, $y);
    for my $i (0 .. 60)
    {
        $x->[$i] = 0;
        $w->[$i] = 0;
        $y->[$i] = 0;
    }

    for my $i (0 .. 10) 
    {
      $x->[$i*$xstride] = $noint1_x[$i];
      $w->[$i*$wstride] = 1.0;
      $y->[$i*$ystride] = $noint1_y[$i];
    }
 
    my $expected_c1 = 2.07438016528926; 
    my $expected_cov11 = (0.165289256198347*(10**-1))**2.0;  
    my $expected_sumsq = 127.272727272727;
    
    my @got = gsl_fit_mul ($x, $xstride, $y, $ystride, 11);
  
    ok_status($got[0]);
    ok(is_similar_relative($got[1], $expected_c1, 1e-10), "noint1 gsl_fit_mul c1");
    ok(is_similar_relative($got[2], $expected_cov11, 1e-10), "noint1 gsl_fit_mul cov11");
    ok(is_similar_relative($got[3], $expected_sumsq, 1e-10), "noint1 gsl_fit_mul sumsq");
}

sub GSL_FIT_WMUL : Tests {
    my @noint1_x = ( 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70 );
    my @noint1_y = ( 130, 131, 132, 133, 134, 135, 136, 137, 138, 139, 140);

    my $xstride = 2; 
    my $wstride = 3; 
    my $ystride = 5;
    my ($x, $w, $y);
    for my $i (0 .. 60)
    {
        $x->[$i] = 0;
        $w->[$i] = 0;
        $y->[$i] = 0;
    }

    for my $i (0 .. 10) 
    {
      $x->[$i*$xstride] = $noint1_x[$i];
      $w->[$i*$wstride] = 1.0;
      $y->[$i*$ystride] = $noint1_y[$i];
    }
      
    my $expected_c1 = 2.07438016528926; 
    my $expected_cov11 = 2.14661371686165e-05; # computed from octave
    my $expected_sumsq = 127.272727272727;
    
    my @got = gsl_fit_wmul ($x, $xstride, $w, $wstride, $y, $ystride, 11);

    ok_status($got[0]);
    ok(is_similar_relative($got[1], $expected_c1, 1e-10), "noint1 gsl_fit_wmul c1");
    ok(is_similar_relative($got[2], $expected_cov11, 1e-10), "noint1 gsl_fit_wmul cov11");
    ok(is_similar_relative($got[3], $expected_sumsq, 1e-10), "noint1 gsl_fit_wmul sumsq");
}
1;
