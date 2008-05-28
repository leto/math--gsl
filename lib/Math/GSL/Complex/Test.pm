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
    my $x = gsl_complex_rect(5,3);
    is_deeply( [ gsl_parts($x) ], [ 5, 3 ], 'gs_complex_rect' );
}

sub GSL_COMPLEX_POLAR : Tests {
    my $x           = gsl_complex_polar(1.0,0.1);
    my ($r,$theta)  = ( gsl_complex_abs($x), gsl_complex_arg($x) );

    print "x=$r * e^(i $theta)*I\n" if $ENV{DEBUG};
    ok( is_similar($r,1.0),     'gsl_complex_polar r, res=' .($r-1.) . "\n"); 
    ok( is_similar($theta,0.1), 'gsl_complex_polar theta, res=' .($theta-0.1) . "\n");
}

sub GSL_COMPLEX_ABS : Tests {
    my $x = gsl_complex_rect(5,3);
    my $abs = gsl_complex_abs($x);
    ok ( is_similar($abs, sqrt(34)), 'gsl_complex_abs');
}

sub GSL_COMPLEX_ABS2 : Tests {
    my $x = gsl_complex_rect(5,3);
    my $abs = gsl_complex_abs2($x);
    ok( is_similar($abs, 34), 'gsl_complex_abs2' );
}

sub GSL_COMPLEX_LOGABS : Tests {
    my $x = gsl_complex_rect(5,3);

    my $abs = gsl_complex_logabs($x);
    ok ( is_similar($abs, log(sqrt(34)) ), 'gsl_complex_logabs' );
}

sub GSL_COMPLEX_ADD : Tests {
    my $x = gsl_complex_rect(5,3);
    my $y = gsl_complex_rect(1,2);

    my $z = gsl_complex_add($x, $y);
    is_deeply( [ gsl_parts($z) ], [ 6, 5 ] );
}

sub GSL_COMPLEX_SUB : Tests {
    my $x = gsl_complex_rect(5,3);
    my $y = gsl_complex_rect(1,2);

    my $z = gsl_complex_sub($x, $y);
    is_deeply( [ gsl_parts($z) ], [ 4, 1 ] );
}

sub GSL_COMPLEX_MUL : Tests {
    my $x = gsl_complex_rect(5,3);
    my $y = gsl_complex_rect(1,2);

    my $z = gsl_complex_mul($x, $y);
    is_deeply( [ gsl_parts($z) ], [ -1, 13 ] );
}

sub GSL_COMPLEX_DIV : Tests {
    my $x = gsl_complex_rect(4,5);
    my $y = gsl_complex_rect(2,1);

    my $z = gsl_complex_div($x, $y);
    is_deeply( [ gsl_parts($z) ], [ 13/5, 6/5 ] );
}
sub GSL_COMPLEX_EQ : Tests {
    my $x = gsl_complex_rect(4,5);
    my $y = gsl_complex_rect(2,1);
    ok(! gsl_complex_eq($x,$y), 'gsl_complex_eq' );
    $y    = gsl_complex_rect(4,5);
    ok( gsl_complex_eq($x,$y), 'gsl_complex_eq' );
}
sub GSL_COMPLEX_ADD_REAL : Tests {
    my $x = gsl_complex_rect(5,3);

    my $z = gsl_complex_add_real($x, 1);
    ok( gsl_real($z) ==  6, 'gsl_complex_add_real');
}

sub GSL_COMPLEX_SUB_REAL : Tests {
    my $x = gsl_complex_rect(5,3);

    my $z = gsl_complex_sub_real($x, 1);
    ok( gsl_real($z) == 4, 'gsl_complex_sub_real');
}

sub GSL_COMPLEX_MUL_REAL : Tests {
    my $x = gsl_complex_rect(5,3);

    my $z = gsl_complex_mul_real($x, 2);
    ok( gsl_real($z) == 10, 'gsl_complex_mul_real');
}

sub GSL_COMPLEX_DIV_REAL : Tests {
    my $x = gsl_complex_rect(6,3);

    my $z = gsl_complex_div_real($x, 2);
    ok( gsl_real($z) == 3, 'gsl_complex_div_real');
}

42;
