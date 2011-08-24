use Test::More tests => 53;
use Config;
use File::Spec::Functions;
use lib catfile 'blib', 'lib';
use lib 'inc';
use GSLBuilder;
use strict;
use warnings;


BEGIN {
    use_ok( 'Math::GSL' );
    map { use_ok("Math::GSL::$_") } GSLBuilder::subsystems();
}

my $arch = $Config{archname};
diag( "Testing Math::GSL " . $Math::GSL::VERSION . " on $arch, Perl ($^X) $]" );
