package Math::GSL::FFT::Test;
use base q{Test::Class};
use Test::More;
use Math::GSL::FFT qw/:all/;
use Math::GSL qw/:all/;
use Data::Dumper;
use Math::GSL::Errno qw/:all/;
use strict;

sub make_fixture : Test(setup) {
}

sub teardown : Test(teardown) {
    unlink 'fft' if -f 'fft';
}

BEGIN { gsl_set_error_handler_off(); }

sub WAVETABLE_ALLOC_FREE: Tests {
    my $wavetable = gsl_fft_complex_wavetable_alloc(42);
    isa_ok($wavetable, 'Math::GSL::FFT' );
    gsl_fft_complex_wavetable_free($wavetable);
    ok(!$@, 'gsl_fft_complex_wavetable_free');
}

sub WORKSPACE_ALLOC_FREE: Tests {
    my $workspace = gsl_fft_complex_workspace_alloc(42);
    isa_ok($workspace, 'Math::GSL::FFT' );
    gsl_fft_complex_workspace_free($workspace);
    ok(!$@, 'gsl_fft_complex_workspace_free');
}

sub FFT_COMPLEX_RADIX2_FORWARD : Tests 
{
    local $TODO = "typemap for gsl_complex_packed_array";
    my $data = [ (1) x 10, (0) x 236, (1) x 10 ];
    my $status = gsl_fft_complex_radix2_forward ($data, 1, 128);
    print Dumper [ $status , $data ];
    ok(!$@, 'gsl_fft_complex_radix2_forward' );

}
1;
