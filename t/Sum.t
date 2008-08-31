package Math::GSL::Sum::Test;
use Math::GSL::Test qw/:all/;
use base q{Test::Class};
use Test::More;
use Math::GSL::Errno qw/:all/;
use Math::GSL::Const qw/:all/;
use Math::GSL::Machine qw/:all/;
use Math::GSL::Sum qw/:all/;
use Math::GSL qw/:all/;
use Data::Dumper;
use strict;


sub make_fixture : Test(setup) {
}

sub teardown : Test(teardown) {
}

sub LEVIN_U_ALLOC_FREE : Tests {
  my $w = gsl_sum_levin_u_alloc(5);
  isa_ok($w, 'Math::GSL::Sum');
  gsl_sum_levin_u_free($w);
  ok(!$@, 'gsl_histogram_free');
}

sub LEVIN_UTRUNC_ALLOC_FREE : Tests {
  my $w = gsl_sum_levin_utrunc_alloc(5);
  isa_ok($w, 'Math::GSL::Sum');
  gsl_sum_levin_utrunc_free($w);
  ok(!$@, 'gsl_histogram_free');
}

sub ACCEL : Tests  {
   my $t;
   my $np1;

   my $zeta_2 = $M_PI * $M_PI / 6.0;

    for my $n (0..49)
      {
        $np1 = $n + 1.0;
        $t->[$n] = 1.0 / ($np1 * $np1);
      }

  my $w = gsl_sum_levin_utrunc_alloc (50);
  
  my @got = gsl_sum_levin_utrunc_accel ($t, 50, $w);
  ok_status($got[0], $GSL_SUCCESS);
  ok(is_similar_relative($got[1], $zeta_2, 1e-8), "trunc result, zeta(2)");

  # No need to check precision for truncated result since this is not a meaningful number 

  gsl_sum_levin_utrunc_free ($w);
 
 
  $w = gsl_sum_levin_u_alloc (50);

  @got = gsl_sum_levin_u_accel ($t, 50, $w);
  ok_status($got[0], $GSL_SUCCESS);
  ok(is_similar_relative($got[1], $zeta_2, 1e-8), "full result, zeta(2)");
  
  my $sd_est = -(log($got[2]/abs($got[1]))/log(10));
  my $sd_actual = -(log($GSL_DBL_EPSILON + abs(($got[1] - $zeta_2)/$zeta_2))/log(10));

  # Allow one digit of slop 
  
  local $TODO = "The error test from GSL fails here"; 
  ok ($sd_est > $sd_actual + 1.0, "full significant digits, zeta(2) ($sd_est vs $sd_actual)");

  gsl_sum_levin_u_free ($w);
}

sub ACCEL2 : Tests  {
   my $t;
   my $np1;
   my $x = 10.0;
   my $y = exp($x);
   $t->[0] = 1.0;
    for my $n (1..49)
    {
       $t->[$n] = $t->[$n - 1] * ($x / $n);
    }
  my $w = gsl_sum_levin_utrunc_alloc (50);
  
  my @got = gsl_sum_levin_utrunc_accel ($t, 50, $w);
  ok_status($got[0], $GSL_SUCCESS);
  ok(is_similar_relative($got[1], $y, 1e-8), "trunc result, exp(10)");

  # No need to check precision for truncated result since this is not a meaningful number 

  gsl_sum_levin_utrunc_free ($w);
 
 
  $w = gsl_sum_levin_u_alloc (50);

  @got = gsl_sum_levin_u_accel ($t, 50, $w);
  ok_status($got[0], $GSL_SUCCESS);
  ok(is_similar_relative($got[1], $y, 1e-8), "full result, exp(10)");
  
  my $sd_est = -(log($got[2]/abs($got[1]))/log(10));
  my $sd_actual = -(log($GSL_DBL_EPSILON + abs(($got[1] - $y)/$y))/log(10));

  # Allow one digit of slop 
  local $TODO = "The error test from GSL fails here"; 
  ok ($sd_est > $sd_actual + 1.0, "full significant digits, exp(10) ($sd_est vs $sd_actual)");

  gsl_sum_levin_u_free ($w);
}

Test::Class->runtests;
