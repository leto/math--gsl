package Math::GSL::RNG::Test;
use base q{Test::Class};
use Test::More tests => 31;
use Math::GSL        qw/:all/;
use Math::GSL::RNG   qw/:all/; 
use Math::GSL::Test  qw/:all/;
use Math::GSL::Errno qw/:all/; 
use Data::Dumper;
use strict;

sub make_fixture : Test(setup) {
    my $self = shift;
    $self->{rng} = gsl_rng_alloc($gsl_rng_default);
    gsl_rng_set( $self->{rng}, 1 + 9*(int rand) );
}

sub teardown : Test(teardown) {
    my $self = shift;
    unlink 'rng' if -f 'rng';

    gsl_rng_free($self->{rng});
}

sub GSL_RNG_TYPE : Tests {
    my $self = shift;
    my $type = Math::GSL::RNG::gsl_rng_type->new;
    isa_ok( $type, 'Math::GSL::RNG::gsl_rng_type', 'gsl_rng_type' );
}

sub GSL_RNG_ALLOC : Tests { 
    for my $rngtype ( $gsl_rng_random256_bsd, $gsl_rng_knuthran,
                      $gsl_rng_transputer, $gsl_rng_knuthran2002) {
        my $rng;
        eval { $rng = gsl_rng_alloc($rngtype) };
        isa_ok( $rng, 'Math::GSL::RNG');
        ok( !$@ ,'gsl_rng_alloc');
    }
}

sub GSL_RNG_NEW: Tests {
    my $rng;
    $rng = Math::GSL::RNG->new($gsl_rng_knuthran, int 10*rand);
    isa_ok($rng, 'Math::GSL::RNG' );

    $rng = Math::GSL::RNG->new($gsl_rng_knuthran);
    isa_ok($rng, 'Math::GSL::RNG' );

    $rng = Math::GSL::RNG->new;
    isa_ok($rng, 'Math::GSL::RNG' );
}

sub GSL_RNG_METHODS : Tests {
    can_ok('Math::GSL::RNG', qw/copy get new free/ );
}

sub GSL_RNG_STATE : Tests {
    my $seed = int 10*rand;
    my $k    = 10 + int(100*rand);
    my $rng1 = Math::GSL::RNG->new($gsl_rng_knuthran, $seed );

    map { my $x = $rng1->get } (1..$k);

    my $rng2 = Math::GSL::RNG->new($gsl_rng_knuthran, $seed );
    $rng2 = $rng1->copy;

    my @vals1 = map { $rng1->get } (1..$k);
    my @vals2 = map { $rng2->get } (1..$k);
    
    is_deeply( [@vals1], [@vals2], "state test, $#vals1 values checked");
}

sub GSL_RNG_GET : Tests {
    my $rng = Math::GSL::RNG->new;
    my $x   = $rng->get;
    ok( defined $x, '$rng->get' );
}

sub GSL_RNG_NAME : Tests {
    my $self  = shift;
    my $name1 = gsl_rng_name($self->{rng});
    ok( defined $name1 , "\$gsl_rng_default=$name1" );

    my $rng   = Math::GSL::RNG->new;
    my $name2 = $rng->name;
    ok($name1 eq $name2, "\$rng->name == gsl_rng_name = $name2" );
}

sub GSL_RNG_SIZE : Tests {
    my $self  = shift;
    my $size = gsl_rng_size($self->{rng});
    ok( $size > 0, 'gsl_rng_size' );
}

sub GSL_RNG_MIN_AND_MAX : Tests {
    my $self  = shift;
    my $rng = $self->{rng};
    my ($min,$max) = (gsl_rng_min($rng), gsl_rng_max($rng));
    map { gsl_rng_get($rng) } (1..int(rand(100)));
    ok( defined $min && defined $max 
        && ($min <= $max), 'gsl_rng_min and gsl_rng_max');
}

sub GSL_RNG_NO_MORE_SECRETS : Tests {
    my $seed = 1+int 10*rand;
    my $k    = 10 + int(100*rand);
    my $rng1 = Math::GSL::RNG->new($gsl_rng_knuthran, $seed );
    my $rng2 = Math::GSL::RNG->new($gsl_rng_knuthran, $seed );

    # throw away the first $k values
    map {  $rng1->get && $rng2->get } (1..$k);
    
    my ($n1,$n2) = ( $rng1->get , $rng2->get ); 
    ok( $n1 == $n2 , "parrallel state test: $n1 ?= $n2" );
}

sub GSL_RNG_DEFAULT : Tests {
    my $self = shift;
    my $seed = 42;

    my $rng = gsl_rng_alloc($gsl_rng_default);
    isa_ok( $rng, 'Math::GSL::RNG', 'gsl_rng_alloc' );

    eval { gsl_rng_set($rng, $seed) };
    isa_ok( $rng, 'Math::GSL::RNG', 'gsl_rng_set' );
    ok( ! $@, 'gsl_rng_set' );

    my $rand = gsl_rng_get($rng);
    ok( defined $rand && $rand == 1608637542, 'gsl_rng_get' );

    my $rng2 = gsl_rng_alloc($gsl_rng_default);

    eval { gsl_rng_memcpy($rng2, $rng) };
    ok ( ! $@, 'gsl_rng_memcpy' );

    eval { Math::GSL::RNG::gsl_rng_free($rng) };
    ok( ! $@, 'gsl_rng_free' );
}

sub GSL_RNG_FWRITE_FREAD : Tests {
    my $self = shift;
    my $rng = gsl_rng_alloc($gsl_rng_default);

    my $fh = gsl_fopen("rng" , 'w');
    ok_status(gsl_rng_fwrite($fh, $self->{rng}));
    ok_status(gsl_fclose($fh));

    $fh = gsl_fopen("rng", 'r');
    is(gsl_rng_fread($fh, $rng),0);
    is(gsl_rng_get($rng), gsl_rng_get($self->{rng}));
    ok_status(gsl_fclose($fh));
}
Test::Class->runtests;
