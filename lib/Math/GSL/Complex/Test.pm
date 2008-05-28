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

    my $abs = gsl_complex_abs($x);
    is ( $abs, sqrt(34));
}

sub GSL_COMPLEX_ABS2 : Tests {
    my $x = Math::GSL::Complex->new(5,3);
    isa_ok( $x, 'Math::GSL::Complex' );

    my $abs = gsl_complex_abs2($x);
    is ( $abs, 34);
}

#sub GSL_COMPLEX_LOGABS : Tests {
#    my $x = Math::GSL::Complex->new(5,3);
#    isa_ok( $x, 'Math::GSL::Complex' );
#
#    my $abs = gsl_complex_logabs($x);
#    is ( $abs, log(gsl_complex_abs($x))); #doesn't work, what is supposed to be the output?
#}

sub GSL_COMPLEX_ADD : Tests {
    my $x = Math::GSL::Complex->new(5,3);
    my $y = Math::GSL::Complex->new(1,2);
    isa_ok( $x, 'Math::GSL::Complex' );
    isa_ok( $y, 'Math::GSL::Complex' );

    my $abs = gsl_complex_add($x, $y);
    is ( $abs->real, 6);
    is ( $abs->imag, 5);
}

sub GSL_COMPLEX_SUB : Tests {
    my $x = Math::GSL::Complex->new(5,3);
    my $y = Math::GSL::Complex->new(1,2);
    isa_ok( $x, 'Math::GSL::Complex' );
    isa_ok( $y, 'Math::GSL::Complex' );

    my $abs = gsl_complex_sub($x, $y);
    is ( $abs->real, 4);
    is ( $abs->imag, 1);
}

sub GSL_COMPLEX_MUL : Tests {
    my $x = Math::GSL::Complex->new(5,3);
    my $y = Math::GSL::Complex->new(1,2);
    isa_ok( $x, 'Math::GSL::Complex' ); 
    isa_ok( $y, 'Math::GSL::Complex' );

    my $abs = gsl_complex_mul($x, $y);
    is ( $abs->real, 5);
    is ( $abs->imag, 6);
}

sub GSL_COMPLEX_DIV : Tests {
    my $x = Math::GSL::Complex->new(4,5);
    my $y = Math::GSL::Complex->new(2,1);
    isa_ok( $x, 'Math::GSL::Complex' );
    isa_ok( $y, 'Math::GSL::Complex' );

    my $abs = gsl_complex_div($x, $y);
    is ( $abs->real, 2);
    is ( $abs->imag, 5);
}

sub GSL_COMPLEX_ADD_REAL : Tests {
    my $x = Math::GSL::Complex->new(5,3);
    isa_ok( $x, 'Math::GSL::Complex' );

    my $abs = gsl_complex_add_real($x, 1);
    is ( $abs->real, 6);
}

sub GSL_COMPLEX_SUB_REAL : Tests {
    my $x = Math::GSL::Complex->new(5,3);
    isa_ok( $x, 'Math::GSL::Complex' );

    my $abs = gsl_complex_sub_real($x, 1);
    is ( $abs->real, 4);
}

sub GSL_COMPLEX_MUL_REAL : Tests {
    my $x = Math::GSL::Complex->new(5,3);
    isa_ok( $x, 'Math::GSL::Complex' );

    my $abs = gsl_complex_mul_real($x, 2);
    is ( $abs->real, 10);
}

sub GSL_COMPLEX_DIV_REAL : Tests {
    my $x = Math::GSL::Complex->new(6,3);
    isa_ok( $x, 'Math::GSL::Complex' );

    my $abs = gsl_complex_div_real($x, 2);
    is ( $abs->real, 3);
}

42;
