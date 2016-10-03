package Math::GSL::Rstat::Test;
use base q{Test::Class};
use Test::More;
use Math::GSL           qw/:all/;
use Math::GSL::Rstat    qw/:all/;
use Math::GSL::Test     qw/:all/;
use Math::GSL::Errno    qw/:all/;
use Data::Dumper;
use strict;
use warnings;

BEGIN {
    gsl_set_error_handler_off();

    my $version= gsl_version();
    my ($major, $minor) = split /\./, $version;
    if ($major >= 2) {
        eval "use Math::GSL::Rstat qw/:all/";
    } else {
        plan skip_all => "Rstat doesn't exist in GSL < 2.0";
        exit(0);
    }
}

sub make_fixture : Test(setup) {
    my $self = shift;
    $self->{rstat} = gsl_rstat_alloc();
}

sub teardown : Test(teardown) {
    my $self = shift;
}

sub GSL_RSTAT : Tests {
    my $self  = shift;
    my $rstat = $self->{rstat};

    my @data = (17.2, 18.1, 16.5, 18.3, 12.6);
    map { gsl_rstat_add( $_, $rstat) } @data;

    my $mean     = gsl_rstat_mean($rstat);
    my $variance = gsl_rstat_variance($rstat);
    my $largest  = gsl_rstat_max($rstat);
    my $smallest = gsl_rstat_min($rstat);

    my $eps = 0.01;
    ok_similar( 16.54, $mean, "The sample mean is 16.54", $eps);
    ok_similar( 5.373, $variance, "The estimated variance is 5.373", $eps);
    ok_similar( 18.30, $largest, "The largest value is 18.3", $eps);
    ok_similar( 12.60, $smallest, "The smallest value is 12.6", $eps);

    gsl_rstat_free($rstat);
    ok(1,"gsl_rstat_free seemed to work");
}

Test::Class->runtests;
