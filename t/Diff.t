package Math::GSL::Diff::Test;
use strict;
use warnings;
use Math::GSL::Test qw/:all/;
use base q{Test::Class};
use Test::Most;
use Math::GSL::Diff qw/:all/;

BEGIN { Math::GSL::Diff::gsl_set_error_handler_off() }

sub make_fixture : Test(setup) {
}
sub teardown : Test(teardown) {
}

sub TEST_DIFF_CENTRAL : Tests {
    my ($success, $result, $error) = gsl_diff_central(sub { return $_[0]**(1.5)}, 2.0);
    ok_similar($result, 2.1213203435, "Testing Result");
    ok_similar($error, 0.01490, "Testing Error", 0.00001);


}

sub TEST_DIFF_FORWARD : Tests {
    my ($success, $result, $error) = gsl_diff_forward(sub { return $_[0]**(1.5)}, 0.0);
    ok_similar($result, 0.0012172897, "Testing Result");
    ok_similar($error, 0.05028, "Testing Error", 0.00001);
}   



Test::Class->runtests;
