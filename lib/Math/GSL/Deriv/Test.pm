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

    isa_ok( $self->{gsl_func},'Math::GSL::Deriv::gsl_function_struct');
}

sub TEST_DERIV_CENTRAL_DIES : Tests { 
    my ($x,$h)=(10,0.01);
    throws_ok( sub {
               gsl_deriv_central( 'IAMNOTACODEREF', $x, $h); 
           },qr/not a reference value/, 'gsl_deriv_central borks when first arg is not a coderef');
}

sub AAA_TEST_DERIV_CENTRAL : Tests { 
    my ($status, $result, $abserr);
    my ($x,$h)=(10,0.01);
    my $self = shift;
    my @other;


    local $TODO = 'return value is not correct';
    ($status, $result, $abserr, @other) = gsl_deriv_central ( 
        sub {   my $x=shift; 
                print "IN ANON SUB in perl\n";
                print Dumper [$x] ;
                return $x ** 3 
            },
        $x, $h,
#       $result, $abserr
    ); 
    warn Dumper [ $status , $result, $abserr, \@other ];

    ok_status($status);
    #ok_similar( [$result], [3*$x], 'gsl_deriv_central returns correct value for anon sub' );
}

sub TEST_DERIV_CENTRAL_CALLS_THE_SUB : Tests { 
    my ($status, $result, $abserr);
    my ($x,$h)=(10,0.01);
    my $self = shift;

    throws_ok( sub {
                gsl_deriv_central ( sub { die "CALL ME BACK!"} , $x, $h)
            }, qr/CALL ME BACK/, 'gsl_deriv_central can call anon sub' );
}



1;
