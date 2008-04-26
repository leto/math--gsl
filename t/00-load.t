use Test::More 'no_plan';
use File::Fu;
my $lib  = File::Fu->dir('..') + 'lib'; 

BEGIN {
	use_ok( 'Math::GSL' );
    map { use_ok("Math::GSL::$_") } Math::GSL->new->subsystems;
}

diag( "Testing Math::GSL " . $Math::GSL::VERSION . ", Perl $], $^X" );
