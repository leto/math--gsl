package Math::GSL::Multiset::Test;
use base q{Test::Class};
use strict;
use warnings;
use Test::Most;
use Math::GSL           qw/:all/;
use Math::GSL::Test     qw/:all/;
use Math::GSL::Errno    qw/:all/;
use Math::GSL::Multiset qw/:all/;

BEGIN{ gsl_set_error_handler_off(); }

sub constructor_1_15 : Test {
	return "GSL >= 1.16" if gsl_version() > v1.15;

	dies_ok { Math::GSL::Multiset->new(10,20); }, 
		"This version of GSL doesn't support k > n";
}

sub constructor : Test(5) {
	my ($k,$n) = (10,20);
	my $ms = Math::GSL::Multiset->new($n, $k);

	isa_ok($ms, "Math::GSL::Multiset");
	is $ms->{k}, $k;
	is $ms->{n}, $n;
	is $ms->k, $ms->{k};
	is $ms->n, $ms->{n};
}

sub clone: Test(3) {
	my ($k,$n) = (10,20);
	my $ms = Math::GSL::Multiset->new($n, $k);
	$ms->init_last;

	my $clone = $ms->clone();

	is $ms->k, $clone->k;
	is $ms->n, $clone->n;
	my $allOK = 1;
	for (my $i = 0; $i < $k; $i++) {
		$allOK = 0 if $ms->get($i) != $clone->get($i)
	}
	ok $allOK;
}

sub list : Test {
	my ($k,$n) = (10,20);
	my $ms = Math::GSL::Multiset->new($n, $k);
	$ms->next;
	is_deeply([$ms->to_list], [0,0,0,0,0,0,0,0,0,1]);
}

sub next_prev : Test(3) {
	my ($k,$n) = (10,20);
	my $ms = Math::GSL::Multiset->new($n, $k);
	$ms->next;
	is $ms->get($k-1) => 1;
	$ms->next;
	is $ms->get($k-1) => 2;
	$ms->prev;
	is $ms->get($k-1) => 1;
}

sub init : Test(2) {
	my ($k,$n) = (10,20);
	my $ms = Math::GSL::Multiset->new($n, $k);
	$ms->init_last;
	my $allOK = 1;
	for (my $i = 0; $i < $k; $i++) {
		$allOK = 0 if $ms->get($i) != ($n-1);
	}
	ok $allOK;

	$ms->init_first;
	$allOK = 1;
	for (my $i = 0; $i < $k; $i++) {
		$allOK = 0 if $ms->get($i) != 0;
	}
	ok $allOK;

}

sub get : Test(3) {
	my ($k,$n) = (10,20);
	my $ms = Math::GSL::Multiset->new($n, $k);	
	throws_ok { $ms->get(-1) } qr /out of range.*0 <= i < $k/;
	throws_ok { $ms->get($k) } qr /out of range.*0 <= i < $k/;
	
	my $allOK = 1;
	for (my $i = 0; $i < $k; $i++) {
		$allOK = 0 if $ms->get($i) != 0;
	}
	ok $allOK;
}



Test::Class->runtests;
