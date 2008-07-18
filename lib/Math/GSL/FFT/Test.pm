package Math::GSL::FFT::Test;
use base q{Test::Class};
use Test::More;
use Math::GSL::FFT qw/:all/;
use Math::GSL qw/:all/;
use Data::Dumper;
use Math::GSL::Errno qw/:all/;
use strict;

BEGIN { gsl_set_error_handler_off(); }
sub make_fixture : Test(setup) {
}

sub teardown : Test(teardown) {
    unlink 'fft' if -f 'fft';
}
sub FFT_REAL_RADIX2_TRANSFORM : Tests 
{
    my $data = [ (0) x 5, (1) x 22, (0) x 5 ];
    ok_status( gsl_fft_real_radix2_transform ($data, 1, 32), $GSL_SUCCESS);
    print Dumper [ $data ];
}

sub FFT_COMPLEX_RADIX2_FORWARD : Tests 
{
    my $data = [ (1) x 10, (0) x 236, (1) x 10 ];
    my $status = gsl_fft_complex_radix2_forward ($data, 1, 128);
    ok_status($status, $GSL_SUCCESS);
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
1;
