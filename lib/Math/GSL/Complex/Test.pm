package Math::GSL::Complex::Test;
use base q{Test::Class};
use Test::More;
use Math::GSL::Complex qw/gsl_complex_rect gsl_complex_polar/; 
use Math::GSL qw/is_similar/;
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
    ok( defined $x && $x->isa('Math::GSL::Complex'), 'gsl_complex' );
}
sub GSL_COMPLEX_RECT : Test(2) {
    my $self = shift;
    my $x = gsl_complex_rect(5,3);

    # my ($real,$imag) = ($x->real,$x->imag);
    my $real = Math::GSL::Complex::doubleArray_getitem($x->{dat}, 0);
    my $imag = Math::GSL::Complex::doubleArray_getitem($x->{dat}, 1);
    print "x=$real + $imag*I\n" if $ENV{DEBUG};
    ok( is_similar($real,5), 'gsl_complex_rect real'); 
    ok( is_similar($imag,3), 'gsl_complex_rect imag'); 
}
=head
sub GSL_COMPLEX_POLAR : Test(2) {
    my $self = shift;
    print <<WTF;
    This could be a bug in SWIG/GSL or just my stupidity, but
    can someone tell me why this test fails?
WTF

    my $x = $self->{gsl_complex};
    $x    = gsl_complex_polar(1.0,0.1);

    my $r     = Math::GSL::Complex::doubleArray_getitem($x->{dat}, 0);
    my $theta = Math::GSL::Complex::doubleArray_getitem($x->{dat}, 1);
    print "x=$r * e^(i $theta)*I\n" if $ENV{DEBUG};
    ok( is_similar($r,1.0),     'gsl_complex_polar r, res=' .($r-1.) . "\n"); 
    ok( is_similar($theta,0.1), 'gsl_complex_polar theta, res=' .($theta-0.1) . "\n");
}
=cut
42;
