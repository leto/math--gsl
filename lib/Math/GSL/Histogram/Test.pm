package Math::GSL::Histogram::Test;
use base q{Test::Class};
use Test::More;
use Math::GSL qw/:all/;
use Math::GSL::Histogram qw/:all/;
use Math::GSL::Errno qw/:all/;
use Data::Dumper;
use strict;

BEGIN{ gsl_set_error_handler_off(); }

sub make_fixture : Test(setup) {
    my $self = shift;
    $self->{H} = gsl_histogram_alloc( 100 );
}

sub teardown : Test(teardown) {
}

sub ALLOC_FREE : Tests {
    my $H = gsl_histogram_alloc( 100 );
    isa_ok($H, 'Math::GSL::Histogram' );
    gsl_histogram_free($H);
    ok(!$@, 'gsl_histogram_free');
}

sub SET_RANGES_UNIFORM : Tests {
    my $self = shift;
    ok_status(gsl_histogram_set_ranges_uniform($self->{H}, 0, 100), $GSL_SUCCESS);
    ok_status(gsl_histogram_set_ranges_uniform($self->{H}, 0, -100), $GSL_EINVAL);
}

sub SET_RANGES : Tests {
    my $self = shift;
    my $ranges = [ 0 .. 100 ]; 

    ok_status(gsl_histogram_set_ranges($self->{H}, $ranges, 100 + 1), $GSL_SUCCESS);
    ok_status(gsl_histogram_set_ranges($self->{H}, $ranges, 42), $GSL_EINVAL);
}

sub CLONE : Tests { 
    my $self = shift;
    local $TODO = "gsl_histogram_clone does not return a gsl_histogram_t";
    my $copy = gsl_histogram_clone($self->{H});
    isa_ok( $copy, 'Math::GSL::Histogram');
}

sub MEMCPY : Tests {
    my $self = shift;
    my $copy = gsl_histogram_alloc(100);

    ok_status(gsl_histogram_memcpy($copy, $self->{H}), $GSL_SUCCESS);

    my $bob = gsl_histogram_alloc(50);
    ok_status(gsl_histogram_memcpy($bob, $self->{H}), $GSL_EINVAL);

}

sub INCREMENT : Tests { 
    my $self = shift;
    gsl_histogram_set_ranges_uniform($self->{H}, 0, 100);

    ok_status(gsl_histogram_increment($self->{H}, 50.5 ), $GSL_SUCCESS);
    ok_status(gsl_histogram_increment($self->{H}, -150.5 ), $GSL_EDOM);
    ok_status(gsl_histogram_increment($self->{H}, 150.5 ), $GSL_EDOM);
}

sub GET : Tests { 
    my $self = shift;
    gsl_histogram_set_ranges_uniform($self->{H}, 0, 100);

    ok_status(gsl_histogram_increment($self->{H}, 50.5 ), $GSL_SUCCESS);
    cmp_ok(1,'==', gsl_histogram_get($self->{H}, 50 ) );
}

sub MIN_MAX : Tests {
    my $self = shift;
    gsl_histogram_set_ranges_uniform($self->{H}, 0, 100);
    ok_status(gsl_histogram_increment($self->{H}, 50.5 ), $GSL_SUCCESS);

    cmp_ok(100,'==', gsl_histogram_max($self->{H}));
    cmp_ok(0,'==', gsl_histogram_min($self->{H}));
}

sub MIN_VAL_MAX_VAL : Tests {
    my $self = shift;
    gsl_histogram_set_ranges_uniform($self->{H}, 0, 100);
    ok_status(gsl_histogram_increment($self->{H}, 50.5 ), $GSL_SUCCESS);

    cmp_ok(1,'==', gsl_histogram_max_val($self->{H}));
    cmp_ok(0,'==', gsl_histogram_min_val($self->{H}));
}

sub MEAN : Tests {
    my $self = shift;
    gsl_histogram_set_ranges_uniform($self->{H}, 0, 100);
    ok_status(gsl_histogram_increment($self->{H}, 50.5 ), $GSL_SUCCESS);
    ok_status(gsl_histogram_increment($self->{H}, 11.5 ), $GSL_SUCCESS);

    ok_similar(31, gsl_histogram_mean($self->{H}));
}

sub SUM : Tests {
    my $self = shift;
    gsl_histogram_set_ranges_uniform($self->{H}, 0, 100);
    ok_status(gsl_histogram_increment($self->{H}, 50.5 ), $GSL_SUCCESS);
    ok_status(gsl_histogram_increment($self->{H}, 11.5 ), $GSL_SUCCESS);
    ok_similar(2, gsl_histogram_sum($self->{H}));
}
42;
