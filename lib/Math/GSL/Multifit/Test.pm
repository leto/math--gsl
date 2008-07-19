package Math::GSL::Multifit::Test;
use base q{Test::Class};
use Test::More;
use Math::GSL::Multifit qw/:all/;
use Math::GSL::Matrix qw/:all/;
use Math::GSL::Vector qw/:all/;
use Math::GSL::Machine qw/:all/;
use Math::GSL::Errno qw/:all/;
use Math::GSL qw/:all/;
use Data::Dumper;
use strict;

sub make_fixture : Test(setup) {
}

sub teardown : Test(teardown) {
}

sub GSL_MULTIFIT_LINEAR_ALLOC : Tests {
 my $multi = gsl_multifit_linear_alloc(2,2);
 isa_ok($multi, 'Math::GSL::Multifit');
}

sub GSL_MULTIFIT_LINEAR_EST : Tests {
 my $M = Math::GSL::Matrix->new(5,5);
 $M->set_row(0, [4.271520, -0.526675,  0.957930,  0.267750, -0.103610]);
 $M->set_row(1, [-0.526675,  5.701680, -0.098080,  0.641845,  0.429780]);
 $M->set_row(2, [0.957930, -0.098080,  4.584790,  0.375865,  1.510810]);
 $M->set_row(3, [0.267750,  0.641845,  0.375865,  4.422720,  0.392210]);
 $M->set_row(4, [-0.103610,  0.429780,  1.510810,  0.392210,  5.782750]);
 my $c = Math::GSL::Vector->new([-0.627020,   0.848674,   0.216877,  -0.057883,   0.596668]);
 my $x = Math::GSL::Vector->new([0.99932,   0.23858,   0.19797,   1.44008,  -0.15335]);
 my @got = gsl_multifit_linear_est($x->raw, $c->raw, $M->raw);
 is($got[0],0);
 ok(is_similar_relative($got[1], -5.56037032230000*(10**-1), 256*$GSL_DBL_EPSILON));
 ok(is_similar_relative($got[2], 3.91891123349318, 256*$GSL_DBL_EPSILON));
}

1;
