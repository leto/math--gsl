package Math::GSL::Wavelet::Test;
use Math::GSL::Test qw/:all/;
use base q{Test::Class};
use Test::More;
use Math::GSL::Errno qw/:all/;
use Math::GSL::Wavelet qw/:all/;
use Math::GSL qw/:all/;
use Data::Dumper;
use Scalar::Util qw/blessed/;
use strict;

BEGIN{ gsl_set_error_handler_off(); }

sub make_fixture : Test(setup) {
    my $self = shift;
    $self->{wavelet}   = gsl_wavelet_alloc($gsl_wavelet_daubechies, 4);
    $self->{workspace} = gsl_wavelet_workspace_alloc(256);
}

sub teardown : Test(teardown) {
    my $self = shift;
    gsl_wavelet_free($self->{wavelet});
    gsl_wavelet_workspace_free($self->{workspace});
}

sub GSL_WAVELET_ALLOC_FREE : Tests {
    my $self = shift;
    isa_ok( $self->{wavelet}, 'Math::GSL::Wavelet', 'gsl_wavelet_alloc' );
    isa_ok( $self->{workspace}, 'Math::GSL::Wavelet', 'gsl_wavelet_workspace_alloc' );
}

sub GSL_WAVELET_TYPES : Tests { 

    ok( blessed $gsl_wavelet_bspline );
    ok( blessed $gsl_wavelet_bspline_centered );
    ok( blessed $gsl_wavelet_haar );
    ok( blessed $gsl_wavelet_haar_centered );
    ok( blessed $gsl_wavelet_daubechies );
    ok( blessed $gsl_wavelet_daubechies_centered);

}
sub GSL_WAVELET_TRANSFORM_FORWARD : Tests { 
    my $self = shift;

    my $status = gsl_wavelet_transform_forward ($self->{wavelet},[0..255],
             1.0, 256, $self->{workspace} ); 
    ok( $status == $GSL_SUCCESS , 'gsl_wavelet_transform_forward' );
}

sub GSL_WAVELET_TRANSFORM_INVERSE : Tests { 
    my $self = shift;

    my $status = gsl_wavelet_transform_inverse ($self->{wavelet},[0..255],1.0, 256, $self->{workspace} ); 
    ok( $status == $GSL_SUCCESS , 'gsl_wavelet_transform_inverse' );
}

sub GSL_WAVELET_NAME : Tests {
    my $self = shift;
    ok( gsl_wavelet_name($self->{wavelet}) eq 'daubechies', 'gsl_wavelet_name' );

}
Test::Class->runtests;
