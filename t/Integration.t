package Math::GSL::Integration::Test;
use Math::GSL::Test qw/:all/;
use base 'Test::Class';
use Test::More 'no_plan';
use Math::GSL qw/:all/;
use Math::GSL::Integration qw/:all/;
use Math::GSL::Errno qw/:all/;
use Test::Exception;
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
 

sub TEST_QAGS : Tests {
    my $self = shift;
    my ($status, $result, $abserr) = gsl_integration_qags (
                                sub { $_[0]**2} , 
                                0, 1, 0, 1e-7, 1000,
                                $self->{wspace}, 
                           );
    ok_status($status);
    my $res = abs($result - 1/3);
    ok_similar( 
        [$result], [1/3], 
        sprintf('gsl_integration_qags: res=%.18f, abserr=%.18f',$res,$abserr),
        $abserr
    );

    ($status, $result, $abserr) = gsl_integration_qags (
                                sub { 1/$_[0] } , 
                                1, 10, 0, 1e-7, 1000,
                                $self->{wspace}, 
                           );
    $res = abs($result - log 10);
    ok_similar( 
        [$result],[log 10], 
        sprintf('gsl_integration_qags: res=%.18f, abserr=%.18f',$res,$abserr),
        $abserr
    );

}
sub TEST_WORKSPACE_ALLOC : Tests { 
    my $self = shift;
    isa_ok($self->{wspace}, 'Math::GSL::Integration');
}

Test::Class->runtests;
