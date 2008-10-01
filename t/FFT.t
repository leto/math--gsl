package Math::GSL::FFT::Test;
use Math::GSL::Test qw/:all/;
use base q{Test::Class};
use Test::More;
use Math::GSL::FFT qw/:all/;
use Math::GSL qw/:all/;
use Data::Dumper;
use Math::GSL::Errno qw/:all/;
use strict;

BEGIN { gsl_set_error_handler_off() }

sub make_fixture : Test(setup) {
}

sub teardown : Test(teardown) {
    unlink 'fft' if -f 'fft';
}
sub FFT_REAL_RADIX2_TRANSFORM : Tests 
{
    my $data = [ (0) x 5, (1) x 22, (0) x 5 ];
    my ($status, $pass ) = gsl_fft_real_radix2_transform ($data, 1, 32);
    ok_status($status);
    ok_similar( $pass, [
            22, -8.44205264582682, -4.64465605976076, -0.643126602526688, 1.70710678118655, 1.8349201998544,
            0.572726230154202, -0.676964287646119, -1, -0.455944707054924, 0.255700894591988, 0.524240654352147,
            0.292893218813453, -0.059180002187481, -0.183771064985432, -0.0818926089645147, 0, -0.831469612302545,
            -0.923879532511287, -0.195090322016128, 0.707106781186547, 0.98078528040323, 0.38268343236509,
            -0.555570233019602, -1, -0.555570233019602, 0.38268343236509, 0.980785280403231, 0.707106781186547,
            -0.195090322016128, -0.923879532511287, -0.831469612302545
            ]);
}

sub FFT_COMPLEX_RADIX2_FORWARD : Tests 
{
    my $data = [ (1) x 10, (0) x 236, (1) x 10 ];
    my ($status, $fft) = gsl_fft_complex_radix2_forward ($data, 1, 128);
    ok_status($status);
    local $TODO = 'fft of complex_packed_array does not work';
    ok( defined $fft );
}
sub FFT_VARS : Tests {
    cmp_ok( $gsl_fft_forward, '==', -1, 'gsl_fft_forward' );
    cmp_ok( $gsl_fft_backward, '==', +1, 'gsl_fft_backward' );
}

sub WAVETABLE_ALLOC_FREE: Tests {
    my $wavetable = gsl_fft_complex_wavetable_alloc(42);
    isa_ok($wavetable, 'Math::GSL::FFT' );
    gsl_fft_complex_wavetable_free($wavetable);
    ok(!$@, 'gsl_fft_complex_wavetable_free');

    $wavetable = gsl_fft_halfcomplex_wavetable_alloc(42);
    isa_ok($wavetable, 'Math::GSL::FFT' );
    gsl_fft_halfcomplex_wavetable_free($wavetable);
    ok(!$@, 'gsl_fft_halfcomplex_wavetable_free');

    $wavetable = gsl_fft_real_wavetable_alloc(42);
    isa_ok($wavetable, 'Math::GSL::FFT' );
    gsl_fft_real_wavetable_free($wavetable);
    ok(!$@, 'gsl_fft_real_wavetable_free');

}

sub WORKSPACE_ALLOC_FREE: Tests {
    my $workspace = gsl_fft_complex_workspace_alloc(42);
    isa_ok($workspace, 'Math::GSL::FFT' );
    gsl_fft_complex_workspace_free($workspace);
    ok(!$@, 'gsl_fft_complex_workspace_free');

    # there are no gsl_fft_halfcomplex_workspace_* functions

    $workspace = gsl_fft_real_workspace_alloc(42);
    isa_ok($workspace, 'Math::GSL::FFT' );
    gsl_fft_real_workspace_free($workspace);
    ok(!$@, 'gsl_fft_real_workspace_free');
}
Test::Class->runtests;
