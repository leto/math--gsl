package Math::GSL::SparseMatrix::Test;
use base 'Test::Class';
use Test::Most;
use Math::GSL          qw/:all/;
use Math::GSl::Matrix  qw/:all/;
use Math::GSL::Errno   qw/:all/;
use Math::GSL::Test    qw/:all/;
use Data::Dumper;
use strict;
use warnings;

BEGIN{ gsl_set_error_handler_off() };

BEGIN {
    my $version= gsl_version();
    my ($major, $minor) = split /\./, $version;
    if ($major >= 2 && $minor >= 1) {
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

sub TEST_SPARSE_DENSE : Tests {
    my $self   = shift;
    # Why won't Math::GSL::Matrix::* import properly?
    my $sparse = gsl_spmatrix_alloc(100,100);
    my $dense  = Math::GSL::Matrix::gsl_matrix_alloc(100,100);
    Math::GSL::Matrix::gsl_matrix_set($dense,50,50, 42 );
    my $status = gsl_spmatrix_d2sp($sparse, $dense);
    ok_status($status);

    my $value  = gsl_spmatrix_get($sparse,50,50);
    ok_similar($value, 42);

    $status = gsl_spmatrix_sp2d($dense, $sparse);
    ok_status($status);

    $value  = Math::GSL::Matrix::gsl_matrix_get($dense,50,50);
    ok_similar($value, 42);
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

    gsl_spmatrix_set($sparse,42,69,3.14);
    my $status3 = gsl_spmatrix_transpose($sparse);
    ok_status($status3);

    my $value4 = gsl_spmatrix_get($sparse,69,42);
    ok_similar($value4, 3.14);

    my $status4 = gsl_spmatrix_transpose2($sparse);

    my $status6 = gsl_spmatrix_scale($sparse, 5);
    ok_status($status6);

    my $value5 = gsl_spmatrix_get($sparse,42,69);
    ok_similar($value5, 3.14*5);

    lives_ok { gsl_spmatrix_free($sparse) };
}

Test::Class->runtests;
