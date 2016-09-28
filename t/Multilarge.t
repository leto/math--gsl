package Math::GSL::Multilarge::Test;
use base q{Test::Class};
use Test::More tests => 1;
use Math::GSL           qw/:all/;
use Math::GSL::BLAS     qw/:all/;
use Math::GSL::Test     qw/:all/;
use Math::GSL::Errno    qw/:all/;
use Math::GSL::Matrix   qw/:all/;
use Math::GSL::Vector   qw/:all/;
use Math::GSL::Machine  qw/:all/;
use Math::GSL::Multifit qw/:all/;
use Data::Dumper;
use strict;
use warnings;

BEGIN {
    my $version= gsl_version();
    my ($major, $minor) = split /\./, $version;
    if ($major >= 2 && $minor >= 1) {
        eval "use Math::GSL::Multilarge qw/:all/";
    } else {
        ok(1,"Multilarge added in GSL 2.1");
        exit(0);
    }
}


BEGIN { gsl_set_error_handler_off() }

sub make_fixture : Test(setup) {
}

sub teardown : Test(teardown) {
}

sub GSL_MULTILARGE_LINEAR_ALLOC : Tests {
    my $type  = Math::GSL::Multilarge::gsl_multilarge_linear_type->new;
    isa_ok($type, 'Math::GSL::Multilarge::gsl_multilarge_linear_type');


    # This coredumps
    # my $multi = Math::GSL::Multilarge::gsl_multilarge_linear_alloc($type,16);
    # isa_ok($multi, 'Math::GSL::Multilarge');
}

Test::Class->runtests;
