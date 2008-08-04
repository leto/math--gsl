package Math::GSL::NTuple::Test;
use base q{Test::Class};
use Test::More;
use Math::GSL::NTuple qw/:all/; 
use Math::GSL qw/:all/;
use Data::Dumper;
use strict;

sub make_fixture : Test(setup) {
}

sub teardown : Test(teardown) {
    unlink 'ntuple' if -f 'ntuple';
}

sub GSL_NTUPLE_CREATE : Tests {
  my $ntuple = gsl_ntuple_create('ntuple', [1,2,3],12);
  print Dumper [ $ntuple ];
  isa_ok ($ntuple, 'Math::GSL::NTuple::gsl_ntuple');
}

1;
