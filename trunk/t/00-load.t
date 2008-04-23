use Test::More tests => 6;
use File::Fu;
my $lib  = File::Fu->dir('..') + 'lib'; 

BEGIN {
	use_ok( 'Math::GSL' );
    map { use_ok("Math::GSL::$_") } Math::GSL->new->subsystems;
}

diag( "Testing Math::GSL " . $Math::GSL::VERSION . ", Perl $], $^X" );
