package Math::GSL::Eigen::Test;
use base q{Test::Class};
use Test::More;
use Math::GSL          qw/:all/;
use Math::GSL::Test    qw/:all/;
use Math::GSL::Eigen   qw/:all/;
use Math::GSL::Matrix  qw/:all/;
use Math::GSL::Vector  qw/:all/;
use Math::GSL::Complex qw/:all/;
use Math::GSL::Machine qw/:all/;
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

sub GSL_EIGEN_HERM_ALLOC : Tests {
    my $eigen = gsl_eigen_herm_alloc(5);
    isa_ok($eigen, 'Math::GSL::Eigen');
}

sub GSL_EIGEN_HERMV_ALLOC : Tests {
    my $eigen = gsl_eigen_hermv_alloc(5);
    isa_ok($eigen, 'Math::GSL::Eigen');
}

sub GSL_EIGEN_NONSYMM_ALLOC : Tests {
    my $eigen = gsl_eigen_nonsymm_alloc(5);
    isa_ok($eigen, 'Math::GSL::Eigen');
}

sub GSL_EIGEN_NONSYMMV_ALLOC : Tests {
    my $eigen = gsl_eigen_nonsymmv_alloc(5);
    isa_ok($eigen, 'Math::GSL::Eigen');
}

sub GSL_EIGEN_GENSYMM_ALLOC : Tests {
    my $eigen = gsl_eigen_gensymm_alloc(5);
    isa_ok($eigen, 'Math::GSL::Eigen');
}

sub GSL_EIGEN_GENSYMMV_ALLOC : Tests {
    my $eigen = gsl_eigen_gensymmv_alloc(5);
    isa_ok($eigen, 'Math::GSL::Eigen');
}

sub GSL_EIGEN_GENHERM_ALLOC : Tests {
    my $eigen = gsl_eigen_genherm_alloc(5);
    isa_ok($eigen, 'Math::GSL::Eigen');
}

sub GSL_EIGEN_GENHERMV_ALLOC : Tests {
    my $eigen = gsl_eigen_genhermv_alloc(5);
    isa_ok($eigen, 'Math::GSL::Eigen');
}

sub GSL_EIGEN_GEN_ALLOC : Tests {
    my $eigen = gsl_eigen_gen_alloc(5);
    isa_ok($eigen, 'Math::GSL::Eigen');
}

sub GSL_EIGEN_GENV_ALLOC : Tests {
    my $eigen = gsl_eigen_genv_alloc(5);
    isa_ok($eigen, 'Math::GSL::Eigen');
}

sub GSL_EIGEN_SYMM : Tests {
    my $self = shift;
    my $m = gsl_matrix_alloc(2,2);
    gsl_matrix_set_identity($m);
    my $v = gsl_vector_alloc(2);
    ok_status(gsl_eigen_symm($m, $v, $self->{eigen}));
    map { is(gsl_vector_get($v, $_), 1) } (0..1);
}    

sub GSL_EIGEN_SYMMV : Tests {
    my $w = gsl_eigen_symmv_alloc(2);
    my $m = gsl_matrix_alloc(2,2);
    gsl_matrix_set($m, 0, 0, 2);
    gsl_matrix_set($m, 0, 1, 1);
    gsl_matrix_set($m, 1, 0, 1);
    gsl_matrix_set($m, 1, 1, 2);
    my $eval = gsl_vector_alloc(2);
    my $evec = gsl_matrix_alloc(2,2);
    ok_status(gsl_eigen_symmv($m, $eval, $evec, $w));
    is(gsl_vector_get($eval, 0), 3);
    is(gsl_vector_get($eval, 1), 1);
    my $x = gsl_matrix_get($evec, 0, 0);
    is (gsl_matrix_get($evec, 0, 1), -$x); #this is the eigenvector for the eigenvalue 1, which is the second eigenvalue in the $eval vector, but the GSL documentation says the first eigenvector should correspond to the first eigenvalue... where'e the error?
    is (sqrt($x**2+$x**2), 1);
    
    $x = gsl_matrix_get($evec, 1, 0);
    is (gsl_matrix_get($evec, 1, 1), $x);
    is (sqrt($x**2+$x**2), 1);

    my $v1 = gsl_vector_alloc(2);
    my $v2 = gsl_vector_alloc(2);
    gsl_matrix_get_col($v1, $evec, 0);
    gsl_matrix_get_col($v2, $evec, 1);
    gsl_vector_mul($v1, $v2);
    is(gsl_vector_get($v1, 0) + gsl_vector_get($v1, 1) , 0);
}

sub GSL_EIGEN_SYMMV_SORT : Tests {
    my $w = gsl_eigen_symmv_alloc(2);
    my $m = gsl_matrix_alloc(2,2);
    gsl_matrix_set($m, 0, 0, 2);
    gsl_matrix_set($m, 0, 1, 1);
    gsl_matrix_set($m, 1, 0, 1);
    gsl_matrix_set($m, 1, 1, 2);
    my $eval = gsl_vector_alloc(2);
    my $evec = gsl_matrix_alloc(2,2);
    ok_status(gsl_eigen_symmv($m, $eval, $evec, $w));
    ok_status(gsl_eigen_symmv_sort ($eval, $evec, $GSL_EIGEN_SORT_VAL_ASC));
    is(gsl_vector_get($eval, 0), 1);
    is(gsl_vector_get($eval, 1), 3);
    my $x = gsl_matrix_get($evec, 0, 0);
    ok_similar(gsl_matrix_get($evec, 0, 1), -$x);
    ok_similar(sqrt($x**2+$x**2), 1);
    
    $x = gsl_matrix_get($evec, 1, 0);
    ok_similar(gsl_matrix_get($evec, 1, 1), $x);
    ok_similar(sqrt($x**2+$x**2), 1);

    my $v1 = gsl_vector_alloc(2);
    my $v2 = gsl_vector_alloc(2);
    gsl_matrix_get_col($v1, $evec, 0);
    gsl_matrix_get_col($v2, $evec, 1);
    gsl_vector_mul($v1, $v2);
    is(gsl_vector_get($v1, 0) + gsl_vector_get($v1, 1) , 0);
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
    is (gsl_vector_get($vector, 0), 2+sqrt(6));
    is (gsl_vector_get($vector, 1), 2-sqrt(6));    
}
sub GSL_EIGEN_HERMV : Tests {
    my $matrix  = gsl_matrix_complex_alloc (2, 2);
    my $complex = gsl_complex_rect(3,0);
    gsl_matrix_complex_set($matrix, 0, 0, $complex);

    $complex = gsl_complex_rect(2,1);
    gsl_matrix_complex_set($matrix, 0, 1, $complex);

    $complex = gsl_complex_rect(2,-1);
    gsl_matrix_complex_set($matrix, 1, 0, $complex);

    $complex = gsl_complex_rect(1,0);
    gsl_matrix_complex_set($matrix, 1, 1, $complex);

    my $eigen  = gsl_eigen_hermv_alloc(2);
    my $vector = gsl_vector_alloc(2);
    my $evec = gsl_matrix_complex_alloc(2,2);
    is(gsl_eigen_hermv($matrix, $vector, $evec, $eigen), 0);
    is (gsl_vector_get($vector, 0), 2+sqrt(6));
    is (gsl_vector_get($vector, 1), 2-sqrt(6));

#    my $x = gsl_matrix_complex_get($evec, 1, 1);
#    ok_similar( [ gsl_parts($x) ], [-0.750532688285823, 0 ], "last row");
#    ok_similar( [ gsl_parts($x) ], [ 2/(-1+sqrt(6)), 1/(-1+sqrt(6)) ], "first value");

}  
 
sub GSL_EIGEN_NONSYMM : Tests {
    my $matrix  = gsl_matrix_alloc (2, 2);
    gsl_matrix_set($matrix, 0, 0, -12);
    gsl_matrix_set($matrix, 1, 0, 7);
    gsl_matrix_set($matrix, 0, 1, 65);
    gsl_matrix_set($matrix, 1, 1, 59);

    my $eigen  = gsl_eigen_nonsymm_alloc(2);
    my $vector = gsl_vector_complex_alloc(2);
    is(gsl_eigen_nonsymm($matrix, $vector, $eigen), 0);

    my $x = gsl_vector_complex_real($vector);
    my $y = gsl_vector_complex_imag($vector);

    # this interface seems hokey
    is_similar( gsl_vector_get($x->{vector}, 1), (47/2)+(0.5*sqrt(6861)) );
    is_similar( gsl_vector_get($y->{vector}, 1), 0 );
}

sub GSL_EIGEN_NONSYMM_Z : Tests {
    my $matrix  = gsl_matrix_alloc (2, 2);
    gsl_matrix_set($matrix, 0, 0, -12);
    gsl_matrix_set($matrix, 1, 0, 7);
    gsl_matrix_set($matrix, 0, 1, 65);
    gsl_matrix_set($matrix, 1, 1, 59);

    my $eigen  = gsl_eigen_nonsymm_alloc(2);
    my $vector = gsl_vector_complex_alloc(2);
    my $Z = gsl_matrix_alloc(2,2);
    is(gsl_eigen_nonsymm($matrix, $vector, $eigen), 0);
    is(gsl_eigen_nonsymm_Z($matrix,$vector, $Z, $eigen), 0);  
    ok(is_similar(gsl_matrix_get($Z, 0, 0), 0.9958842418254068860784291, 0.005));
    ok_similar(gsl_matrix_get($Z, 0, 1), 0.09063430301952179629793610, "Z matrix", 0.1);
    ok_similar(gsl_matrix_get($Z, 1, 1), 0.9958842418254068860784291, "Z matrix", 0.005);
    ok_similar(gsl_matrix_get($Z, 1, 0), 0.09063430301952179629793610, "Z matrix", 0.1);

    my $x = gsl_vector_complex_real($vector);
    my $y = gsl_vector_complex_imag($vector);

    # this interface seems hokey
    is_similar( gsl_vector_get($x->{vector}, 1), (47/2)+(0.5*sqrt(6861)) );
    is_similar( gsl_vector_get($y->{vector}, 1), 0 );
}

sub GSL_EIGEN_NONSYMMV_Z : Tests {
    my $matrix  = gsl_matrix_alloc (2, 2);
    gsl_matrix_set($matrix, 0, 0, -12);
    gsl_matrix_set($matrix, 1, 0, 7);
    gsl_matrix_set($matrix, 0, 1, 65);
    gsl_matrix_set($matrix, 1, 1, 59);

    my $evec = gsl_matrix_complex_alloc(2,2);
    my $eigen  = gsl_eigen_nonsymmv_alloc(2);
    my $vector = gsl_vector_complex_alloc(2);
    my $Z = gsl_matrix_alloc(2,2);
    ok_status(gsl_eigen_nonsymmv_Z($matrix,$vector, $evec, $Z, $eigen));  


    my $x = gsl_vector_complex_real($vector);
    my $y = gsl_vector_complex_imag($vector);

    # this interface seems hokey
    is_similar( gsl_vector_get($x->{vector}, 1), (47/2)+(0.5*sqrt(6861)) );
    is_similar( gsl_vector_get($y->{vector}, 1), 0 );

    $x = gsl_matrix_complex_get($evec, 1, 0);
    ok_similar(gsl_imag($x), 0, "evec matrix");
    ok_similar(gsl_real($x), 7/((71/2)+(.5*sqrt(6861))), "evec matrix", 0.01);
    
    $x = gsl_matrix_complex_get($evec, 0, 0);
    ok_similar(gsl_imag($x), 0, "evec matrix");
    ok_similar(gsl_real($x), 7/((71/2)-(.5*sqrt(6861))), "evec matrix", 0.19);

    $x = gsl_matrix_complex_get($evec, 0, 1);
    $y = gsl_matrix_complex_get($evec, 1, 1);

    ok_similar(gsl_imag($x), 0, "evec matrix");
    ok_similar(gsl_imag($y), 0, "evec matrix");

    local $TODO = "matlab differences";

    ok_similar(gsl_real($x), 1); # this is the value I get with maple
    ok_similar(gsl_real($y), 1); # this is the value I get with maple

    ok_similar([ gsl_matrix_get($Z, 0, 0)], [0.9958842418254068860784291] );
    ok_similar([ gsl_matrix_get($Z, 0, 1)], [0.09063430301952179629793610] );
    ok_similar([ gsl_matrix_get($Z, 1, 1)], [0.9958842418254068860784291] );
    ok_similar([ gsl_matrix_get($Z, 1, 0)], [0.09063430301952179629793610] );

}
Test::Class->runtests;
