package Math::GSL::Interp::Test;
use base q{Test::Class};
use Test::More;
use Math::GSL::Interp qw/:all/;
use Math::GSL::Errno qw/:all/;
use Math::GSL qw/:all/;
use Data::Dumper;
use strict;

sub make_fixture : Test(setup) {
}

sub teardown : Test(teardown) {
}

sub GSL_INTERP_ALLOC : Tests {
 my $I = gsl_interp_alloc($gsl_interp_linear, 2);
 isa_ok($I, 'Math::GSL::Interp');
}

sub GSL_INTERP_INIT : Tests {

}
sub GSL_INTERP_BSEARCH : Tests {
  my $x_array = [ 0.0, 1.0, 2.0, 3.0, 4.0 ];
  
  # check an interior point
  my $index_result = gsl_interp_bsearch($x_array, 1.5, 0, 4);
  is($index_result, 1);

  # check that we get the last interval if x == last value 
  $index_result = gsl_interp_bsearch($x_array, 4.0, 0, 4);
  is($index_result, 3);

  # check that we get the first interval if x == first value
  $index_result = gsl_interp_bsearch($x_array, 0.0, 0, 4);
  is($index_result, 0);  

  # check that we get correct interior boundary behaviour 
  $index_result = gsl_interp_bsearch($x_array, 2.0, 0, 4);
  is($index_result, 2);

  # check out of bounds above 
  $index_result = gsl_interp_bsearch($x_array, 10.0, 0, 4);
  is($index_result, 3);

  # check out of bounds below
  $index_result = gsl_interp_bsearch($x_array, -10.0, 0, 4);
  is($index_result, 0);
}

sub MULTIPLE_TESTS : Tests {
  my $a = gsl_interp_accel_alloc ();
  my $interp = gsl_interp_alloc ($gsl_interp_polynomial, 4);
  my $data_x = [ 0.0, 1.0, 2.0, 3.0 ];
  my $data_y = [ 0.0, 1.0, 2.0, 3.0 ];
  my $test_x = [ 0.0, 0.5, 1.0, 1.5, 2.5, 3.0 ];
  my $test_y = [ 0.0, 0.5, 1.0, 1.5, 2.5, 3.0 ];
  my $test_dy = [ 1.0, 1.0, 1.0, 1.0, 1.0, 1.0 ];
  my $test_iy = [ 0.0, 0.125, 0.5, 9.0/8.0, 25.0/8.0, 9.0/2.0 ];

  gsl_interp_init ($interp, $data_x, $data_y, 4);
  for my $i (0.. 3) {
    my $x = $test_x->[$i];
    my ($s1, $y) = gsl_interp_eval_e ($interp, $data_x, $data_y, $x, $a);
    my ($s2, $deriv) = gsl_interp_eval_deriv_e ($interp, $data_x, $data_y, $x, $a);
    my ($s3, $integ) = gsl_interp_eval_integ_e ($interp, $data_x, $data_y, $test_x->[0], $x, $a);

    ok_status($s1);
    ok_status($s2);
    ok_status($s3);

     ok_similar([$y, $deriv, $integ], [$test_y->[$i], $test_dy->[$i], $test_iy->[$i]], "eval_e, derive_e and integ_e",1e-10);

     my $diff_y = $y - $test_y->[$i];
     my $diff_deriv = $deriv - $test_dy->[$i];
     my $diff_integ = $integ - $test_iy->[$i];
     ok( abs($diff_y) < 1e-10, "diff_y");
     ok( abs($diff_deriv) < 1e-10, "diff_deriv");
     ok( abs($diff_integ) < 1e-10, "diff_integ");
    }
  gsl_interp_accel_free ($a);
  gsl_interp_free ($interp);
}
1;
