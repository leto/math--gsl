use Test::More tests => 2;
use File::Fu;
my $lib  = File::Fu->dir('..') + 'lib'; 

BEGIN {
	use_ok( 'Math::GSL' );
	use_ok( 'Math::GSL::SF' );
}

diag( "Testing Math::GSL " . $Math::GSL::VERSION . ", Perl $], $^X" );
