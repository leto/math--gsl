package Math::GSL::SparseMatrix::Test;
use base 'Test::Class';
use Test::Most;
use Math::GSL          qw/:all/;
use Math::GSL::Matrix  qw/:all/;
use Math::GSL::Errno   qw/:all/;
use Math::GSL::Test    qw/:all/;
use Data::Dumper;
use strict;
use warnings;

BEGIN{ gsl_set_error_handler_off() };

BEGIN {
    my $version= gsl_version();
    my ($major, $minor) = split /\./, $version;
    if ($major >= 2 && $minor >= 0) {
        eval "use Math::GSL::SparseMatrix qw/:all/";
        die $@ if @$;
    } else {
        plan skip_all => "SparseMatrix was added in GSL 2.0";
        exit(0);
    }
}

sub make_fixture : Test(setup) {
    my $self = shift;
}

sub teardown : Test(teardown) {
    my $self = shift;
}

sub TEST_SPARSE_TRANSPOSE_MEMCPY : Tests {
    my $sparse1 = gsl_spmatrix_alloc(100,100);
    gsl_spmatrix_set($sparse1, 12, 34, 42 );
    my $sparse2 = gsl_spmatrix_alloc(100,100);

    my $status = gsl_spmatrix_transpose_memcpy($sparse2, $sparse1);
    ok_status($status);

    my $value = gsl_spmatrix_get($sparse2, 34, 12);
    ok_similar($value, 42, 'gsl_spmatrix_transpose_memcpy seems to work');
}

sub TEST_SPARSE_TRANSPOSE : Tests {
    my $version= gsl_version();
    my ($major, $minor) = split /\./, $version;
    # this was added in GSL 2.2
    if ($major >= 2 && $minor >= 2) {
        my $sparse = gsl_spmatrix_alloc(100,100);
        gsl_spmatrix_set($sparse,42,69,3.14);

        my $status1 = gsl_spmatrix_transpose($sparse);
        ok_status($status1);

        my $value = gsl_spmatrix_get($sparse,69,42);
        ok_similar($value, 3.14);

        my $status2 = gsl_spmatrix_transpose2($sparse);
        ok_status($status2);
    }
}

sub TEST_SPARSE_MEMCPY : Tests {
    my $sparse1 = gsl_spmatrix_alloc(100,100);
    gsl_spmatrix_set($sparse1, 50,50, 42 );
    my $sparse2 = gsl_spmatrix_alloc(100,100);

    my $status = gsl_spmatrix_memcpy($sparse2, $sparse1);
    ok_status($status);

    my $value = gsl_spmatrix_get($sparse2, 50, 50);
    ok_similar($value, 42, 'gsl_spmatrix_memcpy seems to work');
}

sub TEST_SPARSE_DENSE : Tests {
    my $self   = shift;
    my $sparse = gsl_spmatrix_alloc(100,100);
    my $dense  = gsl_matrix_alloc(100,100);
    gsl_matrix_set($dense,50,50, 42 );
    my $status = gsl_spmatrix_d2sp($sparse, $dense);
    ok_status($status);

    my $value  = gsl_spmatrix_get($sparse,50,50);
    ok_similar($value, 42, 'sparse value looks correct');

    $status = gsl_spmatrix_sp2d($dense, $sparse);
    ok_status($status);

    $value  = gsl_matrix_get($dense,50,50);
    ok_similar($value, 42, 'dense value looks correct');
}

sub TEST_SPARSE_COMPRESSED : Tests {
    my $version= gsl_version();
    my ($major, $minor) = split /\./, $version;
    # this was added in GSL 2.2
    if ($major >= 2 && $minor >= 2) {
        my $sparse = gsl_spmatrix_alloc(100,100);
        my $status = gsl_spmatrix_set($sparse,42, 69, 6666);
        ok_status($status);

        my $ccs    = gsl_spmatrix_ccs($sparse);
        my $crs    = gsl_spmatrix_crs($sparse);

        my $value6 = gsl_spmatrix_get($ccs,42,69);
        ok_similar($value6, 6666);

        my $value7 = gsl_spmatrix_get($ccs,42,69);
        ok_similar($value7, 6666);

        my $nnz2 = gsl_spmatrix_nnz($ccs);
        cmp_ok($nnz2, '==', 1, 'gsl_spmatrix_nnz on a ccs spmatrix');
        my $nnz3 = gsl_spmatrix_nnz($crs);
        cmp_ok($nnz3, '==', 1, 'gsl_spmatrix_nnz on a crs spmatrix');

        my $ptr = gsl_spmatrix_ptr($sparse, 42, 69);
        ok(1, "got ptr=$ptr");
    }
}

sub TEST_BASIC : Tests {
    my $self   = shift;
    my $sparse = gsl_spmatrix_alloc(100,100);
    my $value  = gsl_spmatrix_get($sparse,50,50);
    ok_similar($value,0);
    my $status = gsl_spmatrix_set($sparse,50,50,42.42);
    ok_status($status);
    my $value2 = gsl_spmatrix_get($sparse,50,50);
    ok_similar($value2, 42.42);

    my $status2 = gsl_spmatrix_set_zero($sparse);
    ok_status($status2);
    my $value3 = gsl_spmatrix_get($sparse,50,50);
    ok_similar($value3, 0);

    my $status6 = gsl_spmatrix_scale($sparse, 5);
    ok_status($status6);

    gsl_spmatrix_set($sparse, 42, 69, 6666);
    my $value5 = gsl_spmatrix_get($sparse,42,69);
    ok_similar($value5, 6666);

    gsl_spmatrix_set($sparse,5,5, -100.1234);
    my $nnz = gsl_spmatrix_nnz($sparse);
    cmp_ok($nnz, '==', 2, 'gsl_spmatrix_nnz = 2');

    my ($status7, $min, $max) = gsl_spmatrix_minmax($sparse);
    ok_similar( $min, -100.1234, 'gsl_spmatrix_minmax min');
    ok_similar( $max, 6666, 'gsl_spmatrix_minmax max');

    lives_ok { gsl_spmatrix_free($sparse) };
}

Test::Class->runtests;
