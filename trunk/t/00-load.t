use Test::More tests => 1;
use File::Fu;
my $lib  = File::Fu->dir('..') + 'lib'; 

BEGIN {
	use_ok( 'Math::GSL' );
}

diag( "Testing Math::GSL " . $Math::GSL::VERSION . ", Perl $], $^X" );
