package Math::GSL::Spline::Test;
use base 'Test::Class';
use Test::More  tests => 38;
use Math::GSL::Errno  qw/:all/;
use Math::GSL::Test   qw/:all/;
use Math::GSL::Spline qw/:all/;
use Math::GSL::Interp qw/:all/;
use Test::Exception;
use Data::Dumper;
use strict;
use warnings;

BEGIN{ gsl_set_error_handler_off() };

sub make_fixture : Test(setup) {
    my $self = shift;
    $self->{spline} = gsl_spline_alloc($gsl_interp_linear,100);
}

sub teardown : Test(teardown) {
}
sub TEST_FREE : Test {
    my $self = shift;
    gsl_spline_free($self->{spline});
    ok(!$@ && !$! && !$?,'gsl_spline_free');
}
sub TEST_MIN_SIZE : Test {
    my $self = shift;
    cmp_ok(2,'==',gsl_spline_min_size($self->{spline}),'min_size');
}
sub TEST_NAME : Test {
        my $self = shift;
        my $spline = $self->{spline};
        cmp_ok('linear', 'eq' , gsl_spline_name($spline));
}
sub TEST_ALLOC : Tests {
    isa_ok(gsl_spline_alloc($_,100), 'Math::GSL::Spline') for (
               $gsl_interp_linear,
               $gsl_interp_polynomial,
               $gsl_interp_cspline,
               $gsl_interp_cspline_periodic,
               $gsl_interp_akima,
               $gsl_interp_akima_periodic);
}

sub MULTIPLE_TESTS : Tests {
  my $a = gsl_interp_accel_alloc ();
  my $spline = gsl_spline_alloc ($gsl_interp_polynomial, 4);
  my $data_x = [ 0.0, 1.0, 2.0, 3.0 ];
  my $data_y = [ 0.0, 1.0, 2.0, 3.0 ];
  ok_status(gsl_spline_init($spline, $data_x, $data_y, 4), $GSL_SUCCESS);
  my $test_x = [ 0.0, 0.5, 1.0, 1.5, 2.5, 3.0 ];
  my $test_y = [ 0.0, 0.5, 1.0, 1.5, 2.5, 3.0 ];
  my $test_dy = [ 1.0, 1.0, 1.0, 1.0, 1.0, 1.0 ];
  my $test_iy = [ 0.0, 0.125, 0.5, 9.0/8.0, 25.0/8.0, 9.0/2.0 ];

  for my $i (0.. 3) {
    my $x = $test_x->[$i];
    my ($s1, $y) = gsl_spline_eval_e ($spline,$x, $a);
    my ($s2, $deriv) = gsl_spline_eval_deriv_e ($spline, $x, $a);
    my ($s3, $integ) = gsl_spline_eval_integ_e ($spline, $test_x->[0], $x, $a);

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
  gsl_spline_free ($spline);
}

Test::Class->runtests;
