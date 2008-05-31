package Math::GSL::Complex::Test;
use base q{Test::Class};
use Test::More;
use Math::GSL::Complex qw/:all/;
use Math::GSL qw/:all/;
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
    ok_similar( [ gsl_parts($x) ], [ 5, 3 ], 'gsl_complex_rect' );
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
    ok_similar( [ gsl_parts($z) ], [ 6, 5 ], 'gsl_complex_add' );
}

sub GSL_COMPLEX_SUB : Tests {
    my $x = gsl_complex_rect(5,3);
    my $y = gsl_complex_rect(1,2);

    my $z = gsl_complex_sub($x, $y);
    ok_similar( [ gsl_parts($z) ], [ 4, 1 ], 'gsl_complex_sub' );
}

sub GSL_COMPLEX_MUL : Tests {
    my $x = gsl_complex_rect(5,3);
    my $y = gsl_complex_rect(1,2);

    my $z = gsl_complex_mul($x, $y);
    ok_similar( [ gsl_parts($z) ], [ -1, 13 ], 'gsl_complex_mul' );
}

sub GSL_COMPLEX_DIV : Tests {
    my $x = gsl_complex_rect(4,5);
    my $y = gsl_complex_rect(2,1);

    my $z = gsl_complex_div($x, $y);
    ok_similar( [ gsl_parts($z) ], [ 13/5, 6/5 ], 'gsl_complex_div' );
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
    ok_similar( [ gsl_parts($z) ], [ -6, 12 ], 'gsl_complex_mul_imag' );
}

sub GSL_COMPLEX_DIV_IMAG : Tests {
    my $x = gsl_complex_rect(6,4);

    my $z = gsl_complex_div_imag($x, 2); 
    ok_similar( [ gsl_parts($z) ], [ 2, -3 ], 'gsl_complex_div_imag' );
}

sub GSL_COMPLEX_CONJUGATE : Tests {
    my $x = gsl_complex_rect(6,4);

    my $z = gsl_complex_conjugate($x);
    ok_similar( [ gsl_parts($z) ], [6, -4], 'gsl_complex_conjugate');
}


sub GSL_COMPLEX_NEGATIVE : Tests {
    my $x = gsl_complex_rect(6,4);

    my $z = gsl_complex_negative($x);
    ok_similar( [ gsl_parts($z) ], [-6, -4], 'gsl_complex_negative');
}

sub GSL_COMPLEX_SQRT : Tests {
    my $x = gsl_complex_rect(-7,24);

    my $z = gsl_complex_sqrt($x);
    ok_similar( [ gsl_parts($z)  ], [ 3  , 4 ] ,'gsl_complex_sqrt'  );
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

    ok_similar( [ gsl_parts($z) ], [-1, 0 ], 'gsl_complex_pow' );

    $x = gsl_complex_rect(3,4);
    $z = gsl_complex_pow($x, $y);

    ok_similar( [gsl_parts($z) ], [ 3**2 - 4**2, 2*3*4 ], 'gsl_complex_pow' );
}

sub GSL_COMPLEX_SET_REAL : Tests { 
    my $x = gsl_complex_rect(3,4);
    gsl_set_real($x, 5);
    ok_similar(  [ gsl_parts($x) ], [ 5, 4 ], 'gsl_complex_set_real');
}

sub GSL_COMPLEX_SET_IMAG : Tests { 
    my $x = gsl_complex_rect(3,4);
    gsl_set_imag($x, 5);
    ok_similar(  [ gsl_parts($x) ], [ 3, 5 ], 'gsl_complex_set_imag');
}

sub GSL_COMPLEX_SET_COMPLEX : Tests {
    my $x = gsl_complex_rect(3,4);
    gsl_set_complex($x, 5, 3);
    ok_similar(  [ gsl_parts($x) ], [ 5, 3 ], 'gsl_complex_set_complex');
}

sub GSL_COMPLEX_SIN : Tests {
    my $x = gsl_complex_rect(3,2);
    my $z = gsl_complex_sin($x);

    ok_similar( [ gsl_parts($z)                       ], 
                [ 0.53092108624852, -3.59056458998578 ], 
                'gsl_complex_sin'
    );
}

sub GSL_COMPLEX_COS : Tests {
    my $x = gsl_complex_rect(3,2);
    my $z = gsl_complex_cos($x);
    ok_similar( [ gsl_parts($z)                       ], 
                [ -3.72454550491532, -0.511822569987385],
                'gsl_complex_cos'
    );
}

sub GSL_COMPLEX_TAN : Tests {
    my $x = gsl_complex_rect(3,2);
    my $z = gsl_complex_tan($x);
    ok_similar( [ gsl_parts($z)                       ], 
                [ -0.0098843750383225, 0.965385879022133 ], 
                'gsl_complex_tan'
    );
}

sub GSL_COMPLEX_SEC : Tests {
    my $x = gsl_complex_rect(3,2);
    my $z = gsl_complex_sec($x);
    ok_similar( [ gsl_parts($z)                          ], 
                [ -0.263512975158389, 0.0362116365587685 ],
                'gsl_complex_sec'
    );
}

sub GSL_COMPLEX_CSC : Tests {
    my $x = gsl_complex_rect(3,2);
    my $z = gsl_complex_csc($x);
    ok_similar( [ gsl_parts($z)                       ], 
                [ 0.0403005788568915, 0.27254866146294],
                'gsl_complex_csc'
    );
}

sub GSL_COMPLEX_COT : Tests {
    my $x = gsl_complex_rect(3,2);
    my $z = gsl_complex_cot($x);
    ok_similar( [ gsl_parts($z)                       ], 
                [ -0.0106047834703371, -1.035746637765],
                'gsl_complex_cot'
    );
}

42;
