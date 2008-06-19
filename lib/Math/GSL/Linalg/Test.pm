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
    ok_similar( [ map { gsl_matrix_get($self->{matrix}, 0, $_) } (2..3) ],
                [ 0, 0 ]
              );
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
    ok_similar( 
        [ map { gsl_vector_get($x, $_) } (1..3) ],
        [ 3-10*$value, -2*$value+2, 13*$value-3 ]
    );
}

sub GSL_LINALG_LU_SVX : Tests {
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

    my $x = gsl_vector_alloc(4);
    gsl_vector_set($x, 0, 4);
    gsl_vector_set($x, 1, 1);
    gsl_vector_set($x, 2, 2);
    gsl_vector_set($x, 3, 11);

    my $permutation = gsl_permutation_alloc(4);
    gsl_permutation_init($permutation);
    gsl_linalg_LU_decomp($self->{matrix}, $permutation);
    gsl_linalg_LU_svx($self->{matrix}, $permutation, $x);
    my $value = gsl_vector_get($x, 0);
    ok_similar( 
        [ map { gsl_vector_get($x, $_) } (1..3) ],
        [ 3-10*$value, -2*$value+2, 13*$value-3 ]
    );
}

sub GSL_LINALG_LU_INVERT : Tests {
    my $self = shift;
    map { gsl_matrix_set($self->{matrix}, 0, $_, $_+1) } (0..3);
 
    gsl_matrix_set($self->{matrix}, 1, 0, 2);
    gsl_matrix_set($self->{matrix}, 1, 1, 3);
    gsl_matrix_set($self->{matrix}, 1, 2, 4);
    gsl_matrix_set($self->{matrix}, 1, 3, 1);

    gsl_matrix_set($self->{matrix}, 2, 0, 3);
    gsl_matrix_set($self->{matrix}, 2, 1, 4);
    gsl_matrix_set($self->{matrix}, 2, 2, 1);
    gsl_matrix_set($self->{matrix}, 2, 3, 2);

    gsl_matrix_set($self->{matrix}, 3, 0, 4);
    gsl_matrix_set($self->{matrix}, 3, 1, 1);
    gsl_matrix_set($self->{matrix}, 3, 2, 2);
    gsl_matrix_set($self->{matrix}, 3, 3, 3);
    
    my $inverse = gsl_matrix_alloc(4,4);
    my $permutation = gsl_permutation_alloc(4);
    gsl_permutation_init($permutation);
    gsl_linalg_LU_decomp($self->{matrix}, $permutation);
    gsl_linalg_LU_invert($self->{matrix}, $permutation, $inverse);
    
    is (gsl_matrix_get($inverse, 0, 0), -9/40);
    is (gsl_matrix_get($inverse, 0, 1), 1/40);
    is (gsl_matrix_get($inverse, 0, 2), 1/40);
    is (gsl_matrix_get($inverse, 0, 3), 11/40);

    is (gsl_matrix_get($inverse, 1, 0), 1/40);
    is (gsl_matrix_get($inverse, 1, 1), 1/40);
    is (gsl_matrix_get($inverse, 1, 2), 11/40);
    is (gsl_matrix_get($inverse, 1, 3), -9/40);

    is (gsl_matrix_get($inverse, 2, 0), 1/40);
    is (gsl_matrix_get($inverse, 2, 1), 11/40);
    is (gsl_matrix_get($inverse, 2, 2), -9/40);
    is (gsl_matrix_get($inverse, 2, 3), 1/40);

    is (gsl_matrix_get($inverse, 3, 0), 11/40);
    is (gsl_matrix_get($inverse, 3, 1), -9/40);
    is (gsl_matrix_get($inverse, 3, 2), 1/40);
    is (gsl_matrix_get($inverse, 3, 3), 1/40);
}

sub GSL_LINALG_LU_DET : Tests {
    my $self = shift;
    map { gsl_matrix_set($self->{matrix}, 0, $_, $_+1) } (0..3);
 
    gsl_matrix_set($self->{matrix}, 1, 0, 2);
    gsl_matrix_set($self->{matrix}, 1, 1, 3);
    gsl_matrix_set($self->{matrix}, 1, 2, 4);
    gsl_matrix_set($self->{matrix}, 1, 3, 1);

    gsl_matrix_set($self->{matrix}, 2, 0, 3);
    gsl_matrix_set($self->{matrix}, 2, 1, 4);
    gsl_matrix_set($self->{matrix}, 2, 2, 1);
    gsl_matrix_set($self->{matrix}, 2, 3, 2);

    gsl_matrix_set($self->{matrix}, 3, 0, 4);
    gsl_matrix_set($self->{matrix}, 3, 1, 1);
    gsl_matrix_set($self->{matrix}, 3, 2, 2);
    gsl_matrix_set($self->{matrix}, 3, 3, 3);
    
    my $permutation = gsl_permutation_alloc(4);
    gsl_permutation_init($permutation);
    my ($result, $signum) = gsl_linalg_LU_decomp($self->{matrix}, $permutation);
    ok_similar(gsl_linalg_LU_det($self->{matrix}, $signum), 160);    
}

sub GSL_LINALG_LU_LNDET : Tests {
    my $self = shift;
    map { gsl_matrix_set($self->{matrix}, 0, $_, $_+1) } (0..3);
 
    gsl_matrix_set($self->{matrix}, 1, 0, 2);
    gsl_matrix_set($self->{matrix}, 1, 1, 3);
    gsl_matrix_set($self->{matrix}, 1, 2, 4);
    gsl_matrix_set($self->{matrix}, 1, 3, 1);

    gsl_matrix_set($self->{matrix}, 2, 0, 3);
    gsl_matrix_set($self->{matrix}, 2, 1, 4);
    gsl_matrix_set($self->{matrix}, 2, 2, 1);
    gsl_matrix_set($self->{matrix}, 2, 3, 2);

    gsl_matrix_set($self->{matrix}, 3, 0, 4);
    gsl_matrix_set($self->{matrix}, 3, 1, 1);
    gsl_matrix_set($self->{matrix}, 3, 2, 2);
    gsl_matrix_set($self->{matrix}, 3, 3, 3);
    
    my $permutation = gsl_permutation_alloc(4);
    gsl_permutation_init($permutation);
    gsl_linalg_LU_decomp($self->{matrix}, $permutation);
    ok_similar(gsl_linalg_LU_lndet($self->{matrix}), log(160));    
}

sub GSL_LINALG_QR_DECOMP : Tests {
    local $TODO ="the values doesn't seem to fit the value I got from maple. Probably the same problem than gsl_linalg_LU_decomp...";
    my $matrix = gsl_matrix_alloc(4,3);
    gsl_matrix_set($matrix, 0, 0, -3);
    gsl_matrix_set($matrix, 1, 0, 2);
    gsl_matrix_set($matrix, 2, 0, -5);
    gsl_matrix_set($matrix, 3, 0, 1);

    gsl_matrix_set($matrix, 0, 1, 2);
    gsl_matrix_set($matrix, 1, 1, 1);
    gsl_matrix_set($matrix, 2, 1, 2);
    gsl_matrix_set($matrix, 3, 1, -3);

    gsl_matrix_set($matrix, 0, 2, 4);
    gsl_matrix_set($matrix, 1, 2, -1);
    gsl_matrix_set($matrix, 2, 2, 4);
    gsl_matrix_set($matrix, 3, 2, 2);
   
    my $tau = gsl_vector_alloc(3);
    gsl_linalg_QR_decomp($matrix, $tau);
    
    is(gsl_matrix_get($matrix, 0, 0), sqrt(29));
    is(gsl_matrix_get($matrix, 1, 0), (-8/29)*sqrt(29));
    is(gsl_matrix_get($matrix, 2, 0), (35/29)*sqrt(29));
    is(gsl_matrix_get($matrix, 3, 0), (-1/29)*sqrt(29));
}

sub GSL_LINALG_CHOLESKY_DECOMP : Tests {
    my $self = shift;
    map{ gsl_matrix_set($self->{matrix}, 0, $_, $_+1)} (0..3);

    gsl_matrix_set($self->{matrix}, 1, 0, 2);
    gsl_matrix_set($self->{matrix}, 1, 1, 5);
    gsl_matrix_set($self->{matrix}, 1, 2, 8);
    gsl_matrix_set($self->{matrix}, 1, 3, 11);

    gsl_matrix_set($self->{matrix}, 2, 0, 3);
    gsl_matrix_set($self->{matrix}, 2, 1, 8);
    gsl_matrix_set($self->{matrix}, 2, 2, 14);
    gsl_matrix_set($self->{matrix}, 2, 3, 20);

    gsl_matrix_set($self->{matrix}, 3, 0, 4);
    gsl_matrix_set($self->{matrix}, 3, 1, 11);
    gsl_matrix_set($self->{matrix}, 3, 2, 20);
    gsl_matrix_set($self->{matrix}, 3, 3, 30);
   
    is(gsl_linalg_cholesky_decomp($self->{matrix}), 0);
    my $v = gsl_matrix_diagonal($self->{matrix});
    map { is(gsl_vector_get($v->{vector}, $_),1) } (0..3);
    is(gsl_matrix_get($self->{matrix}, 1, 0), 2);
    is(gsl_matrix_get($self->{matrix}, 2, 0), 3);
    is(gsl_matrix_get($self->{matrix}, 2, 1), 2);
    is(gsl_matrix_get($self->{matrix}, 3, 0), 4);
    is(gsl_matrix_get($self->{matrix}, 3, 1), 3);
    is(gsl_matrix_get($self->{matrix}, 3, 2), 2);   
}
sub GSL_LINALG_HESSENBERG_DECOMP_UNPACK_UNPACK_ACCUM_SET_ZERO : Tests { 
    my $self = shift;
 
    gsl_matrix_set($self->{matrix}, 1, 0, 3);
    gsl_matrix_set($self->{matrix}, 1, 1, 2);
    gsl_matrix_set($self->{matrix}, 1, 2, 5);
    gsl_matrix_set($self->{matrix}, 1, 3, -4);

    gsl_matrix_set($self->{matrix}, 1, 0, 5);
    gsl_matrix_set($self->{matrix}, 1, 1, -3);
    gsl_matrix_set($self->{matrix}, 1, 2, 6);
    gsl_matrix_set($self->{matrix}, 1, 3, 9);

    gsl_matrix_set($self->{matrix}, 2, 0, -2);
    gsl_matrix_set($self->{matrix}, 2, 1, 1);
    gsl_matrix_set($self->{matrix}, 2, 2, 5);
    gsl_matrix_set($self->{matrix}, 2, 3, 8);

    gsl_matrix_set($self->{matrix}, 3, 0, -6);
    gsl_matrix_set($self->{matrix}, 3, 1, 7);
    gsl_matrix_set($self->{matrix}, 3, 2, 2);
    gsl_matrix_set($self->{matrix}, 3, 3, -8);   
    my $tau = gsl_vector_alloc(4);
    is(gsl_linalg_hessenberg_decomp($self->{matrix}, $tau),0);
    my $U = gsl_matrix_alloc(4,4);
    is(gsl_linalg_hessenberg_unpack($self->{matrix}, $tau, $U),0);
    is(gsl_matrix_get($U, 0, 0), 1);
    map { is(gsl_matrix_get($U, $_, 0), 0) } (1..3);
    map { is(gsl_matrix_get($U, 0, $_), 0) } (1..3);
    is(gsl_matrix_get($U, 1, 1), -0.620173672946042309);
    is(gsl_matrix_get($U, 1, 2), -0.268847804615518438);
    is(gsl_matrix_get($U, 1, 3), 0.736956900597335762);
    is(gsl_matrix_get($U, 2, 1), 0.248069469178416908);
    is(gsl_matrix_get($U, 2, 2), -0.958442423454322956);
    is(gsl_matrix_get($U, 2, 3), -0.140888819231843737);
    is(gsl_matrix_get($U, 3, 1), 0.744208407535250749);
    is(gsl_matrix_get($U, 3, 2), 0.0954409706385089263);
    is(gsl_matrix_get($U, 3, 3), 0.661093690241727594);

    my $V = gsl_matrix_alloc(4,4);
    is(gsl_linalg_hessenberg_unpack_accum($self->{matrix}, $tau, $V), 0); #I don't know how to test the result of this function...

    is(gsl_linalg_hessenberg_set_zero($self->{matrix}), 0);
    my $line;
    for($line = 1; $line<4; $line++) {
    map { is(gsl_matrix_get($self->{matrix}, $line, $_), 0, "Set zero") } (0..$line-1); } #the matrix should have it's lower triangle filled with zero but it doesn't, why?
}

sub GSL_LINALG_BIDIAG_DECOMP_UNPACK_UNPACK2_UNPACK_B : Tests {
    my $self = shift;
    gsl_matrix_set($self->{matrix}, 1, 0, 3);
    gsl_matrix_set($self->{matrix}, 1, 1, 2);
    gsl_matrix_set($self->{matrix}, 1, 2, 5);
    gsl_matrix_set($self->{matrix}, 1, 3, -4);

    gsl_matrix_set($self->{matrix}, 1, 0, 5);
    gsl_matrix_set($self->{matrix}, 1, 1, -3);
    gsl_matrix_set($self->{matrix}, 1, 2, 6);
    gsl_matrix_set($self->{matrix}, 1, 3, 9);

    gsl_matrix_set($self->{matrix}, 2, 0, -2);
    gsl_matrix_set($self->{matrix}, 2, 1, 1);
    gsl_matrix_set($self->{matrix}, 2, 2, 5);
    gsl_matrix_set($self->{matrix}, 2, 3, 8);

    gsl_matrix_set($self->{matrix}, 3, 0, -6);
    gsl_matrix_set($self->{matrix}, 3, 1, 7);
    gsl_matrix_set($self->{matrix}, 3, 2, 2);
    gsl_matrix_set($self->{matrix}, 3, 3, -8);   
    my $tau_U = gsl_vector_alloc(4);
    my $tau_V = gsl_vector_alloc(3);

    is(gsl_linalg_bidiag_decomp($self->{matrix}, $tau_U, $tau_V),0);
    my $U = gsl_matrix_alloc(4,4);
    my $V = gsl_matrix_alloc(4,4);
    my $diag = gsl_vector_alloc(4);
    my $superdiag = gsl_vector_alloc(3);
    is(gsl_linalg_bidiag_unpack($self->{matrix}, $tau_U, $U, $tau_V, $V, $diag, $superdiag),0);
    is(gsl_matrix_get($V, 0, 0), 1);    
    map { is(gsl_matrix_get($V, $_, 0), 0) } (1..3); 
    map { is(gsl_matrix_get($V, 0, $_), 0) } (1..3);
    is(gsl_matrix_get($U, 1, 1), -0.609437002705849772);
    is(gsl_matrix_get($U, 1, 2), -0.758604748961341558); #doesn't fit the data I've got...
#    is(gsl_matrix_get($U, 1, 3), );
#    is(gsl_matrix_get($U, 2, 1), );
#    is(gsl_matrix_get($U, 2, 2), );
#    is(gsl_matrix_get($U, 2, 3), );
#    is(gsl_matrix_get($U, 3, 1), );
#    is(gsl_matrix_get($U, 3, 2), );
#    is(gsl_matrix_get($U, 3, 3), );

}

1;
