package Math::GSL::CBLAS::Test;
use Math::GSL::Test qw/:all/;
use base q{Test::Class};
use Test::More;
use Math::GSL::CBLAS qw/:all/;
use Math::GSL qw/:all/;
use Data::Dumper;
use Math::GSL::Errno qw/:all/;
use strict;

BEGIN{ gsl_set_error_handler_off() }

sub make_fixture : Test(setup) {
}

sub teardown : Test(teardown) {
}

sub TEST_CBLAS : Tests {
       local $TODO = "need to figure out how to reture more that just first element";

       my $A = [ 0.11, 0.12, 0.13,
                  0.21, 0.22, 0.23 ];
       my $lda = 3;
       my $B   = [ 1011, 1012,
                   1021, 1022,
                   1031, 1032 ];
       my $ldb = 2;
       my $C    = [0.00, 0.00,
                  0.00, 0.00 ];
       my $ldc = 2.0;

       # Compute C = A * B 
       # C  = [ 367.76 368.12 ]
        #     [ 674.06 674.72 ]
       my @stuff = cblas_sgemm ($CblasRowMajor,
                    $CblasNoTrans, $CblasNoTrans, 2, 2, 3,
                    1.0, $A, $lda, $B, $ldb, 0.0, $ldc);
       #warn Dumper [ @stuff ];
       ok(is_similar_relative( \@stuff, [ 367.76, 368.12 , 674.06, 674.72 ], '.01' ),'cblas_sgemm');
}

sub CBLAS_IDAMAX : Tests {
   my $N = 1;
   my $X = 0.247;
   my $incX = -1;
   my $expected = 0;
   my $k;
   $k = cblas_idamax($N, $X, $incX);
   is($k, $expected);
}

sub CBLAS_ISAMAX : Tests {
   my $N = 1;
   my $X = -0.388;
   my $incX = -1;
   my $expected = 0;
   my $k = cblas_isamax($N, $X, $incX);
   is($k, $expected);
}

sub CBLAS_SASUM : Tests  {
   my $N = 1;
   my $X = 0.239;
   my $incX = -1;
   my $expected = 0.0; 
   my $f = cblas_sasum($N, $X, $incX);
   is($f, $expected);
}


sub CBLAS_DASUM : Tests {
 my $N = 1;
 my $X = -0.413;
 my $incX = -1;
 my $expected = 0; 
 my $f = cblas_dasum($N, $X, $incX);
 is($f, $expected);
}

Test::Class->runtests;
