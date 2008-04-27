package Math::GSL::Complex::Test;
use base q{Test::Class};
use Test::More;
use Math::GSL::Complex;
use Math::GSL qw/is_similar/;

sub make_fixture : Test(setup) {
    my $self = shift;
    $self->{foo} = q{bar};
};

sub test_gsl_complex : Test {
    my $x =Math::GSL::Complex::gsl_complex->new;
    ok( defined $x && $x->isa('Math::GSL::Complex'), 'gsl_complex' );
}
sub test_gsl_complex_rect : Test(2) {
    my $x = Math::GSL::Complex::gsl_complex->new;
    $x = Math::GSL::Complex::gsl_complex_rect(5,3);

    my $real = Math::GSL::Complex::doubleArray_getitem($x->{dat}, 0);
    my $imag = Math::GSL::Complex::doubleArray_getitem($x->{dat}, 1);
    print "x=$real + $imag*I\n" if $ENV{DEBUG};
    ok( is_similar($real,5), 'gsl_complex_rect real'); 
    ok( is_similar($imag,3), 'gsl_complex_rect imag'); 
}
# next:
# gsl_complex gsl_complex_polar (double r, double theta)

42;
