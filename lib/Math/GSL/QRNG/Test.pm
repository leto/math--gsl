package Math::GSL::QRNG::Test;
use base q{Test::Class};
use Test::More;
use Math::GSL::QRNG qw/:all/;
use Math::GSL qw/:all/;
use Data::Dumper;
use Math::GSL::Errno qw/:all/;
use strict;

sub make_fixture : Test(setup) {
    my $self = shift;
    $self->{sobol} = gsl_qrng_alloc($gsl_qrng_sobol, 2);
}

sub teardown : Test(teardown) {
    my $self = shift;
    gsl_qrng_free($self->{sobol});
}

sub GSL_QRNG_ALLOC : Tests {
    my $qrng = gsl_qrng_alloc($gsl_qrng_sobol, 2);
    isa_ok( $qrng, 'Math::GSL::QRNG');
}

sub GSL_QRNG_STATE_SIZE : Tests {
    my $self = shift;
    my $state  = gsl_qrng_state($self->{sobol});
    my $size   = gsl_qrng_size($self->{sobol});
    ok( defined $state && $state >0 , 'gsl_qrng_state' );
    ok( defined $size && $size > 0, 'gsl_qrng_size' );
}

sub GSL_QRNG_CLONE : Tests {
    my $self = shift;
    my $droid = gsl_qrng_clone($self->{sobol});
    isa_ok($droid, 'Math::GSL::QRNG' );
}

sub GSL_QRNG_NAME : Tests {
    my $self = shift;
    my $name = gsl_qrng_name($self->{sobol});
    ok ($name eq 'sobol', 'gsl_qrng_name' );
}

sub GSL_QRNG_GET : Tests { 
    my $self = shift;
    my ($status, @values)= gsl_qrng_get($self->{sobol});

    is ($status, $GSL_SUCCESS);
    ok_similar( [ 0.5, 0.5 ], \@values, 'gsl_qrng_get returns multiple values' );
    ($status, @values)= gsl_qrng_get($self->{sobol});
    ok_similar( [ 0.75, 0.25 ], \@values, 'gsl_qrng_get returns correct values for sobol' );
}
1;
