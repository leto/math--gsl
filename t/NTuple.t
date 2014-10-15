package Math::GSL::NTuple::Test;
use base q{Test::Class};
use Test::Most;
use Test::Exception;
use Math::GSL::NTuple qw/:all/;
use Math::GSL::Const  qw/:all/;
use Math::GSL::Errno  qw/:all/;
use Math::GSL::Test   qw/:all/;
use Data::Dumper;
use strict;

BEGIN{ gsl_set_error_handler_off(); }

END { warn "This is the end" }

sub make_fixture : Test(setup) {
    my $self = shift;
    my $size = 2 + int rand(10);
    $self->{size}   = $size;
    my $stuff       = [1..$size];

    my ($ntuple) = gsl_ntuple_create('ntuple', $stuff ,$size);
    $self->{ntuple} = $ntuple;
    gsl_ntuple_write($self->{ntuple});
    gsl_ntuple_close($self->{ntuple});
}

sub teardown : Test(teardown) {
    unlink 'ntuple' if -f 'ntuple';
}

sub GSL_NTUPLE_CREATE : Tests(2) {
    my $self = shift;
    isa_ok ($self->{ntuple}, 'Math::GSL::NTuple::gsl_ntuple');
    ok( -e 'ntuple', 'ntuple file created');
}

sub GSL_NTUPLE_OPEN_CLOSE : Tests(2) {
    my $self = shift;
    my $stuff = [];
    my $ntuple = gsl_ntuple_open('ntuple',$stuff, $self->{size} );
    isa_ok($ntuple,'Math::GSL::NTuple');
    ok_status(gsl_ntuple_close($ntuple));
}

sub GSL_NTUPLE_WRITE: Tests(2) {
    my $self = shift;
    my $data = [1..255];
    my $base = gsl_ntuple_create('ntuple', $data, 255);
    ok_status(gsl_ntuple_write($base));
    ok_status(gsl_ntuple_close($base));
}

sub GSL_NTUPLE_READ: Tests(2) {
    my $self = shift;
    my $data = [ (42) x $self->{size} ];
    my $ntuple = Math::GSL::NTuple::gsl_ntuple->new;
    $ntuple = gsl_ntuple_open('ntuple', $data, $self->{size} );

    ok_status(gsl_ntuple_read($ntuple));

    my $cdata = $ntuple->swig_ntuple_data_get ;
    # warn Dumper [ $data, $cdata ];
    ok_status(gsl_ntuple_close($ntuple));
}

sub GSL_NTUPLE_GSL_NTUPLE: Tests(1) {
    my $ntuple = Math::GSL::NTuple::gsl_ntuple->new;
    isa_ok($ntuple,'Math::GSL::NTuple::gsl_ntuple');
}

sub GSL_NTUPLE_OBJECT: Tests(2) {
    my $ntuple = Math::GSL::NTuple->new;
    isa_ok($ntuple,'Math::GSL::NTuple');
    isa_ok($ntuple->raw,'Math::GSL::NTuple::gsl_ntuple');
}

Test::Class->runtests;
