package Math::GSL::Wavelet::Test;
use base q{Test::Class};
use Test::More;
use Math::GSL::Errno;
use Math::GSL::Wavelet qw/:all/;
use Math::GSL qw/is_similar/;
use Data::Dumper;
use strict;

BEGIN{ Math::GSL::Errno::gsl_set_error_handler_off(); }

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

sub GSL_WAVELET_NEW : Tests {
    my $self = shift;
    isa_ok( $self->{wavelet}, 'Math::GSL::Wavelet', 'gsl_wavelet_alloc' );
    isa_ok( $self->{workspace}, 'Math::GSL::Wavelet', 'gsl_wavelet_workspace_alloc' );
}

sub GSL_WAVELET_TRANSFORM_FORWARD : Tests { 
    my $self = shift;

    my $array = _double_array([0..255]);
    my $status = gsl_wavelet_transform_forward ($self->{wavelet},$array,1.0, 256, $self->{workspace} ); 
    ok( !$status , 'gsl_wavelet_transform_forward' );
}

sub GSL_WAVELET_TRANSFORM_INVERSE : Tests { 
    my $self = shift;

    my $array = _double_array([0..255]);
    my $status = gsl_wavelet_transform_inverse ($self->{wavelet},$array,1.0, 256, $self->{workspace} ); 
    ok( !$status , 'gsl_wavelet_transform_inverse' );
}

sub GSL_WAVELET_NAME : Tests {
    my $self = shift;
    ok( gsl_wavelet_name($self->{wavelet}) eq 'daubechies', 'gsl_wavelet_name' );

}
sub _double_array {
    my ($vals) = @_;
    my $i=0;
    my $array = Math::GSL::Wavelet::new_doubleArray(scalar @$vals); 
    map { Math::GSL::Wavelet::doubleArray_setitem( $array, $i++, $_) }  @$vals; 
    return $array;
}

1;
