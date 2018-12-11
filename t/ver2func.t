use Test::More;
use Config;
use File::Spec::Functions;
use lib 'inc';
use Ver2Func;
use strict;
use warnings;

my $gsl_version = "1.16.1";
my $arch        = $Config{archname};
diag( "Testing Math::GSL with GSL $gsl_version on $arch, Perl ($^X) $]" );

my @subsystems = Ver2Func->new( $gsl_version )->subsystems;
cmp_ok(@subsystems,'==', 51, 'GSL version 1.16.1 supported');

done_testing;
