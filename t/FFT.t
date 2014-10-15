package Math::GSL::FFT::Test;
use base q{Test::Class};
use Test::More tests => 16;
use Test::Differences;
use Math::GSL::Test  qw/:all/;
use Math::GSL::FFT   qw/:all/;
use Math::GSL        qw/:all/;
use Math::GSL::Errno qw/:all/;
use Data::Dumper;
use strict;

BEGIN { gsl_set_error_handler_off() }

sub make_fixture : Test(setup) {
}

sub teardown : Test(teardown) {
    unlink 'fft' if -f 'fft';
}

sub FFT_REAL_RADIX2_TRANSFORM : Tests
{
    my $data    = [ (0) x 3, (1) x 2, (0) x 3 ];
    my $expected = [
    ];
    my $status = gsl_fft_real_radix2_transform ($data, 1, 8);
    ok_status($status);

    eq_or_diff( $data, $expected );
}

sub FFT_HALFCOMPLEX_RADIX2_INVERSE : Tests
{
    my $data    = [ (0) x 3, (1) x 2, (0) x 3 ];
    my $expected = [
    ];
    my $status = gsl_fft_halfcomplex_radix2_transform ($data, 1, 8);
    ok_status($status);

    eq_or_diff( $data, $expected );
}

sub FFT_COMPLEX_RADIX2_FORWARD : Tests
{
    local $TODO = 'no worky';
    my $data = [ (1) x 3, (0) x 2, (1) x 3 ];
    my $expected = [ ];

    # this test caused a coredump currently because $data is not the correct format
    return;
    my $status = gsl_fft_complex_radix2_forward ($data, 1, 8);
    ok_status($status);
    eq_or_diff($data, $expected);
    # we should propably use the gsl_fft_real_unpack function here to create a suitable complex_packed_array
}

sub FFT_VARS : Tests(2) {
    cmp_ok( $gsl_fft_forward, '==', -1, 'gsl_fft_forward' );
    cmp_ok( $gsl_fft_backward, '==', +1, 'gsl_fft_backward' );
}

sub WAVETABLE_ALLOC_FREE: Tests(6) {
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

sub WORKSPACE_ALLOC_FREE: Tests(4) {
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
