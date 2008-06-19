package Math::GSL::Eigen::Test;
use base q{Test::Class};
use Test::More;
use Math::GSL::Eigen qw/:all/;
use Math::GSL::Matrix qw/:all/;
use Math::GSL::Vector qw/:all/;
use Math::GSL::Complex qw/:all/;
use Data::Dumper;
use strict;

sub make_fixture : Test(setup) {
    my $self = shift;
    $self->{eigen} = gsl_eigen_symm_alloc(2);
}

sub teardown : Test(teardown) {
}

sub GSL_EIGEN_SYMM_ALLOC : Tests {
    my $self = shift;
    isa_ok($self->{eigen}, 'Math::GSL::Eigen');
}

sub GSL_EIGEN_SYMMV_ALLOC : Tests {
    my $eigen = gsl_eigen_symmv_alloc(5);
    isa_ok($eigen, 'Math::GSL::Eigen');
}

sub GSL_EIGEN_SYMM : Tests {
    my $self = shift;
    my $m->{matrix} = gsl_matrix_alloc(2,2);
    gsl_matrix_set_identity($m->{matrix});
    my $v->{vector} = gsl_vector_alloc(2);
    is(gsl_eigen_symm($m->{matrix}, $v->{vector}, $self->{eigen}),0);
    map { is(gsl_vector_get($v->{vector}, $_), 1) } (0..1);
}    

sub GSL_EIGEN_SYMMV : Tests {
    my $w->{eigen} = gsl_eigen_symmv_alloc(2);
    my $m->{matrix} = gsl_matrix_alloc(2,2);
    gsl_matrix_set($m->{matrix}, 0, 0, 2);
    gsl_matrix_set($m->{matrix}, 0, 1, 1);
    gsl_matrix_set($m->{matrix}, 1, 0, 1);
    gsl_matrix_set($m->{matrix}, 1, 1, 2);
    my $eval->{vector} = gsl_vector_alloc(2);
    my $evec->{matrix} = gsl_matrix_alloc(2,2);
    is(gsl_eigen_symmv($m->{matrix}, $eval->{vector}, $evec->{matrix}, $w->{eigen}),0);
    is(gsl_vector_get($eval->{vector}, 0), 3);
    is(gsl_vector_get($eval->{vector}, 1), 1);
    my $x = gsl_matrix_get($evec->{matrix}, 0, 0);
    is (gsl_matrix_get($evec->{matrix}, 0, 1), -$x); #this is the eigenvector for the eigenvalue 1, which is the second eigenvalue in the $eval vector, but the GSL documentation says the first eigenvector should correspond to the first eigenvalue... where'e the error?
    is (sqrt($x**2+$x**2), 1);
    
    $x = gsl_matrix_get($evec->{matrix}, 1, 0);
    is (gsl_matrix_get($evec->{matrix}, 1, 1), $x);
    is (sqrt($x**2+$x**2), 1);

    my $v1->{vector} = gsl_vector_alloc(2);
    my $v2->{vector} = gsl_vector_alloc(2);
    gsl_matrix_get_col($v1->{vector}, $evec->{matrix}, 0);
    gsl_matrix_get_col($v2->{vector}, $evec->{matrix}, 1);
    gsl_vector_mul($v1->{vector}, $v2->{vector});
    is(gsl_vector_get($v1->{vector}, 0) + gsl_vector_get($v1->{vector}, 1) , 0);
}

sub GSL_EIGEN_SYMMV_SORT : Tests {
    my $w->{eigen} = gsl_eigen_symmv_alloc(2);
    my $m->{matrix} = gsl_matrix_alloc(2,2);
    gsl_matrix_set($m->{matrix}, 0, 0, 2);
    gsl_matrix_set($m->{matrix}, 0, 1, 1);
    gsl_matrix_set($m->{matrix}, 1, 0, 1);
    gsl_matrix_set($m->{matrix}, 1, 1, 2);
    my $eval->{vector} = gsl_vector_alloc(2);
    my $evec->{matrix} = gsl_matrix_alloc(2,2);
    is(gsl_eigen_symmv($m->{matrix}, $eval->{vector}, $evec->{matrix}, $w->{eigen}),0);
    is(gsl_eigen_symmv_sort ($eval->{vector}, $evec->{matrix}, $GSL_EIGEN_SORT_VAL_ASC),0);
    is(gsl_vector_get($eval->{vector}, 0), 1);
    is(gsl_vector_get($eval->{vector}, 1), 3);
    my $x = gsl_matrix_get($evec->{matrix}, 0, 0);
    is (gsl_matrix_get($evec->{matrix}, 0, 1), -$x);
    is (sqrt($x**2+$x**2), 1);
    
    $x = gsl_matrix_get($evec->{matrix}, 1, 0);
    is (gsl_matrix_get($evec->{matrix}, 1, 1), $x);
    is (sqrt($x**2+$x**2), 1);

    my $v1->{vector} = gsl_vector_alloc(2);
    my $v2->{vector} = gsl_vector_alloc(2);
    gsl_matrix_get_col($v1->{vector}, $evec->{matrix}, 0);
    gsl_matrix_get_col($v2->{vector}, $evec->{matrix}, 1);
    gsl_vector_mul($v1->{vector}, $v2->{vector});
    is(gsl_vector_get($v1->{vector}, 0) + gsl_vector_get($v1->{vector}, 1) , 0);
}

sub GSL_EIGEN_HERM : Tests {
    my $matrix  = gsl_matrix_complex_alloc (2, 2);
    my $complex = gsl_complex_rect(3,0);
    gsl_matrix_complex_set($matrix, 0, 0, $complex);

    $complex = gsl_complex_rect(2,1);
    gsl_matrix_complex_set($matrix, 0, 1, $complex);

    $complex = gsl_complex_rect(2,-1);
    gsl_matrix_complex_set($matrix, 1, 0, $complex);

    $complex = gsl_complex_rect(1,0);
    gsl_matrix_complex_set($matrix, 1, 1, $complex);

    my $eigen  = gsl_eigen_herm_alloc(2);
    my $vector = gsl_vector_alloc(2);
    is(gsl_eigen_herm($matrix, $vector, $eigen), 0);
    is (gsl_vector_get($vector, 0), 1);
    is (gsl_vector_get($vector, 1), 3);    
}  
1;
