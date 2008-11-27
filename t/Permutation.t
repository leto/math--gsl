package Math::GSL::Permutation::Test;
use base q{Test::Class};
use Test::More tests => 85;
use Math::GSL              qw/:all/;
use Math::GSL::Vector      qw/:all/;
use Math::GSL::Test        qw/:all/;
use Math::GSL::Errno       qw/:all/;
use Math::GSL::Permutation qw/:all/;
use Test::Exception;
use Data::Dumper;
use strict;

BEGIN { gsl_set_error_handler_off(); }
sub make_fixture : Test(setup) {
    my $self = shift;
    $self->{permutation} = gsl_permutation_alloc(6);
}

sub teardown : Test(teardown) {
    my $self = shift;
    unlink 'permutation' if -f 'permutation';

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
    my $p = gsl_permutation_calloc(6);
    isa_ok($p, 'Math::GSL::Permutation');
    map { is(gsl_permutation_get($p, $_), $_) } (0..5);
}
    
sub GSL_PERMUTATION_MEMCPY : Tests {
    my $self = shift;
    my $p = gsl_permutation_alloc(6);   
    gsl_permutation_init($self->{permutation});
    gsl_permutation_memcpy($p, $self->{permutation});
    map { is(gsl_permutation_get($p, $_), $_) } (0..5);
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
    my $p = gsl_permutation_alloc(6);
    gsl_permutation_init($self->{permutation});    

    gsl_permutation_inverse($p, $self->{permutation});
    map { is(gsl_permutation_get($p, $_), $_) } (0..5);
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
#    gsl_permute($self->{permutation}, \@data, 1); # need a typemap to input and output an array of double
#    map { is($data[$_], $_) } (0..5);
#}

#sub GSL_PERMUTE_INVERSE : Tests {
#    my $self = shift;
#    my @data = [5, 4, 3, 2, 1, 0];
#    gsl_permutation_init($self->{permutation});    
#    gsl_permute_inverse($self->{permutation}, \@data, 1); # need a typemap to input and output an array of double
#    map { is($data[$_], $_) } (0..5);
#}

sub GSL_PERMUTE_VECTOR : Tests {
     my $self = shift;     
     gsl_permutation_init($self->{permutation});
     gsl_permutation_swap($self->{permutation}, 0, 1);
    
     my $vec = gsl_vector_alloc(6);
     map { gsl_vector_set($vec, $_, $_) } (0..5);
     gsl_permute_vector($self->{permutation}, $vec);
     is(gsl_vector_get($vec, 0), 1);
     is(gsl_vector_get($vec, 1), 0);
     map { is(gsl_vector_get($vec, $_), $_) } (2..5);
}

sub GSL_PERMUTE_VECTOR_INVERSE : Tests {
     my $self = shift;
     gsl_permutation_init($self->{permutation});
     gsl_permutation_swap($self->{permutation}, 0, 1);
    
     my $vec = gsl_vector_alloc(6);
     map { gsl_vector_set($vec, $_, $_) } (0..5);
     gsl_permute_vector_inverse($self->{permutation}, $vec);
     is(gsl_vector_get($vec, 0), 1);
     is(gsl_vector_get($vec, 1), 0);
     map { is(gsl_vector_get($vec, $_), $_) } (2..5);
}

sub GSL_PERMUTATION_MUL : Tests {
     my $self = shift;
     gsl_permutation_init($self->{permutation});
     gsl_permutation_swap($self->{permutation}, 0, 1);

     my $p2 = gsl_permutation_alloc(6);
     gsl_permutation_init($p2);
     gsl_permutation_swap($p2, 0, 5);

     my $p = gsl_permutation_alloc(6) ;
     gsl_permutation_mul ($p, $p2, $self->{permutation});
     is(gsl_permutation_get($p, 0), 5);
     is(gsl_permutation_get($p, 1), 0);
     is(gsl_permutation_get($p, 5), 1);
     map {  is(gsl_permutation_get($p, $_), $_)} (2..4);
}

sub GSL_PERMUTATION_FWRITE_FREAD : Tests {
    my $self = shift;
    gsl_permutation_init($self->{permutation});
    my $fh = gsl_fopen("permutation", 'w');
    gsl_permutation_fwrite($fh, $self->{permutation});
    fclose($fh);

    my $p = gsl_permutation_alloc(6);
    $fh = gsl_fopen("permutation", 'r');
    gsl_permutation_fread($fh, $p);
    map { is(gsl_permutation_get($p, $_), $_) } (0..5);
    fclose($fh);
}

sub GSL_PERMUTATION_FPRINTF_FSCANF : Tests {
    my $self = shift;
    my $fh = gsl_fopen("permutation", 'w');
    gsl_permutation_init($self->{permutation});
    ok_status( gsl_permutation_fprintf($fh, $self->{permutation}, "%f"));
    ok_status(gsl_fclose($fh));

    local $TODO = "odd error with fscanf";
    $fh = gsl_fopen("permutation", 'r');
    my $p = gsl_permutation_alloc(6); 
    ok_status(gsl_permutation_fscanf($fh, $p)); 
    is_deeply( [ map {gsl_permutation_get($p, $_) }  (0..5) ],
               [ 0 .. 5 ],
    );
    #ok_status(gsl_fclose($fh));
}

sub NEW: Tests { 
    my $perm = Math::GSL::Permutation->new(42);
    isa_ok($perm, 'Math::GSL::Permutation' );
}

sub AS_LIST: Tests { 
    my $perm = Math::GSL::Permutation->new(5);
    is_deeply( [ $perm->as_list ] , [ 0 .. 4 ] );
}
Test::Class->runtests;
