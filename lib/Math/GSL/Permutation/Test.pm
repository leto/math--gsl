package Math::GSL::Permutation::Test;
use base q{Test::Class};
use Test::More;
use Test::Exception;
use Math::GSL::Permutation qw/:all/;
use Math::GSL::Vector qw/:all/;
use Math::GSL qw/:all/;
use Math::GSL::Errno qw/:all/;
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
    
     my $vec->{vector} = gsl_vector_alloc(6);
     map { gsl_vector_set($vec->{vector}, $_, $_) } (0..5);
     gsl_permute_vector($self->{permutation}, $vec->{vector});
     is(gsl_vector_get($vec->{vector}, 0), 1);
     is(gsl_vector_get($vec->{vector}, 1), 0);
     map { is(gsl_vector_get($vec->{vector}, $_), $_) } (2..5);
}

sub GSL_PERMUTE_VECTOR_INVERSE : Tests {
     my $self = shift;
     gsl_permutation_init($self->{permutation});
     gsl_permutation_swap($self->{permutation}, 0, 1);
    
     my $vec->{vector} = gsl_vector_alloc(6);
     map { gsl_vector_set($vec->{vector}, $_, $_) } (0..5);
     gsl_permute_vector_inverse($self->{permutation}, $vec->{vector});
     is(gsl_vector_get($vec->{vector}, 0), 1);
     is(gsl_vector_get($vec->{vector}, 1), 0);
     map { is(gsl_vector_get($vec->{vector}, $_), $_) } (2..5);
}

sub GSL_PERMUTATION_MUL : Tests {
     my $self = shift;
     gsl_permutation_init($self->{permutation});
     gsl_permutation_swap($self->{permutation}, 0, 1);

     my $p2->{permutation} = gsl_permutation_alloc(6);
     gsl_permutation_init($p2->{permutation});
     gsl_permutation_swap($p2->{permutation}, 0, 5);

     my $p->{permutation} = gsl_permutation_alloc(6) ;
     gsl_permutation_mul ($p->{permutation}, $p2->{permutation}, $self->{permutation});
     is(gsl_permutation_get($p->{permutation}, 0), 5);
     is(gsl_permutation_get($p->{permutation}, 1), 0);
     is(gsl_permutation_get($p->{permutation}, 5), 1);
     map {  is(gsl_permutation_get($p->{permutation}, $_), $_)} (2..4);
}

sub GSL_PERMUTATION_FWRITE_FREAD : Tests {
    my $self = shift;
    gsl_permutation_init($self->{permutation});
    my $fh = fopen("permutation", "w");
    gsl_permutation_fwrite($fh, $self->{permutation});
    fclose($fh);

    my $p->{permutation} = gsl_permutation_alloc(6);
    $fh = fopen("permutation", "r");
    gsl_permutation_fread($fh, $p->{permutation});
    map { is(gsl_permutation_get($p->{permutation}, $_), $_) } (0..5);
    fclose($fh);
}

sub GSL_PERMUTATION_FPRINTF_FSCANF : Tests {
    my $self = shift;
    my $fh = fopen("permutation", "w");
    gsl_permutation_init($self->{permutation});
    ok_status( gsl_permutation_fprintf($fh, $self->{permutation}, "%f"), $GSL_SUCCESS);
    fclose($fh);

    local $TODO = "odd error with fscanf";
    $fh = fopen("permutation", "r");
    my $p->{permutation} = gsl_permutation_alloc(6); 
    #ok_status(gsl_permutation_fscanf($fh, $p->{permutation}), $GSL_SUCCESS); 
    is_deeply( [ map {gsl_permutation_get($p->{permutation}, $_) }  (0..5) ],
               [ 0 .. 5 ],
    );
    fclose($fh);
}

sub NEW: Tests { 
    my $perm = Math::GSL::Permutation->new(42);
    isa_ok($perm, 'Math::GSL::Permutation' );
}

sub AS_LIST: Tests { 
    my $perm = Math::GSL::Permutation->new(5);
    is_deeply( [ $perm->as_list ] , [ 0 .. 4 ] );
}
1;
