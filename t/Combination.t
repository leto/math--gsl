package Math::GSL::Combination::Test;
use base q{Test::Class};
use Test::More tests => 23;
use Math::GSL::Test        qw/:all/;
use Math::GSL::Combination qw/:all/;
use Math::GSL::Errno       qw/:all/;
use Math::GSL              qw/:all/;
use Data::Dumper;
use strict;

BEGIN { gsl_set_error_handler_off() }

sub make_fixture : Test(setup) {
    my $self = shift;
    $self->{comb} = gsl_combination_calloc(10,5);
    $self->{obj} = Math::GSL::Combination->new(10,5);
}

sub teardown : Test(teardown) {
    my $self = shift;
    unlink 'combo.txt' if -e 'combo.txt';
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
    my $c = gsl_combination_calloc(6,3);  
    is_deeply( [ map{ gsl_combination_get($c,$_) } (0..1) ] , [ 0 .. 1 ] );
    ok_status(gsl_combination_next($c));
    is_deeply( [ map{ gsl_combination_get($c,$_) } (0..2) ] , [ 0, 1, 3 ] );
} 

sub NEW : Tests { 
    my $c = Math::GSL::Combination->new(5,5);
    isa_ok($c, 'Math::GSL::Combination');
    is_deeply( [ map { gsl_combination_get($c->raw, $_) } (0..4) ],
        [ 0 .. 4 ] );   
}

sub AS_LIST: Tests { 
    my $self = shift;
    is_deeply( [ $self->{obj}->as_list ] , [ 0 .. 4 ] );
}

sub LENGTH : Tests {
    my $self = shift;
    ok($self->{obj}->length eq 10);
}

sub ELEMENTS : Tests {
    my $self = shift;
    ok($self->{obj}->elements eq 5);
}

sub NEXT_STATUS : Tests {
    my $c = Math::GSL::Combination->new(6,3);
    $c->next();
    ok( $c->status() == 0 );    
}

sub PREV_STATUS : Tests {
    my $c = Math::GSL::Combination->new(6,3);
    $c->next();
    $c->prev();
    ok( $c->status() == 0 );    
}

sub FWRITE : Tests {
    my $c   = Math::GSL::Combination->new(6,3);
    my $new = Math::GSL::Combination->new(6,3);
    my $fd = gsl_fopen('combo.txt', 'w') or die $!;
    ok_status( gsl_combination_fwrite($fd, $c->raw) );
    gsl_fclose($fd);
    $fd = gsl_fopen('combo.txt', 'r') or die $!;
    ok_status(gsl_combination_fread($fd, $new->raw));
    is_deeply ( [ $c->as_list ], [ $new->as_list ] );
}

sub NEXT : Tests {
    my $c = Math::GSL::Combination->new(6,3);
    
    is_deeply( [ $c->as_list ] , [ 0 .. 2 ] );
    $c->next;
    ok_status( $c->status );
    is_deeply( [ $c->as_list ] , [ 0 , 1, 3 ] );
}

Test::Class->runtests;
