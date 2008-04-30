package Math::GSL::Poly::Test;
use base q{Test::Class};
use Test::More;
use Math::GSL::Poly qw/gsl_poly_eval/;
use Math::GSL qw/is_similar/;
use Data::Dumper;
use strict;

sub make_fixture : Test(setup) {
}
sub teardown : Test(teardown) {
}

sub GSL_POLY_EVAL : Test {
    my $y = gsl_poly_eval( 
                # when we have the proper typemaps, we won't need to manually
                # create arrays 
                # [ 3.14, 2.72, 5.55 ] ,
                _double_array( [ 3.14, 2.72, 5.55 ] ),
                3, 
                1.0
            );

    ok( is_similar($y,3.14+2.72+5.55) );
}

# this should be a typemap
sub _double_array {
    my ($vals) = @_;
    my $i=0;
    my $array = Math::GSL::Poly::new_doubleArray(scalar @$vals);

    map { Math::GSL::Poly::doubleArray_setitem( $array, $i++, $_) }  @$vals; 
    return $array;
}

42;
