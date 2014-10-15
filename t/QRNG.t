package Math::GSL::QRNG::Test;
use base q{Test::Class};
use Test::More tests => 24;
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

    my ($status, @values) = gsl_qrng_get($self->{sobol});

    is ($status, $GSL_SUCCESS);
    ok_similar( [ 0.5, 0.5 ], \@values, 'gsl_qrng_get returns multiple values' );

    ($status, @values) = gsl_qrng_get($self->{sobol});
    ok_similar( [ 0.75, 0.25 ], \@values, 'gsl_qrng_get returns correct values for sobol' );

    # Let's try with a bigger size generator
    my $tmp = gsl_qrng_alloc($gsl_qrng_sobol, 4);
    ($status, @values) = gsl_qrng_get($tmp);
    is (scalar(@values), 4, 'gsl_qrng_get returns correct number of samples');
}

sub GSL_QRNG_SOBOL : Tests {
    my $sobol = Math::GSL::QRNG::Sobol->new(2);
    isa_ok($sobol, "Math::GSL::QRNG::Sobol");
    isa_ok($sobol->{qrng}, "Math::GSL::QRNG");

    my @state = $sobol->get();
    ok_similar( [0.5, 0.5], \@state, "get returns correct number of samples");

    $sobol->reinit();
    @state = $sobol->get();
    ok_similar( [0.5, 0.5], \@state, "QRNG was reinitted");

    is($sobol->name(), "sobol", "QRNG name acessible");

    my $clone = $sobol->clone();
    isa_ok($clone, "Math::GSL::QRNG::Sobol");

    @state = $clone->get();
    ok_similar( [ 0.75, 0.25 ], \@state, 'clone clones the qrng status' );    
}

sub GSL_QRNG_HALTON : Tests {
    my $halton = Math::GSL::QRNG::Halton->new(2);
    isa_ok($halton, "Math::GSL::QRNG::Halton");

    my @state = $halton->get();
    ok_similar( [0.5, 0.333333333], \@state, "get returns correct number of samples");
}

sub GSL_QRNG_REVERSE_HALTON : Tests {
    my $rhalton = Math::GSL::QRNG::ReverseHalton->new(2);
    isa_ok($rhalton, "Math::GSL::QRNG::ReverseHalton");

    my @state = $rhalton->get();
    ok_similar( [0.5, 0.666666666], \@state, "get returns correct number of samples");
}

sub GSL_QRNG_NIEDERREITER2 : Tests {
    my $niederreiter2 = Math::GSL::QRNG::Niederreiter2->new(2);
    isa_ok($niederreiter2, "Math::GSL::QRNG::Niederreiter2");

    my @state = $niederreiter2->get();
    ok_similar( [0, 0], \@state, "get returns correct number of samples");
}

Test::Class->runtests;

