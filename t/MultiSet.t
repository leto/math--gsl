package Math::GSL::MultiSet::Test;
use base q{Test::Class};

use Test::Most;

use strict;
use warnings;

use Math::GSL           qw/:all/;
use Math::GSL::Test     qw/:all/;
use Math::GSL::MultiSet qw/:all/;
use Math::GSL::Errno qw/:all/;


BEGIN{ gsl_set_error_handler_off(); }

sub teste : Test {
	ok 1;
}

Test::Class->runtests;
