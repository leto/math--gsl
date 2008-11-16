use Test::More 'no_plan';
use Config;
use File::Spec::Functions;
use lib catfile 'blib', 'lib';

BEGIN {
	use_ok( 'Math::GSL' );
    map { use_ok("Math::GSL::$_") } Math::GSL->new->subsystems;
}


my $arch = $Config{archname};
diag( "Testing Math::GSL " . $Math::GSL::VERSION . " on $arch, Perl ($^X) $]" );
