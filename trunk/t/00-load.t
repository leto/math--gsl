use Test::More tests => 1;
use File::Fu;
my $lib  = File::Fu->dir('..') + 'lib'; 

BEGIN {
	use_ok( 'Math::GSL::Sf' );
}

diag( "Testing Math::GSL::Sf " . $Math::GSL::Sf::VERSION . ", Perl $], $^X" );
