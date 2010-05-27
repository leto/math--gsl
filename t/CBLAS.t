package Math::GSL::CBLAS::Test;
use base q{Test::Class};
use Test::More tests => 3;
use Math::GSL::Test  qw/:all/;
use Math::GSL::CBLAS qw/:all/;
use Math::GSL        qw/:all/;
use Math::GSL::Errno qw/:all/;
use Data::Dumper;
use strict;

BEGIN{ gsl_set_error_handler_off() }

sub make_fixture : Test(setup) {
}

sub teardown : Test(teardown) {
}


sub TEST_CBLAS : Tests {
       return; #disabled, need a better test
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
       #      [ 674.06 674.72 ]
       my @stuff = cblas_sgemm ($CblasRowMajor,
                    $CblasNoTrans, $CblasNoTrans, 2, 2, 3,
                    1.0, $A, $lda, $B, $ldb, 0.0, $C, $ldc);
       #warn Dumper [ @stuff ];
       ok(is_similar_relative( \@stuff, [ 367.76, 368.12 , 674.06, 674.72 ], '.01' ),'cblas_sgemm');
}

sub CBLAS_IDAMAX : Tests {
   my $N = 1;
   my $X = [ 0.247 ];
   my $incX = 1;
   my $expected = 0;
   my $k = cblas_idamax($N, $X, $incX);
   is_similar($k, $expected, 1e-6, "$k ?= $expected");
}

sub CBLAS_ISAMAX : Tests {
    my $N = 1;
    my $X = [ -0.388 ];
    my $incX = 1;
    my $expected = 0;
    my $k = cblas_isamax($N, $X, $incX);
    is_similar($k, $expected, 1e-6, "$k ?= $expected");
}

sub CBLAS_SASUM : Tests  {
    my $N = 1;
    my $X = [ 0.239 ];
    my $incX = 1;
    my $expected = 0.239;
    my $f = cblas_sasum($N, $X, $incX);
    ok(is_similar_relative($f, $expected, 0.01), "cblas_sasum: $f ?= $expected");
}


sub CBLAS_DASUM : Tests(2) {
    my $N = 2;
    my $X = [ -0.413, 12 ];
    my $incX = -1;
    my $expected = 0;
    my $f = cblas_dasum($N, $X, $incX);
    is_similar($f, $expected, 1e-6, "dasum: $f ?= $expected");

    $incX = 1;
    $expected = 12.413;
    $f = cblas_dasum($N, $X, $incX);
    is_similar($f, $expected, 1e-6, "dasum: $f ?= $expected");
}

Test::Class->runtests;
