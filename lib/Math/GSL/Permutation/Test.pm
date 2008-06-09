package Math::GSL::Permutation::Test;
use base q{Test::Class};
use Test::More;
use Math::GSL::Permutation qw/:all/;
use Math::GSL qw/:all/;
use Data::Dumper;
use strict;

sub make_fixture : Test(setup) {
    my $self = shift;
    $self->{permutation} = gsl_permutation_alloc(6);
}

sub teardown : Test(teardown) {
    my $self = shift;

    gsl_permutation_free($self->{permutation});
}

sub GSL_PERMUTATION_ALLOC : Tests {
    my $p = gsl_permutation_alloc(6);
    isa_ok($p, 'Math::GSL::Permutation');
}

sub GSL_PERMUTATION_GET_INIT : Tests {
    my $self = shift;
    gsl_permutation_init($self->{permutation});
    map { is(gsl_permutation_get($self->{permutation}, $_), $_) } (0..5);
}
    
sub GSL_PERMUTATION_CALLOC : Tests {
    my $p->{permutation} = gsl_permutation_calloc(6);
    isa_ok($p->{permutation}, 'Math::GSL::Permutation');
    map { is(gsl_permutation_get($p->{permutation}, $_), $_) } (0..5);
}
    
sub GSL_PERMUTATION_MEMCPY : Tests {
    my $self = shift;
    my $p->{permutation} = gsl_permutation_alloc(6);   
    gsl_permutation_init($self->{permutation});
    gsl_permutation_memcpy($p->{permutation}, $self->{permutation});
    map { is(gsl_permutation_get($p->{permutation}, $_), $_) } (0..5);
}

sub GSL_PERMUTATION_SWAP : Tests {
    my $self=shift;
    gsl_permutation_init($self->{permutation});
    is(gsl_permutation_swap($self->{permutation}, 0, 5), 0);
    is(gsl_permutation_get($self->{permutation}, 0), 5);
    is(gsl_permutation_get($self->{permutation}, 5), 0);
    map { is(gsl_permutation_get($self->{permutation}, $_), $_) } (1..4);
}

sub GSL_PERMUTATION_SIZE : Tests {
    my $self=shift;
    gsl_permutation_init($self->{permutation});
    is(gsl_permutation_size($self->{permutation}), 6);
}

sub GSL_PERMUTATION_VALID : Tests {
    my $self=shift;
    gsl_permutation_init($self->{permutation});
    is(gsl_permutation_valid($self->{permutation}), 0);
}

sub GSL_PERMUTATION_REVERSE : Tests {
    my $self=shift;
    gsl_permutation_init($self->{permutation});
    gsl_permutation_reverse($self->{permutation});
    
    is(gsl_permutation_get($self->{permutation}, 0), 5); 
    is(gsl_permutation_get($self->{permutation}, 1), 4);
    is(gsl_permutation_get($self->{permutation}, 2), 3);
    is(gsl_permutation_get($self->{permutation}, 3), 2);
    is(gsl_permutation_get($self->{permutation}, 4), 1);
    is(gsl_permutation_get($self->{permutation}, 5), 0);
}

sub GSL_PERMUTATION_INVERSE : Tests {
    my $self = shift;
    my $p->{permutation} = gsl_permutation_alloc(6);
    gsl_permutation_init($self->{permutation});    

    gsl_permutation_inverse($p->{permutation}, $self->{permutation});
    map { is(gsl_permutation_get($p->{permutation}, $_), $_) } (0..5);
} 

sub GSL_PERMUTATION_NEXT : Tests {
    my $self = shift;
    gsl_permutation_init($self->{permutation});    
    is(gsl_permutation_next($self->{permutation}), 0);
    map { is(gsl_permutation_get($self->{permutation}, $_), $_) } (0..3);
    is(gsl_permutation_get($self->{permutation}, 4), 5);
    is(gsl_permutation_get($self->{permutation}, 5), 4); 
} 

sub GSL_PERMUTATION_PREV : Tests {
    my $self = shift;
    gsl_permutation_init($self->{permutation});    
    gsl_permutation_swap($self->{permutation}, 4, 5);
    is(gsl_permutation_prev($self->{permutation}), 0);
    map { is(gsl_permutation_get($self->{permutation}, $_), $_) } (0..5);
} 

#sub GSL_PERMUTE : Tests {
#    my $self = shift;
#    my @data = [5, 4, 3, 2, 1, 0];
#    gsl_permutation_init($self->{permutation});    
#    gsl_permute($self->{permutation}, \@data, 1);
#    map { is($data[$_], $_) } (0..5);
#} 
1;
