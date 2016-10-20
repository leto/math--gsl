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

sub constructor : Test(5) {
	my ($k,$n) = (20,10);
	my $ms = Math::GSL::MultiSet->new($n, $k);

	isa_ok($ms, "Math::GSL::MultiSet");
	is $ms->{k}, $k;
	is $ms->{n}, $n;
	is $ms->k, $ms->{k};
	is $ms->n, $ms->{n};
}

sub get : Test(3) {
	my ($k,$n) = (20,10);
	my $ms = Math::GSL::MultiSet->new($n, $k);	
	throws_ok { $ms->get(-1) } qr /out of range.*0 <= i < $k/;
	throws_ok { $ms->get($k) } qr /out of range.*0 <= i < $k/;
	
	my $allOK = 1;
	for (my $i = 0; $i < $k; $i++) {
		$allOK = 0 if $ms->get($i) != 0;
	}
	ok $allOK;
}



Test::Class->runtests;
