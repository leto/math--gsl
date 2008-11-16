package Math::GSL::PowInt::Test;
use Math::GSL::Test qw/:all/;
use base q{Test::Class};
use Test::More;
use Math::GSL::PowInt qw/:all/;
use Math::GSL::Sys qw/gsl_posinf gsl_nan/; 
use Math::GSL qw/:all/;
use Data::Dumper;
use strict;

sub make_fixture : Test(setup) { }
sub teardown : Test(teardown) { }

sub TEST_BASIC: Tests {
    my %results = (
                'gsl_pow_2(3.14)'  => [ (3.14)**2 ],   
                'gsl_pow_2(3)'     => [ 3 ** 2 ],
                'gsl_pow_2(0)'     => [ 0 ** 2 ],
                'gsl_pow_2(-1)'    => [ (-1) ** 2 ],
                'gsl_pow_3(4)'     => [ 4 ** 3 ],
                'gsl_pow_4(5)'     => [ 5 ** 4 ],
                'gsl_pow_5(6)'     => [ 6 ** 5 ],
                'gsl_pow_6(7)'     => [ 7 ** 6 ],
                'gsl_pow_7(8)'     => [ 8 ** 7 ],
                'gsl_pow_8(-4)'    => [ (-4) ** 8 ],
                'gsl_pow_9(4)'     => [ 4 ** 9 ],
                'gsl_pow_int(5,10)'=> [ 5 ** 10 ],
    );
    verify(\%results, 'Math::GSL::PowInt');
}

sub TEST_NAN_INF : Tests {
    my $self = shift; 
    $main::nan    = gsl_nan();
    $main::posinf = gsl_posinf();
    my %results = (
        q{gsl_pow_2($main::nan)}    => [ $main::nan ],
        q{gsl_pow_2($main::posinf)} => [ $main::posinf ],
    );
    verify(\%results,'Math::GSL::PowInt');
}

Test::Class->runtests;
