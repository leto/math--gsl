package Math::GSL::Histogram2D::Test;
use base q{Test::Class};
use Test::More tests => 89;
use Math::GSL              qw/:all/;
use Math::GSL::Test        qw/:all/;
use Math::GSL::Errno       qw/:all/;
use Math::GSL::Histogram2D qw/:all/;
use Data::Dumper;
use strict;

BEGIN{ gsl_set_error_handler_off(); }

sub make_fixture : Test(setup) {
    my $self = shift;
    $self->{H} = gsl_histogram2d_alloc( 100, 100 );
    gsl_histogram2d_set_ranges_uniform($self->{H}, 1, 100, 1, 100);
}

sub teardown : Test(teardown) {
    unlink 'histogram2d' if -f 'histogram2d';
}

sub GSL_HISTOGRAM2D_ALLOC : Tests {
    my $h = gsl_histogram2d_alloc(100,100);
    isa_ok($h, 'Math::GSL::Histogram2D');
    gsl_histogram2d_free($h);
    ok(!$@, 'gsl_histogram_free');
}

sub GSL_HISTOGRAM2D_SET_RANGES : Tests { 
    my $self = shift;
    my $ranges = [ 0 .. 100];
    ok_status(gsl_histogram2d_set_ranges($self->{H}, $ranges, 100 + 1, $ranges, 100+1));
}

sub GSL_HISTOGRAM2D_SET_RANGES_UNIFORM : Tests {
    my $self = shift;
    ok_status(gsl_histogram2d_set_ranges_uniform($self->{H}, 0, 100, 0, 100));
}

sub MEMCPY : Tests {
    my $self = shift;
    my $copy = gsl_histogram2d_alloc(100,100);

    ok_status(gsl_histogram2d_memcpy($copy, $self->{H}));

    my $bob = gsl_histogram2d_alloc(50,50);
    ok_status(gsl_histogram2d_memcpy($bob, $self->{H}), $GSL_EINVAL);
}

sub CLONE : Tests {
    my $self = shift;
    my $copy = gsl_histogram2d_clone($self->{H});
    isa_ok( $copy, 'Math::GSL::Histogram2D::gsl_histogram2d');
}

sub INCREMENT : Tests { 
    my $self = shift;
    gsl_histogram2d_set_ranges_uniform($self->{H}, 0, 100, 0, 100);

    ok_status(gsl_histogram2d_increment($self->{H}, 50.5, 50.5 ));
    ok_status(gsl_histogram2d_increment($self->{H}, -150.5, -150.5 ), $GSL_EDOM);
    ok_status(gsl_histogram2d_increment($self->{H}, 150.5, 150.5 ), $GSL_EDOM);
}

sub GET : Tests { 
    my $self = shift;
    gsl_histogram2d_set_ranges_uniform($self->{H}, 0, 100, 0, 100);

    ok_status(gsl_histogram2d_increment($self->{H}, 50.5, 50.5 ));
    cmp_ok(1,'==', gsl_histogram2d_get($self->{H}, 50, 50 ) );
}

sub XMIN_XMAX_YMIN_YMAX : Tests {
    my $self = shift;
    gsl_histogram2d_set_ranges_uniform($self->{H}, 0, 100, 0, 100);
    cmp_ok(100,'==', gsl_histogram2d_xmax($self->{H}));
    cmp_ok(0,'==', gsl_histogram2d_xmin($self->{H}));
    cmp_ok(100,'==', gsl_histogram2d_ymax($self->{H}));
    cmp_ok(0,'==', gsl_histogram2d_ymin($self->{H}));
}

sub MIN_VAL_MAX_VAL : Tests {
    my $self = shift;
    gsl_histogram2d_set_ranges_uniform($self->{H}, 0, 100, 0, 100);
    ok_status(gsl_histogram2d_increment($self->{H}, 50.5, 50.5 ));

    cmp_ok(1,'==', gsl_histogram2d_max_val($self->{H}));
    cmp_ok(0,'==', gsl_histogram2d_min_val($self->{H}));
}

sub MEAN : Tests {
    my $self = shift;
    gsl_histogram2d_set_ranges_uniform($self->{H}, 0, 100, 0, 100);
    ok_status(gsl_histogram2d_increment($self->{H}, 50.5, 50.5 ));
    ok_status(gsl_histogram2d_increment($self->{H}, 11.5, 11.5 ));

    ok_similar(31, gsl_histogram2d_xmean($self->{H}));
    ok_similar(31, gsl_histogram2d_ymean($self->{H}));
}

sub SUM : Tests {
    my $self = shift;
    gsl_histogram2d_set_ranges_uniform($self->{H}, 0, 100, 0, 100);
    
    ok_status(gsl_histogram2d_increment($self->{H}, 50.5, 50.5 ));
    ok_status(gsl_histogram2d_increment($self->{H}, 11.5, 11.5 ));
    ok_similar(2, gsl_histogram2d_sum($self->{H}));
}

sub SHIFT : Tests {
    my $h = gsl_histogram2d_alloc(5,5);
    gsl_histogram2d_set_ranges_uniform($h, 0, 5, 0, 5);
    ok_status(gsl_histogram2d_shift($h, 2));
    for my $i (0..4) {
    is_deeply( [ map { gsl_histogram2d_get($h, $_, $i) } (0..4) ],
               [ (2) x 5 ]
    );}
}

sub FWRITE_FREAD : Tests {
    my $H = gsl_histogram2d_alloc(5,5);
    my $stream = gsl_fopen("histogram2d", 'w');
    gsl_histogram2d_set_ranges_uniform($H, 0, 5, 0, 5);
    ok_status(gsl_histogram2d_increment($H, 0.5, 1.5 ));

    ok_status(gsl_histogram2d_fwrite($stream, $H));  
    ok_status(gsl_fclose($stream));
   
    $stream = gsl_fopen("histogram2d", 'r');
    my $h = gsl_histogram2d_alloc(5, 5);  
    ok_status(gsl_histogram2d_fread($stream, $h));  
    is_deeply( [ map { gsl_histogram2d_get($h, 0, $_) } (0..4) ],
               [ 0, 1, (0) x 3 ]
    );
    for my $i (1..4) {
    is_deeply( [ map { gsl_histogram2d_get($h, $i, $_) } (0..4) ],
               [ (0) x 5 ]
    );}
    ok_status(gsl_fclose($stream));
}

sub GET_XRANGE_YRANGE : Tests {
    my $self = shift;
    gsl_histogram2d_set_ranges_uniform($self->{H}, 0, 100, 0, 100);
    my @got = gsl_histogram2d_get_xrange($self->{H}, 50);
    ok_status($got[0]);
    @got = gsl_histogram2d_get_yrange($self->{H}, 50);
    ok_status($got[0]);
    is_deeply( [ $got[1], $got[2]], [50, 51]);
    is_deeply( [ $got[1], $got[2]], [50, 51]);
}

sub FIND : Tests {
    my $self = shift;
    gsl_histogram2d_set_ranges_uniform($self->{H}, 0, 100, 0, 100);
    my @got = gsl_histogram2d_find($self->{H}, 1, 1);
    ok_status($got[0]);
    cmp_ok($got[1], '==', 1);
    cmp_ok($got[2], '==', 1);
}

sub ACCUMULATE : Tests {
    my $self = shift;
    gsl_histogram2d_set_ranges_uniform($self->{H}, 0, 100, 0, 100);

    ok_status(gsl_histogram2d_accumulate($self->{H}, 50.5, 50.5, 3 ));
    cmp_ok(3,'==', gsl_histogram2d_get($self->{H}, 50, 50 ) );
    ok_status(gsl_histogram2d_accumulate($self->{H}, -150.5, -150.5, 3 ), $GSL_EDOM);
}

sub NX_NY : Tests { 
    my $self = shift;
    gsl_histogram2d_set_ranges_uniform($self->{H}, 0, 100, 0, 100);
    cmp_ok(gsl_histogram2d_nx($self->{H}), '==', 100);
    cmp_ok(gsl_histogram2d_ny($self->{H}), '==', 100);
}

sub RESET : Tests {
    my $h = gsl_histogram2d_alloc(5,5);
    gsl_histogram2d_set_ranges_uniform($h, 0, 5, 0, 5);
    gsl_histogram2d_shift($h, 2);
    gsl_histogram2d_reset($h);
    for my $i (0..4) {
    is_deeply( [ map { gsl_histogram2d_get($h, $i, $_) } (0..4) ],
               [ (0) x 5 ]
    );}
}

sub MIN_BIN_MAX_BIN : Tests {
    my $self = shift;
    gsl_histogram2d_set_ranges_uniform($self->{H}, 0, 100, 0, 100);
    gsl_histogram2d_increment($self->{H}, 50.5, 50.5);
    cmp_ok(gsl_histogram2d_min_bin($self->{H}), '==', 0);
    cmp_ok(gsl_histogram2d_max_bin($self->{H}), '==', 50);
}

sub GSL_HISTOGRAM2D_XSIGMA : Tests(1) {
    my $self = shift;

    local $TODO = "gsl_histogram2d_xsigma";

    gsl_histogram2d_increment($self->{H}, 0, 42);
    gsl_histogram2d_increment($self->{H}, 42, 1);

    my $xsigma = gsl_histogram2d_xsigma($self->{H});
    # what is the correct answer?
    is_similar(42, $xsigma, 1e-8, 'gsl_histogram2d_xsigma');
}

sub EQUAL_BINS_P : Tests { 
    my $self = shift;
    my $h2 = gsl_histogram2d_alloc(100,100);
    gsl_histogram2d_set_ranges_uniform($self->{H}, 0, 100, 0, 100);
    gsl_histogram2d_set_ranges_uniform($h2, 0, 100, 0, 100);
    cmp_ok(gsl_histogram2d_equal_bins_p($self->{H}, $h2), '==', 1);
    gsl_histogram2d_set_ranges_uniform($self->{H}, 0, 50, 0, 50);
    cmp_ok(gsl_histogram2d_equal_bins_p($self->{H}, $h2), '==', 0);
}

sub ADD : Tests {
    my $self = shift;
    my $h2 = gsl_histogram2d_alloc(100, 100);
    gsl_histogram2d_set_ranges_uniform($self->{H}, 0, 100, 0, 100);
    gsl_histogram2d_set_ranges_uniform($h2, 0, 100, 0, 100);
    gsl_histogram2d_increment($h2, 50.5, 50.5 );
    ok_status(gsl_histogram2d_add($self->{H}, $h2));
    cmp_ok(gsl_histogram2d_get($self->{H}, 50, 50), '==', 1);
}

sub SUB : Tests {
    my $self = shift;
    my $h2 = gsl_histogram2d_alloc(100, 100);
    gsl_histogram2d_set_ranges_uniform($self->{H}, 0, 100, 0, 100);
    gsl_histogram2d_set_ranges_uniform($h2, 0, 100, 0, 100);
    gsl_histogram2d_increment($h2, 50.5, 50.5 );
    gsl_histogram2d_increment($self->{H}, 50.5, 50.5 );
    ok_status(gsl_histogram2d_sub($self->{H}, $h2));
    cmp_ok(gsl_histogram2d_get($self->{H}, 50, 50), '==', 0);
}

sub MUL : Tests {
    my $self = shift;
    my $h2 = gsl_histogram2d_alloc(100, 100);
    gsl_histogram2d_set_ranges_uniform($self->{H}, 0, 100, 0, 100);
    gsl_histogram2d_set_ranges_uniform($h2, 0, 100, 0, 100);
    gsl_histogram2d_accumulate($h2, 50.5, 50.5, 2);
    gsl_histogram2d_accumulate($self->{H}, 50.5, 50.5, 3);
    ok_status(gsl_histogram2d_mul($self->{H}, $h2));
    cmp_ok(gsl_histogram2d_get($self->{H}, 50, 50), '==', 6);
}

sub DIV	: Tests {
    my $self = shift;
    my $h2 = gsl_histogram2d_alloc(100, 100);
    gsl_histogram2d_set_ranges_uniform($self->{H}, 0, 100, 0, 100);
    gsl_histogram2d_set_ranges_uniform($h2, 0, 100, 0, 100);
    gsl_histogram2d_accumulate($h2, 50.5, 50.5, 2);
    gsl_histogram2d_accumulate($self->{H}, 50.5, 50.5, 4);
    ok_status(gsl_histogram2d_div($self->{H}, $h2));
    cmp_ok(gsl_histogram2d_get($self->{H}, 50, 50), '==', 2);
}

sub SCALE : Tests {
    my $self = shift;
    gsl_histogram2d_set_ranges_uniform($self->{H}, 0, 100, 0, 100);
    gsl_histogram2d_accumulate($self->{H}, 50.5, 50.5, 4);
    gsl_histogram2d_increment($self->{H}, 33.5, 33.5 );
    ok_status(gsl_histogram2d_scale($self->{H}, 2));
    cmp_ok(gsl_histogram2d_get($self->{H}, 50, 50), '==', 8);
    cmp_ok(gsl_histogram2d_get($self->{H}, 33, 33), '==', 2);
}

sub FPRINTF_FSCANF : Tests {
    my $H = gsl_histogram2d_alloc(5,5);
    my $stream = gsl_fopen("histogram2d", 'w');
    gsl_histogram2d_set_ranges_uniform($H, 0, 5, 0, 5);
    ok_status(gsl_histogram2d_increment($H, 0.5, 0.5 ));

    ok_status(gsl_histogram2d_fprintf($stream, $H, "%e", "%e"));  
    ok_status(gsl_fclose($stream));
   
    $stream = gsl_fopen("histogram2d", 'r');
    my $h = gsl_histogram2d_alloc(5,5);  
    ok_status(gsl_histogram2d_fscanf($stream, $h));  
    is_deeply( [ map { gsl_histogram2d_get($h, 0, $_) } (0..4) ],
               [ 1, (0) x 4 ]
    );
    for my $i (1..4) {
    is_deeply( [ map { gsl_histogram2d_get($h, $i, $_) } (0..4) ],
               [ (0) x 5 ]
    );}
    ok_status(gsl_fclose($stream));
}

sub PDF_ALLOC : Tests {
    my $pdf = gsl_histogram2d_pdf_alloc(100,100);
    isa_ok($pdf, 'Math::GSL::Histogram2D' );
    gsl_histogram2d_pdf_free($pdf);
    ok(!$@, 'gsl_histogram2d_free');
}

sub PDF_INIT : Tests {
    my $self = shift;
    my $p = gsl_histogram2d_pdf_alloc(100, 100);
    gsl_histogram2d_set_ranges_uniform($self->{H}, 0, 100, 0, 100);
    ok_status(gsl_histogram2d_pdf_init ($p, $self->{H}));
    gsl_histogram2d_accumulate($self->{H}, 50.5, 50.5, -4);
    ok_status(gsl_histogram2d_pdf_init ($p, $self->{H}), $GSL_EDOM);
}

sub GSL_HISTOGRAM_PDF_SAMPLE : Tests {
 local $TODO = "Don't know how to test this function";
}
Test::Class->runtests;
