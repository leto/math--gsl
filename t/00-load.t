use Test::More;
use Config;
use File::Spec::Functions;
use lib 'inc';
use GSLBuilder;
use strict;
use warnings;

my $gsl_version;
BEGIN {
    use_ok( 'Math::GSL', qw/gsl_version/ );

    map { use_ok("Math::GSL::$_") } GSLBuilder::subsystems();

    $gsl_version = gsl_version();
    my ($major, $minor, $tiny) = split /\./, $gsl_version;

    eval "use_ok('Math::GSL::Rstat')" if ($major >= 2);
    ok(0, $@) if $@;

    eval "use_ok('Math::GSL::Multilarge')" if ($major >= 2 and $minor >= 1);
    ok(0, $@) if $@;

    eval "use_ok('Math::GSL::Multifit')" if ($major >= 2 and $minor >= 1);
    ok(0, $@) if $@;
}

my $arch        = $Config{archname};
diag( "Testing Math::GSL $Math::GSL::VERSION with GSL $gsl_version on $arch, Perl ($^X) $]" );

done_testing;
