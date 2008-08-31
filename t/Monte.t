package Math::GSL::Monte::Test;
use Math::GSL::Test qw/:all/;
use base q{Test::Class};
use Test::More;
use Math::GSL::Monte qw/:all/;
use Math::GSL::Errno qw/:all/;
use Math::GSL qw/:all/;
use strict;

sub make_fixture : Test(setup) {
    my $self = shift;
    my $j          = 1 + int(rand(20));
    $self->{miser} = gsl_monte_miser_alloc($j);
    $self->{vegas} = gsl_monte_vegas_alloc($j);
    $self->{plain} = gsl_monte_plain_alloc($j);
    $self->{dim}   = $j;
}

sub teardown : Test(teardown) {
    my $self = shift;
    gsl_monte_miser_free($self->{miser});
    gsl_monte_plain_free($self->{plain});
    gsl_monte_vegas_free($self->{vegas});
}

sub TEST_INIT  : Tests {
    my $self = shift;
    ok_status( gsl_monte_plain_init($self->{plain}) );
    ok_status( gsl_monte_vegas_init($self->{vegas}) );
    ok_status( gsl_monte_miser_init($self->{miser}) );

}
sub TEST_ALLOC : Tests {
    my $self = shift;
    isa_ok($self->{miser},'Math::GSL::Monte');
    cmp_ok($self->{miser}->{dim},'==',$self->{dim});

    isa_ok($self->{vegas},'Math::GSL::Monte');
    cmp_ok($self->{vegas}->{dim},'==',$self->{dim});

    isa_ok($self->{plain},'Math::GSL::Monte');
    cmp_ok($self->{plain}->{dim},'==',$self->{dim});
}
Test::Class->runtests;
