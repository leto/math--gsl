package Math::GSL::Histogram::Test;
use Math::GSL::Test qw/:all/;
use base q{Test::Class};
use Test::More;
use Math::GSL qw/:all/;
use Math::GSL::Histogram qw/:all/;
use Math::GSL::Errno qw/:all/;
use Data::Dumper;
use strict;

BEGIN{ gsl_set_error_handler_off(); }

sub make_fixture : Test(setup) {
    my $self = shift;
    $self->{H} = gsl_histogram_alloc( 100 );
    gsl_histogram_set_ranges_uniform($self->{H}, 0, 100);
}

sub teardown : Test(teardown) {
    unlink 'histogram' if -f 'histogram';
}

sub ALLOC_FREE : Tests {
    my $H = gsl_histogram_alloc( 100 );
    isa_ok($H, 'Math::GSL::Histogram' );
    gsl_histogram_free($H);
    ok(!$@, 'gsl_histogram_free');
}

sub SET_RANGES_UNIFORM : Tests {
    my $H = gsl_histogram_alloc(100);
    ok_status(gsl_histogram_set_ranges_uniform($H, 0, 100));
    ok_status(gsl_histogram_set_ranges_uniform($H, 0, -100), $GSL_EINVAL);
}

sub SET_RANGES : Tests {
    my $self = shift;
    my $ranges = [ 0 .. 100 ]; 

    ok_status(gsl_histogram_set_ranges($self->{H}, $ranges, 100 + 1));
    ok_status(gsl_histogram_set_ranges($self->{H}, $ranges, 42), $GSL_EINVAL);
}

sub CLONE : Tests { 
    my $self = shift;
    my $copy = gsl_histogram_clone($self->{H});
    isa_ok( $copy, 'Math::GSL::Histogram');
}

sub MEMCPY : Tests {
    my $self = shift;
    my $copy = gsl_histogram_alloc(100);

    ok_status(gsl_histogram_memcpy($copy, $self->{H}));

    my $bob = gsl_histogram_alloc(50);
    ok_status(gsl_histogram_memcpy($bob, $self->{H}), $GSL_EINVAL);

}

sub INCREMENT : Tests { 
    my $self = shift;

    ok_status(gsl_histogram_increment($self->{H}, 50.5 ));
    ok_status(gsl_histogram_increment($self->{H}, -150.5 ), $GSL_EDOM);
    ok_status(gsl_histogram_increment($self->{H}, 150.5 ), $GSL_EDOM);
}

sub GET : Tests { 
    my $self = shift;

    ok_status(gsl_histogram_increment($self->{H}, 50.5 ));
    cmp_ok(1,'==', gsl_histogram_get($self->{H}, 50 ) );
}

sub MIN_MAX : Tests {
    my $self = shift;
    ok_status(gsl_histogram_increment($self->{H}, 50.5 ));

    cmp_ok(100,'==', gsl_histogram_max($self->{H}));
    cmp_ok(0,'==', gsl_histogram_min($self->{H}));
}

sub MIN_VAL_MAX_VAL : Tests {
    my $self = shift;
    ok_status(gsl_histogram_increment($self->{H}, 50.5 ));

    cmp_ok(1,'==', gsl_histogram_max_val($self->{H}));
    cmp_ok(0,'==', gsl_histogram_min_val($self->{H}));
}

sub MEAN : Tests {
    my $self = shift;
    ok_status(gsl_histogram_increment($self->{H}, 50.5 ));
    ok_status(gsl_histogram_increment($self->{H}, 11.5 ));

    ok_similar(31, gsl_histogram_mean($self->{H}));
}

sub SUM : Tests {
    my $self = shift;
    ok_status(gsl_histogram_increment($self->{H}, 50.5 ));
    ok_status(gsl_histogram_increment($self->{H}, 11.5 ));
    ok_similar(2, gsl_histogram_sum($self->{H}));
}

sub SHIFT : Tests {
    my $self = shift;
    ok_status(gsl_histogram_shift($self->{H}, 2));
    is_deeply( [ map { gsl_histogram_get($self->{H}, $_) } (0..99) ],
               [ (2) x 100 ]
    );
}

sub FWRITE_FREAD : Tests {
    my $self = shift;
    my $stream = gsl_fopen("histogram", 'w');
    ok_status(gsl_histogram_increment($self->{H}, 50.5 ));

    ok_status(gsl_histogram_fwrite($stream, $self->{H}));  
    ok_status(gsl_fclose($stream));
   
    $stream = gsl_fopen("histogram", 'r');
    my $h = gsl_histogram_alloc(100);  
    ok_status(gsl_histogram_fread($stream, $h));  
    is_deeply( [ map { gsl_histogram_get($h, $_) } (0..99) ],
               [ (0) x 50, 1, (0) x 49 ]
    );
    ok_status(gsl_fclose($stream));
}
  
sub GET_RANGE : Tests {
    my $self = shift;
    my @got = gsl_histogram_get_range($self->{H}, 50);
    ok_status($got[0]);
    is_deeply( [ $got[1], $got[2]], [50, 51]);
}

sub FIND : Tests {
    my $self = shift;
    my @got = gsl_histogram_find($self->{H}, 1);
    ok_status($got[0]);
    cmp_ok($got[1], '==', 1);
}

sub ACCUMULATE : Tests {
    my $self = shift;

    ok_status(gsl_histogram_accumulate($self->{H}, 50.5, 3 ));
    cmp_ok(3,'==', gsl_histogram_get($self->{H}, 50 ) );
    ok_status(gsl_histogram_accumulate($self->{H}, -150.5, 3 ), $GSL_EDOM);
}

sub BINS : Tests { 
    my $self = shift;
    cmp_ok(gsl_histogram_bins($self->{H}), '==', 100);
}

sub RESET : Tests {
    my $self = shift;
    gsl_histogram_shift($self->{H}, 2);
    gsl_histogram_reset($self->{H});
    is_deeply( [ map { gsl_histogram_get($self->{H}, $_) } (0..99) ],
               [ (0) x 100 ]
    );
}

sub MIN_BIN_MAX_BIN : Tests {
    my $self = shift;
    ok_status(gsl_histogram_increment($self->{H}, 50.5 ));
    cmp_ok(gsl_histogram_min_bin($self->{H}), '==', 0);
    cmp_ok(gsl_histogram_max_bin($self->{H}), '==', 50);
}

sub GSL_HISTOGRAM_SIGMA : Tests {
    my $self = shift;
    map { gsl_histogram_increment($self->{H}, $_ ) } (0,1);
    my $standard_deviation = gsl_histogram_sigma($self->{H});
    ok_similar ( 0.5, $standard_deviation );
}

sub EQUAL_BINS_P : Tests { 
    my $self = shift;
    my $h2 = gsl_histogram_alloc(100);
    gsl_histogram_set_ranges_uniform($h2, 0, 100);
    cmp_ok(gsl_histogram_equal_bins_p($self->{H}, $h2), '==', 1);
    gsl_histogram_set_ranges_uniform($self->{H}, 0, 50);
    cmp_ok(gsl_histogram_equal_bins_p($self->{H}, $h2), '==', 0);
}

sub ADD : Tests {
    my $self = shift;
    my $h2 = gsl_histogram_alloc(100);
    gsl_histogram_set_ranges_uniform($h2, 0, 100);
    gsl_histogram_increment($h2, 50.5 );
    ok_status(gsl_histogram_add($self->{H}, $h2));
    cmp_ok(gsl_histogram_get($self->{H}, 50), '==', 1);
}

sub SUB : Tests {
    my $self = shift;
    my $h2 = gsl_histogram_alloc(100);
    gsl_histogram_set_ranges_uniform($h2, 0, 100);
    gsl_histogram_increment($h2, 50.5 );
    gsl_histogram_increment($self->{H}, 50.5 );
    ok_status(gsl_histogram_sub($self->{H}, $h2));
    cmp_ok(gsl_histogram_get($self->{H}, 50), '==', 0);
}

sub MUL : Tests {
    my $self = shift;
    my $h2 = gsl_histogram_alloc(100);
    gsl_histogram_set_ranges_uniform($h2, 0, 100);
    gsl_histogram_accumulate($h2, 50.5, 2);
    gsl_histogram_accumulate($self->{H}, 50.5, 3);
    ok_status(gsl_histogram_mul($self->{H}, $h2));
    cmp_ok(gsl_histogram_get($self->{H}, 50), '==', 6);
}

sub DIV	: Tests {
    my $self = shift;
    my $h2 = gsl_histogram_alloc(100);
    ok_status(gsl_histogram_set_ranges_uniform($h2, 0, 100));
    ok_status(gsl_histogram_accumulate($h2, 50.5, 2));
    ok_status(gsl_histogram_accumulate($self->{H}, 50.5, 4));
    ok_status(gsl_histogram_div($self->{H}, $h2));
    cmp_ok(gsl_histogram_get($self->{H}, 50), '==', 2);
}

sub SCALE : Tests {
    my $self = shift;
    gsl_histogram_accumulate($self->{H}, 50.5, 4);
    gsl_histogram_increment($self->{H}, 33.5 );
    ok_status(gsl_histogram_scale($self->{H}, 2));
    cmp_ok(gsl_histogram_get($self->{H}, 50), '==', 8);
    cmp_ok(gsl_histogram_get($self->{H}, 33), '==', 2);
}

sub FPRINTF_FSCANF : Tests {
    my $self = shift;
    my $stream = gsl_fopen("histogram", 'w');
    ok_status(gsl_histogram_increment($self->{H}, 50.5 ));

    ok_status(gsl_histogram_fprintf($stream, $self->{H}, "%e", "%e"));  
    ok_status(gsl_fclose($stream));
   
    $stream = gsl_fopen("histogram", 'r');
    my $h = gsl_histogram_alloc(100);  
    ok_status(gsl_histogram_fscanf($stream, $h));  
    is_deeply( [ map { gsl_histogram_get($h, $_) } (0..99) ],
               [ (0) x 50, 1, (0) x 49 ]
    );
    ok_status(gsl_fclose($stream));
}

sub PDF_ALLOC : Tests {
    my $pdf = gsl_histogram_pdf_alloc(100);
    isa_ok($pdf, 'Math::GSL::Histogram' );
    gsl_histogram_pdf_free($pdf);
    ok(!$@, 'gsl_histogram_free');
}

sub PDF_INIT : Tests {
    my $self = shift;
    my $p = gsl_histogram_pdf_alloc(100);
    ok_status(gsl_histogram_pdf_init ($p, $self->{H}));
    gsl_histogram_accumulate($self->{H}, 50.5, -4);
    ok_status(gsl_histogram_pdf_init ($p, $self->{H}), $GSL_EDOM);
}

sub GSL_HISTOGRAM_PDF_SAMPLE : Tests {
    my $p = gsl_histogram_pdf_alloc(100);
    ok_status(gsl_histogram_pdf_sample( $p, 0.5 ));
}
Test::Class->runtests;
