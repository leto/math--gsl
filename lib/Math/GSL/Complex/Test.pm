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

sub GSL_COMPLEX_ADD_IMAG : Tests  {
    my $x = gsl_complex_rect(6,3);

    my $z = gsl_complex_add_imag($x, 2);
    ok( gsl_imag($z) == 5, 'gsl_complex_add_imag');
}

sub GSL_COMPLEX_SUB_IMAG : Tests {
    my $x = gsl_complex_rect(6,3);

    my $z = gsl_complex_sub_imag($x, 2);
    ok( gsl_imag($z) == 1, 'gsl_complex_sub_imag');
}

sub GSL_COMPLEX_MUL_IMAG : Tests {
    my $x = gsl_complex_rect(6,3);

    my $z = gsl_complex_mul_imag($x, 2);
    is_deeply( [ gsl_parts($z) ], [ -6, 12 ] );
}

sub GSL_COMPLEX_DIV_IMAG : Tests {
    my $x = gsl_complex_rect(6,4);

    my $z = gsl_complex_div_imag($x, 2); 
    is_deeply( [ gsl_parts($z) ], [ 2, -3 ] );
}

sub GSL_COMPLEX_CONJUGATE : Tests {
    my $x = gsl_complex_rect(6,4);

    my $z = gsl_complex_conjugate($x);
    ok( gsl_real($z) == 6, 'gsl_complex_conjugate');
    ok( gsl_imag($z) == -4, 'ggsl_complex_conjugat');
}


sub GSL_COMPLEX_NEGATIVE : Tests {
    my $x = gsl_complex_rect(6,4);

    my $z = gsl_complex_negative($x);
    ok( gsl_real($z) == -6, 'gsl_complex_negative');
    ok( gsl_imag($z) == -4, 'gsl_complex_negative');
}

sub GSL_COMPLEX_SQRT : Tests {
    my $x = gsl_complex_rect(-7,24);

    my $z = gsl_complex_sqrt($x);
    ok( is_similar(gsl_real($z),3), 'gsl_complex_sqrt');
    ok( is_similar(gsl_imag($z),4), 'gsl_complex_sqrt');
}

sub GSL_COMPLEX_SQRT_REAL : Tests {
    my $x = gsl_complex_rect(9,4);

    my $z = gsl_complex_sqrt_real(-4);
    ok( gsl_imag($z) == 2, 'gsl_complex_sqrt_real');
}

sub GSL_COMPLEX_POW : Tests {
    my $x = gsl_complex_rect(0,1);
    my $y = gsl_complex_rect(2,0);
    my $z = gsl_complex_pow($x, $y);

    my ($real, $imag)  = gsl_parts($z);
    ok( is_similar($real, -1), 'gsl_complex_pow' );
    ok( is_similar($imag, 0),  'gsl_complex_pow' );

    $x = gsl_complex_rect(3,4);
    $z = gsl_complex_pow($x, $y);

    ok( is_similar(gsl_real($z), 3**2 - 4**2), 'gsl_complex_pow');
    ok( is_similar(gsl_imag($z), 2*3*4), 'gsl_complex_pow'); 
}

sub GSL_COMPLEX_SET_REAL : Test: { 
    my $x = gsl_complex_rect(3,4);
    gsl_set_real($x, 5);
    ok( is_similar(gsl_real($x), 5), 'gsl_complex_set_real');
    ok( is_similar(gsl_imag($x), 4), 'gsl_complex_set_real');
}

sub GSL_COMPLEX_SET_IMAG : Test: { 
    my $x = gsl_complex_rect(3,4);
    gsl_set_imag($x, 5);
    ok( is_similar(gsl_imag($x), 5), 'gsl_complex_set_imag');
    ok( is_similar(gsl_real($x), 3), 'gsl_complex_set_imag');
}

42;
