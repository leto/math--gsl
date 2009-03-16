package Math::GSL::Sort::Test;
use Math::GSL::Test qw/:all/;
use base q{Test::Class};
use Test::More tests => 20;
use Math::GSL::RNG         qw/:all/;
use Math::GSL::Sort        qw/:all/;
use Math::GSL::Errno       qw/:all/;
use Math::GSL::Vector      qw/:all/;
use Math::GSL::Permutation qw/:all/;
use Data::Dumper;
use strict;

BEGIN { gsl_set_error_handler_off(); }

sub make_fixture : Test(setup) {
    my $self = shift;
    $self->{data} = [ 2**15, 1, 42.7, -17, 6900, 3e-10 , 4242, 0e0];
}

sub teardown : Test(teardown) {
}

sub GSL_SORT_VECTOR : Tests(1) {
   my $vec = Math::GSL::Vector->new([6,4,2,3,1,5]);
   gsl_sort_vector($vec->raw);
   ok_similar( [ $vec->as_list ], [ 1 .. 6 ] );
} 

sub GSL_SORT_VECTOR_LARGEST : Tests(2) {
   my $vec = Math::GSL::Vector->new([reverse 0..50]);
   my $largest10 = [1..10];
   # $largest10 should not have to be passed in
   my ($status, $stuff) = gsl_sort_vector_largest($largest10, 10, $vec->raw);
   ok_status( $status);
   ok_similar( $stuff, [ reverse (41 .. 50) ] );
} 

sub GSL_SORT_VECTOR_SMALLEST : Tests(2) {
   my $vec = Math::GSL::Vector->new([reverse 0..50]);
   my $smallest10 = [1..10];
   # $smallest10 should not have to be passed in
   my ($status, $stuff) = gsl_sort_vector_smallest($smallest10, 10, $vec->raw);
   ok_status( $status);
   ok_similar( $stuff, [ 0 .. 9 ] );
} 

sub GSL_SORT_VECTOR_INDEX : Tests(2) {
  my $vec = Math::GSL::Vector->new([4,2,3,1,5]);
  my $p = Math::GSL::Permutation->new(5);
  ok_status(gsl_sort_vector_index($p->raw, $vec->raw));
  # indices in ascending order
  ok_similar( [ $p->as_list ], [ 3, 1, 2, 0 , 4] );
}

sub GSL_SORT_VECTOR_SMALLEST_INDEX : Tests(2) {
    my $self   = shift;
    my $p      = [ 1 .. $#{$self->{data}} ];
    my $vector = Math::GSL::Vector->new([4,2,3,1,5]);
    my ($status, $stuff) = gsl_sort_vector_smallest_index($p, 3, $vector->raw);
    ok_status($status);
    ok_similar( $stuff , [ 3, 1, 2] );
}

sub GSL_SORT_VECTOR_LARGEST_INDEX : Tests(2) {
    my $self   = shift;
    my $p      = [ 1 .. $#{$self->{data}} ];
    my $vector = Math::GSL::Vector->new([4,2,3,1,5]);
    my ($status, $stuff) = gsl_sort_vector_largest_index($p, 3, $vector->raw);
    ok_status($status);
    ok_similar( $stuff , [ 4,0,2] );
}

sub GSL_SORT : Tests {
   my $self = shift;
   my $sorted = gsl_sort($self->{data}, 1, $#{$self->{data}} + 1 );
   ok_similar ( $sorted , [ -17, 0e0, 3e-10, 1, 42.7, 4242, 6900, 2**15 ], 'gsl_sort' );    
}

sub GSL_SORT_SMALLEST : Tests(2) {
   my $self = shift;
   my $out = [1..10];
   my ($status, $sorted) = gsl_sort_smallest($out, 3, $self->{data}, 1, $#{$self->{data}}+1 );
   ok_status($status);
   ok_similar ( $sorted , [ -17, 0e0, 3e-10 ], 'gsl_sort_smallest' );     
}

sub GSL_SORT_LARGEST : Tests(2) {
   my $self = shift;
   my $out = [1..10];
   my ($status, $sorted) = gsl_sort_largest($out, 3, $self->{data}, 1, $#{$self->{data}}+1 );
   ok_status($status);
   ok_similar ( $sorted , [ 2**15,  6900, 4242 ], 'gsl_sort_largest' );     
}

sub GSL_SORT_INDEX : Tests(1) {
    my $self = shift;
    my $p = [ 1 .. $#{$self->{data}} ];
    my $sorted = gsl_sort_index($p, $self->{data}, 1, $#{$self->{data}}+1 );
    ok_similar( $sorted, [ 3, 7, 5, 1, 2, 6, 4, 0 ] );
}

sub GSL_SORT_SMALLEST_INDEX : Tests(1) {
    my $self = shift;
    my $p = [ 1 .. $#{$self->{data}} ];
    my $sorted = gsl_sort_smallest_index($p, 3, $self->{data}, 1, $#{$self->{data}}+1 );
    ok_similar( $sorted, [ 3, 7, 5 ] );
}

sub GSL_SORT_LARGEST_INDEX : Tests(1) {
    my $self = shift;
    my $p = [ 1 .. $#{$self->{data}} ];
    my $sorted = gsl_sort_largest_index($p, 3, $self->{data}, 1, $#{$self->{data}}+1 );
    ok_similar( $sorted, [ 0,4,6 ] );
}

sub GSL_SORT_AGREES_WITH_PERL_SORT : Tests(1) {
    my $self = shift;
    my $rng = Math::GSL::RNG->new;
    my @data = map { (-1) ** $_ * $rng->get } (1..100);
    my @sorted = sort { $a <=> $b } @data;
    ok_similar( gsl_sort([@data], 1, $#data+1) , \@sorted , 'gsl_sort agrees with sort');
}

Test::Class->runtests;
