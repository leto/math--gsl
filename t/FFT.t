package Math::GSL::FFT::Test;
use base q{Test::Class};
use Test::Most;
use Math::GSL::Test  qw/:all/;
use Math::GSL::FFT   qw/:all/;
use Math::GSL        qw/:all/;
use Math::GSL::Errno qw/:all/;
use Data::Dumper;
use strict;
use warnings;

BEGIN { gsl_set_error_handler_off() }

sub make_fixture : Test(setup) {
}

sub teardown : Test(teardown) {
    unlink 'fft' if -f 'fft';
}

sub FFT_REAL_TRANSFORM : Tests
{
    my $input  = [ (4242) x 100 ];
    my $N      = @$input;

    local $TODO = "https://github.com/leto/math--gsl/issues/132";
    return;

    my $workspace1          = gsl_fft_real_workspace_alloc($N);
    isa_ok($workspace1, 'Math::GSL::FFT');
    my $wavetable1          = gsl_fft_real_wavetable_alloc($N);
    isa_ok($wavetable1, 'Math::GSL::FFT');

    my ($status, $output )  = gsl_fft_real_transform ($input, 1, $N, $wavetable1, $workspace1);
    ok_status($status, $GSL_SUCCESS, 'gsl_fft_real_transform');

    my $workspace2          = gsl_fft_real_workspace_alloc($N);
    isa_ok($workspace2, 'Math::GSL::FFT');
    my $wavetable2          = gsl_fft_halfcomplex_wavetable_alloc($N);
    isa_ok($wavetable2, 'Math::GSL::FFT');

    my ($status2, $output2) = gsl_fft_halfcomplex_backward($output, 1, $N, $wavetable2, $workspace2);
    ok_status($status2, $GSL_SUCCESS, 'gsl_fft_halfcomplex_backward');

    # F = F^(-1)/$N on real inputs
    ok_similar( $input, [ map { $_ / $N } @$output2 ] );

    my $wavetable3          = gsl_fft_halfcomplex_wavetable_alloc($N);
    my $workspace3          = gsl_fft_real_workspace_alloc($N);
    my ($status3, $output3) = gsl_fft_halfcomplex_inverse($output, 1, $N, $wavetable3, $workspace3);
    ok_status($status3, $GSL_SUCCESS, 'gsl_fft_halfcomplex_inverse');

    # F = F^(-1) on real inputs
    ok_similar( $input, $output3 );
}

sub FFT_HALFCOMPLEX_UNPACK : Tests
{
    my $input  = [ 0 .. 7 ];
    my $N      = @$input;
    #TODO: this core dumps still
    #my ($status, $output ) = gsl_fft_halfcomplex_unpack($input, 1, $N / 2);
    #warn Dumper [ $output ];
    #ok_status($status);
}


sub FFT_REAL_UNPACK : Tests
{
    my $input  = [ 0 .. 7 ];
    my $N      = @$input;
    #TODO: this core dumps still
    #my ($status, $output ) = gsl_fft_real_unpack($input, 1, $N);
    #ok_status($status);
    #warn Dumper [ $output ];
}

sub FFT_REAL_RADIX2_TRANSFORM_STRIDE : Tests
{
    my $input  = [ 0 .. 7 ];
    my $N      = @$input;
    my $stride = 2;

    local $TODO = "coredumps :(";
    return;

    my ($status, $output ) = gsl_fft_real_radix2_transform ($input, $stride, $N / 2);
    ok_status($status);
    ok( @$output == $N/2 );

    my ($status2, $output2) = gsl_fft_halfcomplex_radix2_inverse($output, $stride, $N/2);
    ok( @$output2 == $N/2 );
    ok_status($status2);
}

sub FFT_REAL_RADIX2_TRANSFORM : Tests
{
    my $input  = [ 0 .. 7 ];
    my $N      = @$input;

    local $TODO = "coredumps :(";
    return;

    my ($status, $output ) = gsl_fft_real_radix2_transform ($input, 1, $N);
    ok_status($status);

    my ($status2, $output2) = gsl_fft_halfcomplex_radix2_backward($output, 1, $N);
    ok_status($status2);

    # F = F^(-1) / N on real inputs
    ok_similar( $input, [ map { $_ / $N } @$output2 ] );

    my ($status3, $output3) = gsl_fft_halfcomplex_radix2_inverse($output, 1, $N);
    ok_status($status3);

    # F = F^(-1) on real inputs
    ok_similar( $input, $output3 );

    # TODO
    #my ($status4,$output4) = gsl_fft_halfcomplex_radix2_unpack($output, 1, $N);
    #ok_status($status4);
}

sub FFT_COMPLEX_RADIX2_DIF_FORWARD : Tests
{
    my $data   = [ 0 .. 7 ];
    my $N      = @$data;
    my $stride = 1;
    local $TODO = "https://github.com/leto/math--gsl/issues/131";
    #my ($status1, $output1) = gsl_fft_complex_radix2_dif_forward ($data, $stride, $N/2);
    #ok_status($status1);
    #ok( @$output1 == $N/2 );
    #
    #my ($status2, $output2) = gsl_fft_complex_radix2_dif_backward ($output1, $stride, $N/2);
    #ok_status($status2);
    #ok( @$output2 == $N/2 );
}

sub FFT_COMPLEX_RADIX2_FORWARD : Tests
{
    my $data = [ 0 .. 7 ];
    my $N = @$data;

    local $TODO = "FFT tests are messed up";
    return;

    my ($status1, $output1) = gsl_fft_complex_radix2_forward ($data, 1, $N / 2);
    ok_status($status1);
    ok( @$output1 == $N / 2 );

    # this seems to non-deterministically fail OR cause a core dump
    #my ($status2, $output2) = gsl_fft_complex_radix2_inverse($output1, 1, $N / 2);
    #ok_status($status2);
    #warn Dumper [ $data, $output1,  $output2 ];
    #ok_similar($data, $output2);
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
