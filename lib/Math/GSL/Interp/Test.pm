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
1;
