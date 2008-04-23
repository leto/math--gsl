use Test::More tests => 5;
use File::Fu;
my $lib  = File::Fu->dir('..') + 'lib'; 

BEGIN {
	use_ok( 'Math::GSL' );
    my @modules = map { use_ok("Math::GSL::$_") } qw/ Randist SF Errno Machine /;
}

diag( "Testing Math::GSL " . $Math::GSL::VERSION . ", Perl $], $^X" );
