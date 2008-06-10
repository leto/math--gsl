package Math::GSL::Matrix::Test;
use base q{Test::Class};
use Test::More;
use Math::GSL::Matrix qw/:all/;
use Math::GSL::Vector qw/:all/;
use Math::GSL qw/:all/;
use Data::Dumper;
use strict;

sub make_fixture : Test(setup) {
    my $self = shift;
    $self->{matrix} = gsl_matrix_alloc(5,5);

}

sub teardown : Test(teardown) {
    unlink 'matrix' if -f 'matrix';
}

sub GSL_MATRIX_ALLOC : Tests {
    my $matrix = gsl_matrix_alloc(5,5);
    isa_ok($matrix, 'Math::GSL::Matrix');
}

sub GSL_MATRIX_SET : Tests {
    my $self = shift;
    map { gsl_matrix_set($self->{matrix}, $_,$_, $_ ** 2) } (0..4);

    my @got = map { gsl_matrix_get($self->{matrix}, $_, $_) } (0..4);
    ok_similar( [ @got ], [ map { $_**2 } (0..4) ] );

}

sub GSL_MATRIX_CALLOC : Tests {
   my $matrix = gsl_matrix_calloc(5,5);
   isa_ok($matrix, 'Math::GSL::Matrix');

   my @got = map { gsl_matrix_get($matrix, $_, $_) } (0..4);
   ok_similar( [ @got ], [ 0,0,0,0,0 ], 'gsl_matrix_calloc' );
}

sub GSL_MATRIX_FREE : Tests {
   my $matrix = gsl_matrix_calloc(5,5);
   isa_ok($matrix, 'Math::GSL::Matrix');

   is(gsl_matrix_get($matrix, 0, 0), 0);
   gsl_matrix_free($matrix);
   
}

sub GSL_MATRIX_SUBMATRIX : Tests {
   my $matrix = gsl_matrix_alloc(5,5);
   map { gsl_matrix_set($matrix, $_,$_, $_) } (0..4);
   my $subMatrix = gsl_matrix_submatrix($matrix, 0, 0, 2, 2);
   my @got = map { gsl_matrix_get($matrix, $_, $_) } (0..2);
   ok_similar( [ @got ], [ 0..2 ] );
}

sub GSL_MATRIX_ROW : Tests {
   my $self = shift;
   my $line;
   for ($line=0; $line<5; $line++) {
   map { gsl_matrix_set($self->{matrix}, $_,$line, $_) } (0..4); }

   my $vector_view = gsl_matrix_row($self->{matrix}, 1);
   my @got = map { gsl_vector_get($vector_view->{vector}, $_) } (0..4);
   map { is($got[$_], $_) } (0..4);
}

sub GSL_MATRIX_COLUMN : Tests {
    my $self = shift;
    my $view = gsl_vector_alloc(5);

    for my $line (0..4) {
        map { gsl_matrix_set($self->{matrix}, $line,$_, $_) } (0..4); 
    }
    $view = gsl_matrix_column($self->{matrix}, 1);
    print Dumper [ $view  ];

    my @got = map { gsl_vector_get($view, $_) } (0..4);
    ok_similar( [ @got ], [ 0 .. 4 ], 'gsl_matrix_column' );
}

sub GSL_MATRIX_DIAGONAL : Tests {
   my $matrix = gsl_matrix_alloc(4,4);
   map { gsl_matrix_set($matrix, $_,$_, $_) } (0..3);
   my $vector = gsl_matrix_diagonal($matrix);
   my @got = map { gsl_vector_get($vector, $_) } (0..3);
   ok_similar( [ @got ], [ 0 .. 3 ], 'gsl_matrix_diagonal');
}

sub GSL_MATRIX_SUBDIAGONAL : Tests {
   my $matrix = gsl_matrix_alloc(4,4);
   map { gsl_matrix_set($matrix, $_,$_, $_) } (0..3);
   my $vector = gsl_matrix_subdiagonal($matrix, 0);
   my @got = map { gsl_vector_get($vector, $_) } (0..3);
   ok_similar( [ @got ], [ 0 .. 3 ], 'gsl_matrix_subdiagonal');

   $vector = gsl_matrix_subdiagonal($matrix, 1);
   @got = map { gsl_vector_get($vector, $_) } (0..2);
   ok_similar( [ @got ], [ 1 .. 3 ], 'gsl_matrix_subdiagonal');
}

sub GSL_MATRIX_SWAP : Tests {
   my $self=shift;
   map { gsl_matrix_set($self->{matrix}, $_,$_, $_ ** 2) } (0..4);
   my $matrix = gsl_matrix_alloc(5,5);
   map { gsl_matrix_set($matrix, $_,$_, $_) } (0..4);
   is(gsl_matrix_swap($self->{matrix}, $matrix) ,0);
   my @got = map { gsl_matrix_get($self->{matrix}, $_, $_) } (0..4);
   map { is($got[$_], $_) } (0..4);
   @got = map { gsl_matrix_get($matrix, $_, $_) } (0..4);
   map { is($got[$_], $_** 2) } (0..4); 
}

sub GSL_MATRIX_MEMCPY : Tests {
   my $self = shift;
   my $matrix = gsl_matrix_alloc(5,5);
   map { gsl_matrix_set($self->{matrix}, $_,$_, $_ ** 2) } (0..4);
   is(gsl_matrix_memcpy($matrix, $self->{matrix}), 0);
   my @got = map { gsl_matrix_get($matrix, $_, $_) } (0..4);
   map { is($got[$_], $_** 2) } (0..4);  
}  

sub GSL_MATRIX_SWAP_ROWS : Tests {
   my $self = shift; 
   map { gsl_matrix_set($self->{matrix}, 0,$_, $_) } (0..4);
   map { gsl_matrix_set($self->{matrix}, 1,$_, 3) } (0..4);
   is(gsl_matrix_swap_rows($self->{matrix}, 0, 1), 0);
   my @got = map { gsl_matrix_get($self->{matrix}, 1, $_) } (0..4);
   map { is($got[$_], $_) } (0..4);   
   @got = map { gsl_matrix_get($self->{matrix}, 0, $_) } (0..4);
   map { is($got[$_], 3) } (0..4);   
}

sub GSL_MATRIX_SWAP_COLUMNS : Tests {
   my $self = shift;
   map { gsl_matrix_set($self->{matrix}, $_,0, $_) } (0..4);
   map { gsl_matrix_set($self->{matrix}, $_,1, 3) } (0..4);
   is(gsl_matrix_swap_columns($self->{matrix}, 0, 1), 0);
   my @got = map { gsl_matrix_get($self->{matrix}, $_, 1) } (0..4);
   map { is($got[$_], $_) } (0..4);   
   @got = map { gsl_matrix_get($self->{matrix}, $_, 0) } (0..4);
   map { is($got[$_], 3) } (0..4);   
}

sub GSL_MATRIX_SWAP_ROWCOL : Tests {
   my $self = shift;
   map { gsl_matrix_set($self->{matrix}, 0,$_, $_) } (0..4);
   map { gsl_matrix_set($self->{matrix}, $_,2, 2) } (0..4);
   is(gsl_matrix_swap_rowcol($self->{matrix}, 0, 2), 0);
   
   my @got = map { gsl_matrix_get($self->{matrix}, $_, 2) } (0..4);
   is_deeply( [ @got ], [ qw/2 1 0 3 4/  ] );

   @got = map { gsl_matrix_get($self->{matrix}, 0, $_) } (0..4);
   is_deeply( [ @got ], [ qw/2 2 2 2 2/ ] );
}

sub GSL_MATRIX_TRANSPOSE_MEMCPY : Tests {
   my $self = shift;
   map { gsl_matrix_set($self->{matrix}, 0,$_, $_) } (0..4);
   my $matrix = gsl_matrix_alloc(5,5); 
   is(gsl_matrix_transpose_memcpy($matrix, $self->{matrix}), 0);   
   my @got = map { gsl_matrix_get($matrix, $_, 0) } (0..4);
   map { is($got[$_], $_) } (0..4);
}

sub GSL_MATRIX_TRANSPOSE : Tests {
   my $self = shift;
   map { gsl_matrix_set($self->{matrix}, 0,$_, $_) } (0..4); 
   is(gsl_matrix_transpose($self->{matrix}), 0);   
   my @got = map { gsl_matrix_get($self->{matrix}, $_, 0) } (0..4);
   map { is($got[$_], $_) } (0..4);
}

sub GSL_MATRIX_ADD : Tests {
   my $self = shift;
   my $matrix = gsl_matrix_alloc(5, 5);
   map { gsl_matrix_set($self->{matrix}, $_, $_, $_) } (0..4);
   map { gsl_matrix_set($matrix, $_, $_, $_) } (0..4); 
   is(gsl_matrix_add($self->{matrix}, $matrix), 0);
   my @got = map { gsl_matrix_get($self->{matrix}, $_, $_) } (0..4);
   map { is($got[$_], $_*2) } (0..4);
}

sub GSL_MATRIX_SUB : Tests {
   my $self = shift;
   my $matrix = gsl_matrix_alloc(5, 5);
   map { gsl_matrix_set($self->{matrix}, $_, $_, $_) } (0..4);
   map { gsl_matrix_set($matrix, $_, $_, $_) } (0..4); 
   is(gsl_matrix_sub($self->{matrix}, $matrix), 0);
   my @got = map { gsl_matrix_get($self->{matrix}, $_, $_) } (0..4);
   map { is($got[$_], 0) } (0..4);
}

sub GSL_MATRIX_MUL_ELEMENTS : Tests {
   my $self = shift;
   my $matrix = gsl_matrix_alloc(5, 5);
   map { gsl_matrix_set($self->{matrix}, $_, $_, $_) } (0..4);
   map { gsl_matrix_set($matrix, $_, $_, $_) } (0..4); 
   is(gsl_matrix_mul_elements($self->{matrix}, $matrix), 0);
   my @got = map { gsl_matrix_get($self->{matrix}, $_, $_) } (0..4);
   map { is($got[$_], $_**2) } (0..4);
}

sub GSL_MATRIX_DIV_ELEMENTS : Tests {
   my $self = shift;
   my $matrix = gsl_matrix_alloc(5, 5);
   map { gsl_matrix_set($self->{matrix}, $_, $_, $_+1) } (0..4);
   map { gsl_matrix_set($matrix, $_, $_, $_+1) } (0..4); 
   is(gsl_matrix_div_elements($self->{matrix}, $matrix), 0);
   my @got = map { gsl_matrix_get($self->{matrix}, $_, $_) } (0..4);
   map { is($got[$_], 1) } (0..4);
}

sub GSL_MATRIX_SCALE : Tests {
   my $self = shift; 
   map { gsl_matrix_set($self->{matrix}, $_, $_, $_) } (0..4); 
   is(gsl_matrix_scale($self->{matrix}, 4), 0);
   my @got = map { gsl_matrix_get($self->{matrix}, $_, $_) } (0..4);
   map { is($got[$_], $_*4) } (0..4);
}

sub GSL_MATRIX_ADD_CONSTANT : Tests {
   my $self = shift; 
   map { gsl_matrix_set($self->{matrix}, $_, $_, $_) } (0..4); 
   is(gsl_matrix_add_constant($self->{matrix}, 8), 0);
   my @got = map { gsl_matrix_get($self->{matrix}, $_, $_) } (0..4);
   map { is($got[$_], $_+8) } (0..4);
}

sub GSL_MATRIX_MAX : Tests {
   my $self = shift;
   my $line;   
   for($line=0; $line<5; $line++) {
   map { gsl_matrix_set($self->{matrix}, $line, $_, $_**2 ) } (0..4); } 
   is(gsl_matrix_max($self->{matrix}), 16);
}

sub GSL_MATRIX_MIN : Tests {
   my $self = shift;
   my $line;
   for($line=0; $line<5; $line++) {
   map { gsl_matrix_set($self->{matrix}, $line, $_, $_**2 ) } (0..4); } 
   is(gsl_matrix_min($self->{matrix}), 0);
}

sub GSL_MATRIX_MINMAX : Test {
   my $self = shift;
   my ($min, $max);
   map { gsl_matrix_set($self->{matrix}, $_, $_, $_**2) } (0..4); 
   gsl_matrix_minmax($self->{matrix}, \$min, \$max);
   is($min, 0);
   is($max, 16);
}

sub GSL_MATRIX_MAX_INDEX : Tests {
   my $self = shift;
   my ($imax, $jmax);
   map { gsl_matrix_set($self->{matrix}, $_, $_, $_**2) } (0..4); 
   ($imax, $jmax) = gsl_matrix_max_index($self->{matrix}, $imax, $jmax);
   ok_similar( [ $imax, $jmax ], [ 0 .. 4 ], 'gsl_matrix_max_index' );
}

sub GSL_MATRIX_ISNULL : Tests {
   my $self = shift;
   my $line;
   is(gsl_matrix_isnull($self->{matrix}), 0);
   for($line=0; $line<5; $line++) {
   map { gsl_matrix_set($self->{matrix}, $line, $_, 0) } (0..4); }
   is(gsl_matrix_isnull($self->{matrix}), 1);
}

sub GSL_MATRIX_ISPOS : Tests {
   my $self = shift;
   my $line;
   
   for($line=0; $line<5; $line++) {
   map { gsl_matrix_set($self->{matrix}, $line, $_, -1) } (0..4); }
   is(gsl_matrix_ispos($self->{matrix}), 0);
   
   for($line=0; $line<5; $line++) {
   map { gsl_matrix_set($self->{matrix}, $line, $_, 1) } (0..4); }
   is(gsl_matrix_ispos($self->{matrix}), 1);
   
   for($line=0; $line<5; $line++) {
   map { gsl_matrix_set($self->{matrix}, $line, $_, 0) } (0..4); }
   is(gsl_matrix_ispos($self->{matrix}), 0);
}

sub GSL_MATRIX_ISNEG : Tests {
   my $self = shift;
   my $line;
   
   for($line=0; $line<5; $line++) {
   map { gsl_matrix_set($self->{matrix}, $line, $_, -1) } (0..4); }
   is(gsl_matrix_isneg($self->{matrix}), 1);
   
   for($line=0; $line<5; $line++) {
   map { gsl_matrix_set($self->{matrix}, $line, $_, 1) } (0..4); }
   is(gsl_matrix_isneg($self->{matrix}), 0);
   
   for($line=0; $line<5; $line++) {
   map { gsl_matrix_set($self->{matrix}, $line, $_, 0) } (0..4); }
   is(gsl_matrix_isneg($self->{matrix}), 0);
}

sub GSL_MATRIX_ISNONNEG : Tests {
   my $self = shift;
   my $line;
   
   for($line=0; $line<5; $line++) {
   map { gsl_matrix_set($self->{matrix}, $line, $_, -1) } (0..4); }
   is(gsl_matrix_isnonneg($self->{matrix}), 0);
   
   for($line=0; $line<5; $line++) {
   map { gsl_matrix_set($self->{matrix}, $line, $_, 1) } (0..4); }
   is(gsl_matrix_isnonneg($self->{matrix}), 1);
   
   for($line=0; $line<5; $line++) {
   map { gsl_matrix_set($self->{matrix}, $line, $_, 0) } (0..4); }
   is(gsl_matrix_isnonneg($self->{matrix}), 1);
}

sub GSL_MATRIX_GET_ROW : Tests {
   my $self = shift;
   my $vector->{vector} = gsl_vector_alloc(5);
   map { gsl_matrix_set($self->{matrix}, 0, $_, $_) } (0..4);
   is(gsl_matrix_get_row($vector->{vector}, $self->{matrix}, 0), 0);
   map { is(gsl_vector_get($vector->{vector}, $_), $_) } (0..4); 
}

sub GSL_MATRIX_GET_COL : Tests {
   my $self = shift;
   my $vector->{vector} = gsl_vector_alloc(5);
   map { gsl_matrix_set($self->{matrix}, $_, 0, $_) } (0..4);
   is(gsl_matrix_get_col($vector->{vector}, $self->{matrix}, 0), 0);
   map { is(gsl_vector_get($vector->{vector}, $_), $_) } (0..4); 
}

sub GSL_MATRIX_SET_ROW : Tests {
   my $self = shift;
   my $vector->{vector} = gsl_vector_alloc(5);
   map { gsl_vector_set($vector->{vector}, $_, $_**2) } (0..4);
   is(gsl_matrix_set_row($self->{matrix}, 1, $vector->{vector}), 0);
   map { is(gsl_matrix_get($self->{matrix}, 1, $_), $_**2) } (0..4);  
}

sub GSL_MATRIX_SET_COL : Tests {
   my $self = shift;
   my $vector->{vector} = gsl_vector_alloc(5);
   map { gsl_vector_set($vector->{vector}, $_, $_**2) } (0..4);
   is(gsl_matrix_set_col($self->{matrix}, 1, $vector->{vector}), 0);
   map { is(gsl_matrix_get($self->{matrix}, $_, 1), $_**2) } (0..4);  
}

sub GSL_MATRIX_FREAD_FWRITE : Tests {
   my $self = shift;
   my $line;
   for ($line=0; $line<5; $line++) {
   map { gsl_matrix_set($self->{matrix}, $line, $_, $_**2) } (0..4); }

   my $fh = fopen("matrix", "w");
   is( gsl_matrix_fwrite($fh, $self->{matrix}), 0);
   fclose($fh);

   for ($line=0; $line<5; $line++) {
   map { gsl_matrix_set($self->{matrix}, $line, $_, $_**3) } (0..4); }

   $fh = fopen("matrix", "r");   
   
   is(gsl_matrix_fread($fh, $self->{matrix}), 0);
   for ($line=0; $line<5; $line++) {
   map { is(gsl_matrix_get($self->{matrix}, $line, $_), $_**2) } (0..4); }
   fclose($fh); 
}

sub GSL_MATRIX_FPRINTF_FSCANF : Tests {
   my $self = shift;
   my $line;
   for ($line=0; $line<5; $line++) {
   map { gsl_matrix_set($self->{matrix}, $line, $_, $_**2) } (0..4); }

   my $fh = fopen("matrix", "w");
   is( gsl_matrix_fprintf($fh, $self->{matrix}, "%f"), 0);
   fclose($fh);

   for ($line=0; $line<5; $line++) {
   map { gsl_matrix_set($self->{matrix}, $line, $_, $_**3) } (0..4); }

   $fh = fopen("matrix", "r");   
   
   is(gsl_matrix_fscanf($fh, $self->{matrix}), 0);
   for ($line=0; $line<5; $line++) {
   map { is(gsl_matrix_get($self->{matrix}, $line, $_), $_**2) } (0..4); }
   fclose($fh); 
}

1;
