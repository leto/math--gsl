package Math::GSL::Integration::Test;
use Math::GSL::Test qw/:all/;
use base 'Test::Class';
use Test::More 'no_plan';
use Math::GSL qw/:all/;
use Math::GSL::Integration qw/:all/;
use Math::GSL::Errno qw/:all/;
use Test::Exception;
use Math::GSL::Const qw/$M_PI/;
use Data::Dumper;
use strict;
use warnings;

BEGIN{ gsl_set_error_handler_off() };

sub make_fixture : Test(setup) {
    my $self = shift;
    $self->{wspace} = gsl_integration_workspace_alloc(1000);
}

sub teardown : Test(teardown) {
    my $self = shift;
    gsl_integration_workspace_free($self->{wspace});
}
 
sub TEST_QAG : Tests {
    my $self = shift;
    my ($status, $result, $abserr) = gsl_integration_qag (
                                sub { $_[0]**2} , 
                                0, 1, 0, 1e-7, 1000,
                                6, $self->{wspace}, 
                           );
    ok_status($status);
    my $res = abs($result - 1/3);
    ok_similar( 
        [$result], [1/3], 
        sprintf('gsl_integration_qag: res=%.18f, abserr=%.18f',$res,$abserr),
        $abserr
    );
}
sub TEST_QAGI : Tests {
    my $self = shift;
    my ($status, $result, $abserr);
    my $integrator = 'gsl_integration_qagi';
    my $func = sub { my $x=shift; exp( -$x **2) };
    my $format = "$integrator: res=%.18f, abserr=%.18f";

    {
    no strict 'refs';
    ($status, $result, $abserr) = $integrator->( $func, 0, 1e-7, 1000, $self->{wspace});
    }
    ok_status($status);
    my $actual = sqrt($M_PI);
    ok_similar( [$result], [$actual], 
        sprintf($format,abs($result-$actual),$abserr), $abserr
    );
}

sub TEST_QAG2 : Tests {
    my $self = shift;
    my ($status, $result, $abserr) = gsl_integration_qag (
                                sub { 1/$_[0] } , 
                                1, 10, 0, 1e-7, 1000,
                                5, $self->{wspace}, 
                           );
    ok_status($status);
    my $res = abs($result - log 10);
    ok_similar( 
        [$result],[log 10], 
        sprintf('gsl_integration_qags: res=%.18f, abserr=%.18f',$res,$abserr),
        $abserr
    );
}
# f1(x) = x^alpha * log(1/x) */
# integ(f1,x,0,1) = 1/(alpha + 1)^2 */

sub TEST_QAGS3 : Tests {
    my $self = shift;
    my ($status, $result, $abserr) = gsl_integration_qags (
                                sub { my $x=shift; $x ** 2 * log (1/$x) } , 
                                0, 1, 0, 1e-7, 1000,
                                $self->{wspace}, 
                           );
    ok_status($status);
    my $res = abs($result - 1/9);
    ok_similar( 
        [$result],[1/9], 
        sprintf('gsl_integration_qags: res=%.18f, abserr=%.18f',$res,$abserr),
        $abserr
    );
}


sub TEST_WORKSPACE_ALLOC : Tests { 
    my $self = shift;
    isa_ok($self->{wspace}, 'Math::GSL::Integration');
}

Test::Class->runtests;
