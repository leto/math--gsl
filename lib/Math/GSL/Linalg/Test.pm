package Math::GSL::Linalg::Test;
use base q{Test::Class};
use Test::More;
use Math::GSL::Linalg qw/:all/;
use Math::GSL::Matrix qw/:all/;
use Math::GSL::Permutation qw/:all/;
use Math::GSL qw/:all/;
use Data::Dumper;
use Math::GSL::Errno qw/:all/;
use strict;

sub make_fixture : Test(setup) {
    my $self = shift;
    $self->{matrix} = gsl_matrix_alloc(5, 5);
}

sub teardown : Test(teardown) {
    unlink 'linalg' if -f 'linalg';
}

sub GSL_LINALG_LU_DECOMP : Tests {
    my $self = shift;

    for my $row (0..4) {
        map { gsl_matrix_set($self->{matrix}, $row, $_, $_) } (0..4); 
    }

    my $permutation = gsl_permutation_alloc(5);
    gsl_permutation_init($permutation);
    my ($result, $signum) = gsl_linalg_LU_decomp($self->{matrix}, $permutation);
    is_deeply( [ $result, $signum ], [ 0, 1] );
}

1;
