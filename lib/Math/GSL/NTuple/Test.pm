package Math::GSL::NTuple::Test;
use base q{Test::Class};
use Test::More;
use Test::Exception;
use Math::GSL::NTuple qw/:all/; 
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
1;
