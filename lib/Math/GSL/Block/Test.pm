package Math::GSL::Block::Test;
use base q{Test::Class};
use Test::More;
use Math::GSL::Block qw/:all/;
use Math::GSL qw/is_similar/;
use strict;

sub make_fixture : Test(setup) {
    my $self = shift;
}

sub teardown : Test(teardown) {
}

sub GSL_BLOCK_ALLOC : Test {
    my $self  = shift;
    my $block = gsl_block_alloc(5);
    isa_ok( $block , 'Math::GSL::Block' );
}

1;
