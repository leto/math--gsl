use Test::More 'no_plan';

BEGIN {
	use_ok( 'Math::GSL' );
    map { use_ok("Math::GSL::$_") } Math::GSL->new->subsystems;
}

diag( "Testing Math::GSL " . $Math::GSL::VERSION . ", Perl $], $^X" );
