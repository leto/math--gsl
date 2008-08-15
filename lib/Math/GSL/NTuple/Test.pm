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

BEGIN{ gsl_set_error_handler_off(); }

END { warn "This is the end" }

sub make_fixture : Test(setup) {
    my $self = shift;
    my $size = int rand(100);
    $self->{size}   = $size;
    my $stuff       = [1..$size];

    $self->{ntuple} = gsl_ntuple_create('ntuple', $stuff ,$size);
    gsl_ntuple_write($self->{ntuple});
    gsl_ntuple_close($self->{ntuple});
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

sub GSL_NTUPLE_OPEN_CLOSE : Tests {
    my $self = shift;
    my $stuff = [];
    my $ntuple = gsl_ntuple_open('ntuple',$stuff, $self->{size} );
    isa_ok($ntuple,'Math::GSL::NTuple');
    ok_status(gsl_ntuple_close($ntuple));
}

sub GSL_NTUPLE_WRITE: Tests {
    my $self = shift; 
    my $data = [1..100];
    my $base = gsl_ntuple_create('ntuple', $data, 100);
    ok_status(gsl_ntuple_write($base));
    ok_status(gsl_ntuple_close($base));
}

sub GSL_NTUPLE_READ: Tests {
    my $self = shift; 
    my $data = [1..100];
    my $ntuple = gsl_ntuple_open('ntuple', $data, 100 );
    # why does this return an EOF?
    # perhaps gsl_ntuple_write is not doing it's job, so the file is empty...
    ok_status(gsl_ntuple_read($ntuple),$GSL_EOF);
    ok_status(gsl_ntuple_close($ntuple));
}
1;
