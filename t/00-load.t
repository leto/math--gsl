use Test::More 'no_plan';
use Config;

BEGIN {
	use_ok( 'Math::GSL' );
    map { use_ok("Math::GSL::$_") } Math::GSL->new->subsystems;
}


my $arch = $Config{archname};
diag( "Testing Math::GSL " . $Math::GSL::VERSION . " on $arch, Perl ($^X) $]" );
