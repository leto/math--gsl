package Math::GSL::Chebyshev::Test;
use strict;
use warnings;
use base q{Test::Class};
use Math::GSL::Chebyshev qw/:all/;
use Math::GSL::Test      qw/:all/;
use Math::GSL            qw/:all/;
use Test::More tests => 10;
use Data::Dumper;

sub make_fixture : Test(setup) {
    my $self = shift;
    $self->{cheb} = gsl_cheb_alloc(40);
}

sub teardown : Test(teardown) {
    my $self = shift;
    gsl_cheb_free($self->{cheb});
}

sub GSL_CHEB_ALLOC : Tests {
    my $self = shift;
    isa_ok($self->{cheb}, 'Math::GSL::Chebyshev');
}

sub GSL_CHEB_INIT : Tests { 
    my $self = shift;
    my $func = sub { my $x = shift; return sin(cos($x)) };

    ok_status(gsl_cheb_init( $self->{cheb}, $func, 0, 1));
}

sub GSL_CHEB_EVAL : Tests {
    my $self = shift;
    my $func = sub { my $x = shift; return sin(cos($x)) };

    gsl_cheb_init( $self->{cheb}, $func, 0, 1);
    ok_similar( [ sin(cos(0.5)) ], [gsl_cheb_eval($self->{cheb}, 0.5 ) ] );
}

sub GSL_CHEB_EVAL_ERR : Tests {
    my $self = shift;
    my $func = sub { my $x = shift; return sin(cos($x)) };

    gsl_cheb_init( $self->{cheb}, $func, 0, 1);
    my ($status,$result,$err) =  gsl_cheb_eval_err($self->{cheb}, 0.5 );
    ok_status($status);
    ok_similar( [ sin(cos(0.5)) ], [ $result ], 'gsl_cheb_eval_err result');
    ok( defined $err , 'error is defined');
}

sub GSL_CHEB_CALC_DERIV : Tests {
    my $self = shift;
    my $deriv = gsl_cheb_alloc(40);
    my $func = sub { my $x = shift; return sin(cos($x)) };
    gsl_cheb_init( $self->{cheb}, $func, 0, 1);
    ok_status(gsl_cheb_calc_deriv($deriv, $self->{cheb} ));
    isa_ok($deriv, 'Math::GSL::Chebyshev');
}

sub GSL_CHEB_CALC_INTEGRAL : Tests {
    my $self = shift;
    my $integral = gsl_cheb_alloc(40);
    my $func = sub { my $x = shift; return sin(cos($x)) };
    gsl_cheb_init( $self->{cheb}, $func, 0, 1);
    ok_status(gsl_cheb_calc_integ($integral, $self->{cheb} ));
    isa_ok($integral, 'Math::GSL::Chebyshev');
}
Test::Class->runtests;

1;
