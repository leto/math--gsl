package Math::GSL::Combination::Test;
use Math::GSL::Test qw/:all/;
use base q{Test::Class};
use Test::More;
use Math::GSL::Combination qw/:all/;
use Math::GSL::Errno qw/:all/;
use Math::GSL qw/:all/;
use strict;

sub make_fixture : Test(setup) {
  my $self = shift;
  $self->{comb} = gsl_combination_calloc(5,5);
  $self->{oo} = Math::GSL::Combination->new(5,5);
}

sub teardown : Test(teardown) {
}

sub GSL_COMBINATION_ALLOC : Tests { 
    my $c = gsl_combination_alloc(2,2);
    isa_ok($c, 'Math::GSL::Combination');
}

sub GSL_COMBINATION_CALLOC : Tests { 
    my $c = gsl_combination_calloc(2,2);
    isa_ok($c, 'Math::GSL::Combination');
}

sub GSL_COMBINATION_GET : Tests {
    my $self = shift; 
    map {ok(gsl_combination_get($self->{comb}, $_) eq $_) } (0..4);   
}

sub GSL_COMBINATION_NEXT : Tests {
    my $c = gsl_combination_calloc(4,2);  
    is_deeply( [ map{ gsl_combination_get($c,$_) } (0..1) ] , [ 0 .. 1 ] );
    my $status = gsl_combination_next($c);
    ok_status($status, $GSL_SUCCESS);    
    local $TODO = "Seems to have a problem with the gsl_combination_next function, see the gsl doc example for reference";
    is_deeply( [ map{ gsl_combination_get($c,$_) } (0..1) ] , [ 0 .. 2 ] );
} 

sub NEW : Tests { 
    my $c = Math::GSL::Combination->new(5,5);
    isa_ok($c, 'Math::GSL::Combination');
    map {ok(gsl_combination_get($c->raw, $_) eq $_) } (0..4);   
}

sub AS_LIST: Tests { 
    my $self = shift;
    is_deeply( [ $self->{oo}->as_list ] , [ 0 .. 4 ] );
}

sub LENGTH : Tests {
    my $self = shift;
    ok($self->{oo}->length eq 5);
}

sub ELEMENTS : Tests {
    my $self = shift;
    ok($self->{oo}->elements eq 5);
}

sub NEXT : Tests {
    my $self = shift;
    my $status = $self->{oo}->next;
    ok_status($status, $GSL_FAILURE);   
    is_deeply( [ $self->{oo}->as_list ] , [ 0 .. 4 ] );
    my $c = Math::GSL::Combination->new(4,2);
    is_deeply( [ $c->as_list ] , [ 0 .. 1 ] );
    $status = $c->next;
    ok_status($status, $GSL_SUCCESS);   
    local $TODO = "Seems to have a problem with the gsl_combination_next function, see the gsl doc example for reference";
    is_deeply( [ $c->as_list ] , [ 0 .. 2 ] );
}
Test::Class->runtests;
