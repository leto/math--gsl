package Math::GSL::Complex::Test;
use base q{Test::Class};
use Test::More;
use Math::GSL::Complex qw/:all/;
use Math::GSL qw/is_similar/;
use Data::Dumper;
use strict;

sub make_fixture : Test(setup) {
    my $self = shift;
    $self->{gsl_complex} = Math::GSL::Complex::gsl_complex->new;
}

sub teardown : Test(teardown) {
}

sub GSL_COMPLEX_NEW : Test {
    my $self = shift;
    my $x = $self->{gsl_complex};
    isa_ok( $x, 'Math::GSL::Complex' );
}

sub GSL_COMPLEX_RECT : Tests {
    my $x = Math::GSL::Complex->new(5,3);
    isa_ok( $x, 'Math::GSL::Complex' );

    my ($real,$imag) = ($x->real,$x->imag);
    print "x=$real + $imag*I\n" if $ENV{DEBUG};
    ok( is_similar($real,5), 'gsl_complex_rect real'); 
    ok( is_similar($imag,3), 'gsl_complex_rect imag'); 
}

sub GSL_COMPLEX_POLAR : Tests {
    my $x           = gsl_complex_polar(1.0,0.1);
    my ($r,$theta)  = ( gsl_complex_abs($x), gsl_complex_arg($x) );

    print "x=$r * e^(i $theta)*I\n" if $ENV{DEBUG};
    ok( is_similar($r,1.0),     'gsl_complex_polar r, res=' .($r-1.) . "\n"); 
    ok( is_similar($theta,0.1), 'gsl_complex_polar theta, res=' .($theta-0.1) . "\n");
}

sub GSL_COMPLEX_ABS : Tests {
    my $x = Math::GSL::Complex->new(5,3);
    isa_ok( $x, 'Math::GSL::Complex' );

    $abs = gsl_complex_abs($x);
    is ( $abs, sqrt(34));
}

sub GSL_COMPLEX_ABS2 : Tests {
    my $x = Math::GSL::Complex->new(5,3);
    isa_ok( $x, 'Math::GSL::Complex' );

    $abs = gsl_complex_abs2($x);
    is ( $abs, 34);
}

42;
