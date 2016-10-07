package Math::GSL::SparseMatrix::Test;
use base 'Test::Class';
use Test::Most;
use Math::GSL          qw/:all/;
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

sub TEST_BASIC : Tests {
    my $self   = shift;
    my $sparse = gsl_spmatrix_alloc(100,100);
    my $value  = gsl_spmatrix_get($sparse,50,50);
    ok_similar($value,0);
    my $status = gsl_spmatrix_set($sparse,50,50,42.42);
    ok_status($status);
    my $value2 = gsl_spmatrix_get($sparse,50,50);
    ok_similar($value2, 42.42);

    lives_ok { gsl_spmatrix_free($sparse) };
}

Test::Class->runtests;
