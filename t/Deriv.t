package Math::GSL::Deriv::Test;
use base 'Test::Class';
use Test::More tests => 13;
use Math::GSL        qw/:all/;
use Math::GSL::Test  qw/:all/;
use Math::GSL::Deriv qw/:all/;
use Math::GSL::Errno qw/:all/;
use Test::Exception;
use Data::Dumper;
use strict;

BEGIN{ gsl_set_error_handler_off() };

sub make_fixture : Test(setup) {
    my $self = shift;
    $self->{gsl_func} = Math::GSL::Deriv::gsl_function_struct->new;
}

sub teardown : Test(teardown) {
}

sub TEST_FUNCTION_STRUCT : Tests(1) {
    my $self = shift;

    isa_ok( $self->{gsl_func},'Math::GSL::Deriv::gsl_function_struct');
}

sub TEST_DERIV_CENTRAL_DIES : Tests(5) { 
    my ($x,$h)=(10,0.01);
    throws_ok( sub {
               gsl_deriv_central( 'IAMNOTACODEREF', $x, $h); 
           },qr/Undefined subroutine/, 'gsl_deriv_central borks when first arg is not a existing routine');
    throws_ok( sub {
               gsl_deriv_central( undef, $x, $h); 
           },qr/not a reference to code/, 'gsl_deriv_central borks when first arg is undef');
    throws_ok( sub {
               gsl_deriv_central( {}, $x, $h); 
           },qr/not a reference to code/, 'gsl_deriv_central borks when first arg is hash ref');
    throws_ok( sub {
               gsl_deriv_central( [], $x, $h); 
           },qr/is an empty array/, 'gsl_deriv_central borks when first arg is an empty array ref');
    throws_ok( sub {
               gsl_deriv_central( 'IAMNOTACODEREF', $x, $h); 
           },qr/Undefined subroutine/, 'gsl_deriv_central borks when first arg is not a existing routine');
}

sub TEST_DERIV_CENTRAL : Tests(2) { 
    my $self = shift;
    my ($x,$h)=(10,0.01);

    my ($status, $val,$err) = gsl_deriv_central ( sub { $_[0] ** 3 }, $x, $h,); 
    ok_status($status);
    my $res = abs($val-3*$x**2);
    ok( $res <= $err  , sprintf ("gsl_deriv_forward: res=%.18f, abserr=%.18f",$res, $err ));
}

sub TEST_DERIV_FORWARD : Tests(2) { 
    my $self = shift;

    my ($x,$h)=(10,0.01);
    my ($status, $val,$err) = gsl_deriv_forward ( sub { 2 * $_[0] ** 2 }, $x, $h,); 
    ok_status($status);
    my $res = abs($val-4*$x);
    ok( $res <= $err , sprintf ("gsl_deriv_forward: res=%.18f, abserr=%.18f",$res, $err ));
}

sub TEST_DERIV_BACKWARD : Tests(2) { 
    my $self = shift;
    my ($x,$h)=(10,0.01);
    my ($status, $val, $err) = gsl_deriv_backward ( sub { log $_[0] }, $x, $h,); 
    ok_status($status);
    my $res = abs($val-1/$x);
    ok( $res <= $err , sprintf ("gsl_deriv_backward: res=%.18f, abserr=%.18f",$res, $err ));
}

sub TEST_DERIV_CENTRAL_CALLS_THE_SUB : Tests(1) { 
    my $self = shift;
    my ($x,$h)=(10,0.01);

    throws_ok( sub {
                gsl_deriv_central ( sub { die "CALL ME BACK!"} , $x, $h)
            }, qr/CALL ME BACK/, 'gsl_deriv_central can call anon sub' );
}
Test::Class->runtests;
