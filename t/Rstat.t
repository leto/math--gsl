package Math::GSL::Rstat::Test;
use base q{Test::Class};
use Test::Most;
use Math::GSL           qw/:all/;
use Math::GSL::Test     qw/:all/;
use Math::GSL::Errno    qw/:all/;
use Data::Dumper;
use strict;
use warnings;

BEGIN {
    gsl_set_error_handler_off();

    my $version = gsl_version();
    my ($major, $minor, $tiny) = split /\./, $version;
    if ($major >= 2) {
        eval "use Math::GSL::Rstat qw/:all/";
        die $@ if @$;
    } else {
        plan skip_all => "Rstat doesn't exist in GSL < 2.0";
        exit(0);
    }
}

sub make_fixture : Test(setup) {
    my $self = shift;
    $self->{rstat}    = Math::GSL::Rstat::gsl_rstat_alloc();
    $self->{quantile} = Math::GSL::Rstat::gsl_rstat_quantile_alloc(0.5);
}

sub teardown : Test(teardown) {
    my $self = shift;
}

sub GSL_RSTAT_QUANTILE : Tests {
    my $self  = shift;
    my $rstat = $self->{quantile};
    isa_ok($rstat, "Math::GSL::Rstat");
    my @data = (17.2, 18.1, 16.5, 18.3, 12.6);
    map {
        my $status = gsl_rstat_quantile_add( $_, $rstat);
        ok_status($status);
    } @data;
    my $q = gsl_rstat_quantile_get($rstat);
    ok_similar($q, 16.5,"gsl_rstat_quantile_get=$q");
}

sub GSL_RSTAT : Tests {
    my $self  = shift;
    my $rstat = $self->{rstat};
    isa_ok($rstat, "Math::GSL::Rstat");

    my @data = (17.2, 18.1, 16.5, 18.3, 12.6);
    map {
        my $status = gsl_rstat_add( $_, $rstat);
        ok($status == $GSL_SUCCESS, "gsl_rstat_quantile_add");
    } @data;

    my $version = gsl_version();
    my ($major, $minor, $tiny) = split /\./, $version;

    my $mean     = gsl_rstat_mean($rstat);
    my $variance = gsl_rstat_variance($rstat);
    my $largest  = gsl_rstat_max($rstat);
    my $smallest = gsl_rstat_min($rstat);
    my $sd       = gsl_rstat_sd($rstat);
    my $sd_mean  = gsl_rstat_sd_mean($rstat);
    my $median   = gsl_rstat_median($rstat);
    my $skew     = gsl_rstat_skew($rstat);
    my $kurtosis = gsl_rstat_kurtosis($rstat);
    my $n        = gsl_rstat_n($rstat);
    my $eps      = 1e-3;

    if ($major >=2 and $minor >=2) {
        my $rms = gsl_rstat_rms($rstat);
        ok_similar( $rms, 16.669433,"The root mean squared is 16.66", $eps);
    }

    ok_similar( 16.54, $mean, "The sample mean is 16.54", $eps);
    ok_similar( 5.373, $variance, "The estimated variance is 5.373", $eps);
    ok_similar( 18.30, $largest, "The largest value is 18.3", $eps);
    ok_similar( 12.60, $smallest, "The smallest value is 12.6", $eps);
    ok_similar( $sd, 2.317973, "The standard deviation is 2.31", $eps);
    ok_similar( $sd_mean, 1.036629,"The sd_mean is 1.03", $eps);
    ok_similar( $median, 16.500000, "The median is 16.5", $eps);
    ok_similar( $skew, -0.829058, "The skew is -0.83", $eps);
    ok_similar( $kurtosis,-1.221703,"The kurtosis is -1.22", $eps);
    ok($n == 5, "n=5");

    my $status = gsl_rstat_reset($rstat);
    ok($status == $GSL_SUCCESS, "gsl_rstat_reset");
    $n = gsl_rstat_n($rstat);
    ok($n == 0, "n=0");

    gsl_rstat_free($rstat);
    ok(1,"gsl_rstat_free seemed to work");
}

Test::Class->runtests;
