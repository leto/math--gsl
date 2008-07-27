package Math::GSL::Deriv::Test;
use base 'Test::Class';
use Test::More 'no_plan';
use Math::GSL qw/:all/;
use Math::GSL::Deriv qw/:all/;
use Math::GSL::Errno qw/:all/;
use Test::Exception;
use Data::Dumper;
use strict;
use warnings;

BEGIN{ gsl_set_error_handler_off() };

sub make_fixture : Test(setup) {
    my $self = shift;
    $self->{gsl_func} = Math::GSL::Deriv::gsl_function_struct->new;
}

sub teardown : Test(teardown) {
}

sub TEST_FUNCTION_STRUCT : Tests {
    my $self = shift;

    my $gsl_func = Math::GSL::Deriv::gsl_function_struct->new;

    isa_ok( $gsl_func,'Math::GSL::Deriv::gsl_function_struct');
}

sub TEST_DERIV_CENTRAL_DIES : Tests { 
    my ($x,$h)=(10,0.01);
    throws_ok( sub {
               gsl_deriv_central( 'IAMNOTACODEREF', $x, $h); 
           },qr/not a reference value/, 'gsl_deriv_central borks when first arg is not a coderef');
}
sub TEST_DERIV_CENTRAL: Tests { 
    my ($status, $result, $abserr);
    my ($x,$h)=(10,0.01);
    my $self = shift;
    my $gsl_func = $self->{gsl_func};

    ($status, $result, $abserr) = gsl_deriv_central ( $gsl_func, $x, $h); 
    ok_status( $status, $GSL_SUCCESS);
    ok_similar( $result, 2*$x, 'gsl_deriv_central works for a static function' );
}
sub TEST_SWIG_FUNCTION : Tests { 
    local $TODO  = "swig_function_set doesn't work";
    my $self     = shift;
    my $gsl_func = $self->{gsl_func};
    my ($x,$h)=(10,0.01);
    $gsl_func->swig_function_set( sub { die "I GOT CALLED!" } );
    my $func = $gsl_func->swig_function_get();
    ok( ref $func eq 'CODE', 'swig_function_get works' );

    $gsl_func->swig_params_set(42);
    my $params = $gsl_func->swig_params_get();
    ok(defined $params && $params == 42, 'swig_params_get works' );
}


1;
