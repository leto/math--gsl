package Math::GSL::QRNG::Test;
use base q{Test::Class};
use Test::More tests => 10;
use Math::GSL::QRNG  qw/:all/;
use Math::GSL::Test  qw/:all/;
use Math::GSL::Errno qw/:all/;
use Data::Dumper;
use strict;
BEGIN { gsl_set_error_handler_off() }

sub make_fixture : Test(setup) {
    my $self = shift;
    $self->{sobol} = gsl_qrng_alloc($gsl_qrng_sobol, 2);
}

sub teardown : Test(teardown) {
    my $self = shift;
}

sub GSL_QRNG_ALLOC : Tests {
    my $qrng = gsl_qrng_alloc($gsl_qrng_sobol, 2);
    isa_ok( $qrng, 'Math::GSL::QRNG');
}

sub GSL_QRNG_STATE_SIZE : Tests {
    my $self  = shift;
    my $state = gsl_qrng_state($self->{sobol});
    my $size  = gsl_qrng_size($self->{sobol});

    ok( defined $state, "state is defined");
    cmp_ok($state,'>',0 , 'state is positive and non-zero');

    ok( defined $size, "size is defined");
    cmp_ok($size,'>',0 , 'size is positive and non-zero');

}

sub GSL_QRNG_CLONE : Tests {
    my $self  = shift;
    my $droid = gsl_qrng_clone($self->{sobol});
    isa_ok($droid, 'Math::GSL::QRNG' );
}

sub GSL_QRNG_NAME : Tests {
    my $self = shift;
    my $name = gsl_qrng_name($self->{sobol});
    cmp_ok($name,'eq','sobol', 'gsl_qrng_name == sobol' );
}

sub GSL_QRNG_GET : Tests {
    my $self = shift;
    my ($status, @values)= gsl_qrng_get($self->{sobol});

    is ($status, $GSL_SUCCESS);
    ok_similar( [ 0.5, 0.5 ], \@values, 'gsl_qrng_get returns multiple values' );

    ($status, @values)= gsl_qrng_get($self->{sobol});
    ok_similar( [ 0.75, 0.25 ], \@values, 'gsl_qrng_get returns correct values for sobol' );
}

Test::Class->runtests;

