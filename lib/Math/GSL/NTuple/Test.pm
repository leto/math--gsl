package Math::GSL::NTuple::Test;
use base q{Test::Class};
use Test::More;
use Test::Exception;
use Math::GSL::NTuple qw/:all/; 
use Math::GSL::Const qw/:all/; 
use Math::GSL::Errno qw/:all/; 
use Math::GSL qw/:all/;
use Data::Dumper;
use strict;

sub make_fixture : Test(setup) {
    my $self = shift;
    my $size = int rand(100);
    $self->{size}   = $size;
    $self->{ntuple} = gsl_ntuple_create('ntuple', [1..$size],$size);
}

sub teardown : Test(teardown) {
    unlink 'ntuple' if -f 'ntuple';
    unlink 'ntuple2' if -f 'ntuple2';
}

sub GSL_NTUPLE_CREATE : Tests {
    my $self = shift;
    isa_ok ($self->{ntuple}, 'Math::GSL::NTuple::gsl_ntuple');
    ok( -e 'ntuple', 'ntuple file created');
}

sub GSL_NTUPLE_OPEN : Test {
    my $self = shift;
    my $stuff = [];
    my $ntuple = gsl_ntuple_open('ntuple',$stuff, $self->{size} );
    isa_ok($ntuple,'Math::GSL::NTuple');
}

sub GSL_NTUPLE_WRITE_READ : Tests {
    my $self = shift; 
    my $base = gsl_ntuple_create('ntuple', [2,1,3],3);
    
    my $status = gsl_ntuple_write($base);
    ok_status($status, $GSL_SUCCESS);
    my $data = [];
    my $ntuple = gsl_ntuple_open('ntuple', $data, $self->{size});
    ok_similar($data, [2,1,3]);
}

1;
