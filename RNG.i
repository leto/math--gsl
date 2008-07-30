%module "Math::GSL::RNG"
%{
    #include "gsl/gsl_rng.h"
%}
%import "gsl/gsl_types.h"

%include "gsl/gsl_rng.h"

FILE *fopen(char *, char *);
int fclose(FILE *);

%perlcode %{
@EXPORT_OK = qw/ fopen fclose
                 gsl_rng_alloc gsl_rng_set gsl_rng_get gsl_rng_free gsl_rng_memcpy
                 gsl_rng_fwrite gsl_rng_fread gsl_rng_clone gsl_rng_max gsl_rng_min
                 gsl_rng_name gsl_rng_size gsl_rng_state gsl_rng_print_state 
                $gsl_rng_default $$gsl_rng_knuthran $$gsl_rng_ran0 $gsl_rng_borosh13
                $gsl_rng_coveyou $gsl_rng_cmrg $gsl_rng_fishman18 $gsl_rng_fishman20 $gsl_rng_fishman2x
                $gsl_rng_gfsr4 $gsl_rng_knuthran $gsl_rng_knuthran2 $gsl_rng_knuthran2002 $gsl_rng_lecuyer21
                $gsl_rng_minstd $gsl_rng_mrg $gsl_rng_mt19937 $gsl_rng_mt19937_1999 $gsl_rng_mt19937_1998
                $gsl_rng_r250 $gsl_rng_ran0 $gsl_rng_ran1 $gsl_rng_ran2 $gsl_rng_ran3
                $gsl_rng_rand $gsl_rng_rand48 $gsl_rng_random128_bsd $gsl_rng_random128_gli $gsl_rng_random128_lib
                $gsl_rng_random256_bsd $gsl_rng_random256_gli $gsl_rng_random256_lib $gsl_rng_random32_bsd
                $gsl_rng_random32_glib $gsl_rng_random32_libc $gsl_rng_random64_bsd $gsl_rng_random64_glib 
                $gsl_rng_random64_libc $gsl_rng_random8_bsd $gsl_rng_random8_glibc $gsl_rng_random8_libc5
                $gsl_rng_random_bsd $gsl_rng_random_glibc2 $gsl_rng_random_libc5 $gsl_rng_randu
                $gsl_rng_ranf $gsl_rng_ranlux $gsl_rng_ranlux389 $gsl_rng_ranlxd1 $gsl_rng_ranlxd2 $gsl_rng_ranlxs0
                $gsl_rng_ranlxs1 $gsl_rng_ranlxs2 $gsl_rng_ranmar $gsl_rng_slatec $gsl_rng_taus $gsl_rng_taus2
                $gsl_rng_taus113 $gsl_rng_transputer $gsl_rng_tt800 $gsl_rng_uni $gsl_rng_uni32 $gsl_rng_vax
                $gsl_rng_waterman14 $gsl_rng_zuf 
              /;
%EXPORT_TAGS = ( all => [ @EXPORT_OK ] );

=head1 NAME

Math::GSL::RNG - Random Number Generators

=head1 SYNOPSIS

    use Math::GSL::RNG qw/:all/;
    my $rng = Math::GSL::RNG->new;
    my @random = map { $rng->get } (1..100);

=head2 Math::GSL::RNG->new($type, $seed)

    my $rng = Math::GSL::RNG->new;
    my $rng = Math::GSL::RNG->new($gsl_rng_knuthran,5);

Creates a new RNG object of type $type, seeded with $seed. Both of these
parameters are optional. The type $gsl_rng_default is used when no $type
is given.

=cut
 
sub new {
    my ($class, $type, $seed) = @_;
    $type ||= $gsl_rng_default;
    $seed ||= int 100*rand;

    my $self = {};
    my $rng  = gsl_rng_alloc($type);
    gsl_rng_set($rng, $seed);

    $self->{_rng} = $rng; 
    bless $self, $class;
}

=head2 copy()

    my $copy = $rng->copy;

Make a copy of a RNG object.

=cut

sub copy {
    my ($self)    = @_;
    my $copy      = Math::GSL::RNG->new;
    $copy->{_rng} = gsl_rng_clone($self->{_rng});

    return $copy;
}

=head2 free()

    $rng->free();

Free memory associated with RNG object.

=cut

sub free {
    my ($self)    = @_;
    gsl_rng_free($self->{_rng});
}

=head2 name()

   my $name = $rng->name();

Get the name of the RNG object as a string.

=cut

sub name {
    my ($self)    = @_;
    gsl_rng_name($self->{_rng});
}

=head2 get()

    my $nextval = $rng->get();

Get the next random value from the RNG object.

=cut

sub get {
    my ($self) = @_;

    gsl_rng_get($self->{_rng});
}

__END__


=head1 DESCRIPTION

=over 1

=item gsl_rng_alloc

=item gsl_rng_set

=item gsl_rng_get

=item gsl_rng_free

=item gsl_rng_memcpy

=item gsl_rng_fwrite

=item gsl_rng_fread

=item gsl_rng_clone

=item gsl_rng_max

=item gsl_rng_min

=item gsl_rng_name

=item gsl_rng_size

=item gsl_rng_state

=item gsl_rng_print_state

=back

=head1 Random Number Generator Types

=over 1

=item $gsl_rng_default

=item $gsl_rng_knuthran

=item $gsl_rng_ran0

=item $gsl_rng_borosh13

=item $gsl_rng_coveyou

=item $gsl_rng_cmrg

=item $gsl_rng_fishman18

=item $gsl_rng_fishman20

=item $gsl_rng_fishman2x

=item $gsl_rng_gfsr4

=item $gsl_rng_knuthran

=item $gsl_rng_knuthran2

=item $gsl_rng_knuthran2002

=item $gsl_rng_lecuyer21

=item $gsl_rng_minstd

=item $gsl_rng_mrg

=item $gsl_rng_mt19937

=item $gsl_rng_mt19937_1999

=item $gsl_rng_mt19937_1998

=item $gsl_rng_r250

=item $gsl_rng_ran0

=item $gsl_rng_ran1

=item $gsl_rng_ran2

=item $gsl_rng_ran3

=item $gsl_rng_rand

=item $gsl_rng_rand48

=item $gsl_rng_random128_bsd

=item $gsl_rng_random128_gli

=item $gsl_rng_random128_lib

=item $gsl_rng_random256_bsd

=item $gsl_rng_random256_gli

=item $gsl_rng_random256_lib

=item $gsl_rng_random32_bsd

=item $gsl_rng_random32_glib

=item $gsl_rng_random32_libc

=item $gsl_rng_random64_bsd

=item $gsl_rng_random64_glib

=item $gsl_rng_random64_libc

=item $gsl_rng_random8_bsd

=item $gsl_rng_random8_glibc

=item $gsl_rng_random8_libc5

=item $gsl_rng_random_bsd

=item $gsl_rng_random_glibc2

=item $gsl_rng_random_libc5

=item $gsl_rng_randu

=item $gsl_rng_ranf

=item $gsl_rng_ranlux

=item $gsl_rng_ranlux389

=item $gsl_rng_ranlxd1

=item $gsl_rng_ranlxd2

=item $gsl_rng_ranlxs0

=item $gsl_rng_ranlxs1

=item $gsl_rng_ranlxs2

=item $gsl_rng_ranmar

=item $gsl_rng_slatec

=item $gsl_rng_taus

=item $gsl_rng_taus2

=item $gsl_rng_taus113

=item $gsl_rng_transputer

=item $gsl_rng_tt800

=item $gsl_rng_uni

=item $gsl_rng_uni32

=item $gsl_rng_vax

=item $gsl_rng_waterman14

=item $gsl_rng_zuf 

=back

For more informations on the functions, we refer you to the GSL offcial documentation: 

L<http://www.gnu.org/software/gsl/manual/html_node/>

Tip : search on google: site:http://www.gnu.org/software/gsl/manual/html_node/ name_of_the_function_you_want

=head1 EXAMPLES

The following example will print out a list a random integers between certain
minimum and maximum values. The command line arguments are first the number of
random numbers wanted, the minimum and then maximum. The defaults are 10, 0 and
100, respectively. 

    use Math::GSL::RNG qw/:all/;
    my $seed = int rand(100);
    my $rng  = Math::GSL::RNG->new($gsl_rng_knuthran, $seed );
    my ($num,$min,$max) = @ARGV;
    $num ||= 10;
    $min ||= 0;
    $max ||= 100;
    print join "\n", map { $min + $rng->get % ($max-$min+1)  } (1..$num);
    print "\n";

The C<$seed> argument is optional but encouraged. This program is available in
the B<examples/> directory that comes with the source of this module.

If you would like a series of random non-integer numbers, then you can generate one "scaling factor" 
and multiple by that, such as

    use Math::GSL::RNG qw/:all/;
    my $scale= rand(10);
    my $seed = int rand(100);
    my $rng  = Math::GSL::RNG->new($gsl_rng_knuthran, $seed );
    my ($num,$min,$max) = (10,0,100);
    print join "\n", map { $scale*($min + $rng->get % ($max-$min+1))  } (1..$num);
    print "\n";

=head1 AUTHORS

Jonathan Leto <jonathan@leto.net> and Thierry Moisan <thierry.moisan@gmail.com>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2008 Jonathan Leto and Thierry Moisan

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

%}
