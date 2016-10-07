package Math::GSL::Multilarge::Test;
use base q{Test::Class};
use Test::Most;
use Math::GSL           qw/:all/;
use Math::GSL::Min      qw/:all/;
use Math::GSL::Test     qw/:all/;
use Math::GSL::Errno    qw/:all/;
use Math::GSL::Matrix   qw/:all/;
use Math::GSL::Vector   qw/:all/;
use Math::GSL::Machine  qw/:all/;
use List::Util          qw/min/;
use Data::Dumper;
use strict;
use warnings;

BEGIN { gsl_set_error_handler_off() }
BEGIN {
    my $version= gsl_version();
    my ($major, $minor) = split /\./, $version;
    if ($major >= 2 && $minor >= 1) {
        eval "use Math::GSL::Multilarge qw/:all/";
        die $@ if @$;
    } else {
        plan skip_all => "Multilarge swig bindings don't like GSL < 2.1";
        exit(0);
    }
}

sub make_fixture : Test(setup) {
    my $self = shift;
}

sub teardown : Test(teardown) {
    my $self = shift;
}

# this is a rough translation of multilarge/test.c in the gsl source code
sub GSL_MULTILARGE_LINEAR_ALLOC : Tests {
    # TODO: why aren't things exported properly?
    my $normal = $Math::GSL::Multilarge::gsl_multilarge_linear_normal;
    my $multi  = Math::GSL::Multilarge::gsl_multilarge_linear_alloc($normal,16);
    isa_ok($multi, 'Math::GSL::Multilarge');
    my ($m,$n,$p) = (40,40,40);
    my $nblock    = 5;
    my $nrows     = $n / $nblock;
    my $X         = gsl_matrix_alloc($n, $p);
    my $Xs        = gsl_matrix_alloc($n, $p);
    my $y         = gsl_vector_alloc($n);
    my $ys        = gsl_vector_alloc($n);
    my $cs        = gsl_vector_alloc($p);
    my $LQR       = gsl_matrix_alloc($m, $p);
    my $Ltau      = gsl_vector_alloc($p);
    my $status    = Math::GSL::Multilarge::gsl_multilarge_linear_L_decomp($LQR, $Ltau);
    ok_status($status);

    my $rowidx = 0;
    my $lambda = 1e-1;
    while ( $rowidx < $n) {
        my $nleft  = $n - $rowidx;
        my $nr     = min($nrows, $nleft);
        my $Xv     = gsl_matrix_const_submatrix($X, $rowidx, 0, $nr, $p);
        my $yv     = gsl_vector_const_subvector($y, $rowidx, $nr);
        my $Xsv    = gsl_matrix_submatrix($Xs, 0, 0, $nr, $p);
        my $ysv    = gsl_vector_subvector($ys, 0, $nr);
        # TODO: GSL_MULTILARGE_LINEAR_ALLOC died (TypeError in method
        # 'gsl_multilarge_linear_accumulate', argument 1 of type 'gsl_matrix
        # *' at t/Multilarge.t line 64.)
        # my $status = Math::GSL::Multilarge::gsl_multilarge_linear_accumulate($Xsv, $ysv, $multi);
        $rowidx += $nr;
    }
    {
        my ($status,$rnorm,$snorm) = Math::GSL::Multilarge::gsl_multilarge_linear_solve($lambda, $cs, $multi);
        local $TODO = "still working on this";
        ok_status($status);
    }
}

Test::Class->runtests;
