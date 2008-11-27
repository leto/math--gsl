package Math::GSL::Integration::Test;
use base 'Test::Class';
use Test::More tests => 29;
use Test::Exception;
use Math::GSL              qw/:all/;
use Math::GSL::Test        qw/:all/;
use Math::GSL::Errno       qw/:all/;
use Math::GSL::Const       qw/:all/;
use Math::GSL::Integration qw/:all/;
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
sub TEST_CONSTANTS : Tests {
    ok(defined $GSL_INTEG_COSINE  , '$GSL_INTEG_COSINE');
    ok(defined $GSL_INTEG_SINE    , '$GSL_INTEG_SINE');
    ok(defined $GSL_INTEG_GAUSS15 , '$GSL_INTEG_GAUSS15'); 
    ok(defined $GSL_INTEG_GAUSS21 , '$GSL_INTEG_GAUSS21');
    ok(defined $GSL_INTEG_GAUSS31 , '$GSL_INTEG_GAUSS31');
    ok(defined $GSL_INTEG_GAUSS41 , '$GSL_INTEG_GAUSS41');
    ok(defined $GSL_INTEG_GAUSS51 , '$GSL_INTEG_GAUSS51');
    ok(defined $GSL_INTEG_GAUSS61 , '$GSL_INTEG_GAUSS61');
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
    my $integrator = 'gsl_integration_qagi';
    my $func = sub { my $x=shift; exp( -$x **2) };
    verify_integral($integrator, $func, sqrt($M_PI), 0, 1e-7);
    $func = sub { my $x = shift; 1/($x**2 + 1) };
    verify_integral($integrator, $func, $M_PI, 0, 1e-7);
}

sub TEST_QAGIU : Tests {
    my $self = shift;
    my ($status, $result, $abserr) = gsl_integration_qagiu (
                                sub { my $x=shift; log($x)/(1+100+$x**2) } , 
                                    0.0, 0.0, 1.0E-3, 1000,
                                $self->{wspace} 
                            );
    ok_status($status);
    ok_similar([$abserr],[ 3.016716913328831851E-06], "gsl_integration_qagiu absolute error",1e-5);

    my $integrator = 'gsl_integration_qagiu';    
    my $func = sub { my $x=shift; log($x)/(1+100+$x**2) };
    verify_integral($integrator, $func, 3.616892186127022568E-01, 0, 2e-3, 0);

    ok_similar([$result],[ 3.616892186127022568E-01], "gsl_integration_qagiu",2e-3);

}

sub verify_integral {
    my ($integrator,$func,$actual,$epsabs,$epsrel,$lower,$upper,$key) = @_;
    my $wspace = gsl_integration_workspace_alloc(1000);
    my $format = "$integrator: actual=%.9f relerr=%.18f abserr=%.18f";
    my ($status, $result, $abserr, @params);
    if ( $integrator eq 'gsl_integration_qag' ) {
         push @params, $func, $lower, $upper, $epsabs, $epsrel, 1000, $key, $wspace;
    } elsif ($integrator eq 'gsl_integration_qags' ) {
         push @params, $func, $lower, $upper, $epsabs, $epsrel, 1000, $wspace;
    } elsif ($integrator eq 'gsl_integration_qagi' ) {
         push @params, $func, $epsabs, $epsrel, 1000, $wspace;
    } elsif ($integrator eq 'gsl_integration_qagiu' ) {
         push @params, $func, $lower, $epsabs, $epsrel, 1000, $wspace;
    }
    { no strict 'refs'; ($status, $result, $abserr) = $integrator->( @params ) }
    ok_status($status);
    ok_similar( [$result], [$actual], 
        sprintf( $format,$actual,
            abs($result-$actual)/abs($actual),$abserr
        ), $epsrel
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

sub TEST_QNG : Tests {
    my ($status, $result, $abserr, $neval) = gsl_integration_qng (
                                sub { $_[0]**2} , 
                                0, 1, 0, 1e-7, 
                           );
    ok_status($status);
    my $res = abs($result - 1/3);
    ok( $neval > 0, 'returned number of evaluations');
    ok_similar( 
        [$result], [1/3], 
        sprintf('gsl_integration_qng: res=%.18f, abserr=%.18f',$res,$abserr),
       $abserr
    );
}

sub QAWS_ALLOC : Tests {
   my $table = gsl_integration_qaws_table_alloc(0, 0, 1, 0);
   isa_ok($table, 'Math::GSL::Integration');
}

sub QAWO_ALLOC : Tests {
   my $table = gsl_integration_qawo_table_alloc(10.0 * $M_PI, 1.0,$GSL_INTEG_SINE, 1000);
   isa_ok($table, 'Math::GSL::Integration'); 
}
Test::Class->runtests;
