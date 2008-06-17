package Math::GSL::Linalg::Test;
use base q{Test::Class};
use Test::More;
use Math::GSL::Linalg qw/:all/;
use Math::GSL::Matrix qw/:all/;
use Math::GSL::Permutation qw/:all/;
use Math::GSL::Vector qw/:all/;
use Math::GSL qw/:all/;
use Data::Dumper;
use Math::GSL::Errno qw/:all/;
use strict;

sub make_fixture : Test(setup) {
    my $self = shift;
    $self->{matrix} = gsl_matrix_alloc(4, 4);
}

sub teardown : Test(teardown) {
    unlink 'linalg' if -f 'linalg';
}

sub GSL_LINALG_LU_DECOMP : Tests {
    my $self = shift;
    map { gsl_matrix_set($self->{matrix}, 0, $_, $_+1) } (0..3); 
    map { gsl_matrix_set($self->{matrix}, 1, $_, $_+5) } (0..3); 
    map { gsl_matrix_set($self->{matrix}, 2, $_, $_+9) } (0..3); 
    map { gsl_matrix_set($self->{matrix}, 3, $_, $_+13) } (0..3); 

    my $permutation = gsl_permutation_alloc(4);
    gsl_permutation_init($permutation);
    my ($result, $signum) = gsl_linalg_LU_decomp($self->{matrix}, $permutation);
    is_deeply( [ $result, $signum ], [ 0, 1] );
    map { is( gsl_matrix_get($self->{matrix}, 0, $_), $_+1) } (0..3); # I have no idea why these tests fail, I got my values for the LU decompositon from maple and they are valid...
    map { is( gsl_matrix_get($self->{matrix}, 2, $_), 0) } (2..3);
    is (gsl_matrix_get($self->{matrix}, 3, 3),0);
    is (gsl_matrix_get($self->{matrix}, 1, 0),5);
    is (gsl_matrix_get($self->{matrix}, 2, 0),9);
    is (gsl_matrix_get($self->{matrix}, 2, 1),2);
    is (gsl_matrix_get($self->{matrix}, 3, 0),13);
    is (gsl_matrix_get($self->{matrix}, 3, 1),3);
    is (gsl_matrix_get($self->{matrix}, 3, 2),0);
}

sub GSL_LINALG_LU_SOLVE : Tests {
    my $self = shift;
    gsl_matrix_set($self->{matrix}, 0, 0, 1);
    gsl_matrix_set($self->{matrix}, 0, 1, 1);
    gsl_matrix_set($self->{matrix}, 0, 2, 2);
    gsl_matrix_set($self->{matrix}, 0, 3, 1);

    gsl_matrix_set($self->{matrix}, 1, 0, 2);
    gsl_matrix_set($self->{matrix}, 1, 1, 3);
    gsl_matrix_set($self->{matrix}, 1, 2, -1);
    gsl_matrix_set($self->{matrix}, 1, 3, 2);

    gsl_matrix_set($self->{matrix}, 2, 0, 5);
    gsl_matrix_set($self->{matrix}, 2, 1, -1);
    gsl_matrix_set($self->{matrix}, 2, 2, 1);
    gsl_matrix_set($self->{matrix}, 2, 3, -1);

    gsl_matrix_set($self->{matrix}, 3, 0, 1);
    gsl_matrix_set($self->{matrix}, 3, 1, 0);
    gsl_matrix_set($self->{matrix}, 3, 2, 7);
    gsl_matrix_set($self->{matrix}, 3, 3, 1);

    my $b = gsl_vector_alloc(4);
    gsl_vector_set($b, 0, 4);
    gsl_vector_set($b, 1, 1);
    gsl_vector_set($b, 2, 2);
    gsl_vector_set($b, 3, 11);

    my $x = gsl_vector_alloc(4);

    my $permutation = gsl_permutation_alloc(4);
    gsl_permutation_init($permutation);
    gsl_linalg_LU_decomp($self->{matrix}, $permutation);
    gsl_linalg_LU_solve($self->{matrix}, $permutation, $b, $x);
    my $value = gsl_vector_get($x, 0);
    is (gsl_vector_get($x, 1), 3-10*$value);
    is (gsl_vector_get($x, 2), -2*$value+2); # I think this test fails due to the fact that perl round the last digit and not GSL
    is (gsl_vector_get($x, 3), 13*$value-3);
}
1;
