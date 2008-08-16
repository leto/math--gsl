package Math::GSL::Matrix::Test;
use base q{Test::Class};
use Test::More;
use Math::GSL::Matrix qw/:all/;
use Math::GSL::Vector qw/:all/;
use Math::GSL::Complex qw/:all/;
use Math::GSL::Errno qw/:all/;
use Math::GSL qw/:all/;
use Data::Dumper;
use strict;

BEGIN{ gsl_set_error_handler_off(); }

sub make_fixture : Test(setup) {
    my $self = shift;
    $self->{matrix} = gsl_matrix_alloc(5,5);
    $self->{obj}    = Math::GSL::Matrix->new(5,5);
    gsl_matrix_set_zero($self->{matrix});
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
   ok_similar( [ @got ], [ (0) x 5 ], 'gsl_matrix_calloc' );
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
   for my $line (0..4) {
        map { gsl_matrix_set($self->{matrix}, $_,$line, $_) } (0..4); 
   }

   my $vector_view = gsl_matrix_row($self->{matrix}, 2);
   my @got = map { gsl_vector_get($vector_view->{vector}, $_) } (0..4);
   ok_similar( [ @got ], [ (2)x 5], 'gsl_matrix_row' );
}

sub GSL_MATRIX_COLUMN : Tests {
    my $self = shift;
    my $view = gsl_vector_alloc(5);

    for my $line (0..4) {
        map { gsl_matrix_set($self->{matrix}, $line,$_, $line*$_) } (0..4); 
    }
    $view = gsl_matrix_column($self->{matrix}, 2);
    my $vec = $view->swig_vector_get();

    my @got = map { gsl_vector_get($vec, $_) } (0..4);
    ok_similar( [ @got ], [0,2,4,6,8 ], 'gsl_matrix_column' );
}

sub GSL_MATRIX_DIAGONAL : Tests {
   my $matrix = gsl_matrix_alloc(4,4);
   map { gsl_matrix_set($matrix, $_,$_, $_) } (0..3);
   my $view = gsl_matrix_diagonal($matrix);
   # better interface is needed
   my $vec = $view->swig_vector_get();

   my @got = map { gsl_vector_get($vec, $_) } (0..3);
   ok_similar( [ @got ], [ 0 .. 3 ], 'gsl_matrix_diagonal');
}

sub GSL_MATRIX_SUBDIAGONAL : Tests {
   my $matrix = gsl_matrix_alloc(4,4);

   map { gsl_matrix_set($matrix, $_,$_, $_)     } (0..3);

   my $view = gsl_matrix_subdiagonal($matrix, 0);
   my $vec  = $view->swig_vector_get();
   my @got  = map { gsl_vector_get($vec, $_) } (0..3);
   ok_similar( [ @got ], [ 0 .. 3 ], 'gsl_matrix_subdiagonal');
}

sub GSL_MATRIX_SWAP : Tests {
   my $self=shift;
   map { gsl_matrix_set($self->{matrix}, $_,$_, $_ ** 2) } (0..4);
   my $matrix = gsl_matrix_alloc(5,5);
   map { gsl_matrix_set($matrix, $_,$_, $_) } (0..4);
   ok_status(gsl_matrix_swap($self->{matrix}, $matrix));

   my @got = map { gsl_matrix_get($self->{matrix}, $_, $_) } (0..4);
   map { is($got[$_], $_) } (0..4);
   @got = map { gsl_matrix_get($matrix, $_, $_) } (0..4);
   map { is($got[$_], $_** 2) } (0..4); 
}

sub GSL_MATRIX_MEMCPY : Tests {
   my $self = shift;
   my $matrix = gsl_matrix_alloc(5,5);
   map { gsl_matrix_set($self->{matrix}, $_,$_, $_ ** 2) } (0..4);
   ok_status(gsl_matrix_memcpy($matrix, $self->{matrix}));
   ok_similar( [ map { gsl_matrix_get($matrix, $_, $_) } (0..4) ], 
               [ map {  $_** 2 } (0..4)                        ]
   );  
}  

sub GSL_MATRIX_SWAP_ROWS : Tests {
   my $self = shift; 
   map { gsl_matrix_set($self->{matrix}, 0,$_, $_) } (0..4);
   map { gsl_matrix_set($self->{matrix}, 1,$_, 3) } (0..4);
   ok_status(gsl_matrix_swap_rows($self->{matrix}, 0, 1));
   my @got = map { gsl_matrix_get($self->{matrix}, 1, $_) } (0..4);
   map { is($got[$_], $_) } (0..4);   
   @got = map { gsl_matrix_get($self->{matrix}, 0, $_) } (0..4);
   map { is($got[$_], 3) } (0..4);   
}

sub GSL_MATRIX_SWAP_COLUMNS : Tests {
   my $self = shift;
   map { gsl_matrix_set($self->{matrix}, $_,0, $_) } (0..4);
   map { gsl_matrix_set($self->{matrix}, $_,1, 3) } (0..4);
   ok_status(gsl_matrix_swap_columns($self->{matrix}, 0, 1));
   my @got = map { gsl_matrix_get($self->{matrix}, $_, 1) } (0..4);
   map { is($got[$_], $_) } (0..4);   
   @got = map { gsl_matrix_get($self->{matrix}, $_, 0) } (0..4);
   map { is($got[$_], 3) } (0..4);   
}

sub GSL_MATRIX_SWAP_ROWCOL : Tests {
   my $self = shift;
   map { gsl_matrix_set($self->{matrix}, 0,$_, $_) } (0..4);
   map { gsl_matrix_set($self->{matrix}, $_,2, 2) } (0..4);
   ok_status(gsl_matrix_swap_rowcol($self->{matrix}, 0, 2));
   
   my @got = map { gsl_matrix_get($self->{matrix}, $_, 2) } (0..4);
   is_deeply( [ @got ], [ qw/2 1 0 3 4/  ] );

   @got = map { gsl_matrix_get($self->{matrix}, 0, $_) } (0..4);
   is_deeply( [ @got ], [ qw/2 2 2 2 2/ ] );
}

sub GSL_MATRIX_TRANSPOSE_MEMCPY : Tests {
   my $self = shift;
   map { gsl_matrix_set($self->{matrix}, 0,$_, $_) } (0..4);
   my $matrix = gsl_matrix_alloc(5,5); 
   ok_status(gsl_matrix_transpose_memcpy($matrix, $self->{matrix}));   
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
   for my $row (0..4) {
        map { gsl_matrix_set($self->{matrix}, $row, $_, $_**2 ) } (0..4); 
   } 
   is(gsl_matrix_max($self->{matrix}), 16);
}

sub GSL_MATRIX_MIN : Tests {
   my $self = shift;
   for my $row (0..4) {
        map { gsl_matrix_set($self->{matrix}, $row, $_, $_**2 ) } (0..4); 
   } 
   is(gsl_matrix_min($self->{matrix}), 0);
}

sub GSL_MATRIX_MINMAX : Test {
   my $self = shift;
   map { gsl_matrix_set($self->{matrix}, $_, $_, $_**2) } (0..4); 
   my ($min, $max) = gsl_matrix_minmax($self->{matrix});
   ok_similar( [ $min, $max ], [ 0, 16], 'gsl_matrix_minmax' );
}

sub GSL_MATRIX_MAX_INDEX : Tests {
   my $self = shift;
   for my $row (0..3) {
        map { gsl_matrix_set($self->{matrix}, $row, $_, $_) } (0..4); 
   } 
   map { gsl_matrix_set($self->{matrix}, $_, $_, $_**2) } (0..4); 
   my ($imax, $jmax) = gsl_matrix_max_index($self->{matrix});
   ok_similar( [ $imax, $jmax ], [ 4, 4 ], 'gsl_matrix_max_index' );
}

sub GSL_MATRIX_MIN_INDEX : Tests {
   my $self = shift;
   map { gsl_matrix_set($self->{matrix}, $_, $_, $_**2) } (0..4); 
   my ($imin, $jmin) = gsl_matrix_min_index($self->{matrix});
   ok_similar( [ $imin, $jmin ], [ 0, 0 ], 'gsl_matrix_min_index' );

}

sub GSL_MATRIX_ISNULL : Tests {
   my $self = shift;
   for my $line (0..4) {
        map { gsl_matrix_set($self->{matrix}, $line, $_, 0) } (0..4); 
   }
   is(gsl_matrix_isnull($self->{matrix}), 1);

   for my $line (0..4) {
        map { gsl_matrix_set($self->{matrix}, $line, $_, $_) } (0..4); 
   }

   is(gsl_matrix_isnull($self->{matrix}), 0);
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
    for my $row (0..4) {
        map { gsl_matrix_set($self->{matrix}, $row, $_, -1) } (0..4); 
    }
    is(gsl_matrix_isnonneg($self->{matrix}), 0);

    for my $row (0..4) {
        map { gsl_matrix_set($self->{matrix}, $row, $_, 1) } (0..4); 
    }
    is(gsl_matrix_isnonneg($self->{matrix}), 1);

    for my $row (0..4) {
        map { gsl_matrix_set($self->{matrix}, $row, $_, 0) } (0..4); 
    }
    is(gsl_matrix_isnonneg($self->{matrix}), 1);

}

sub GSL_MATRIX_GET_ROW : Tests {
   my $self = shift;
   my $vector = gsl_vector_alloc(5);
   map { gsl_matrix_set($self->{matrix}, 0, $_, $_) } (0..4);
   is(gsl_matrix_get_row($vector, $self->{matrix}, 0), 0);
   map { is(gsl_vector_get($vector, $_), $_) } (0..4); 
}

sub GSL_MATRIX_GET_COL : Tests {
   my $self = shift;
   my $vector = gsl_vector_alloc(5);
   map { gsl_matrix_set($self->{matrix}, $_, 0, $_) } (0..4);
   is(gsl_matrix_get_col($vector, $self->{matrix}, 0), 0);
   map { is(gsl_vector_get($vector, $_), $_) } (0..4); 
}

sub GSL_MATRIX_SET_ROW : Tests {
   my $self = shift;
   my $vector = gsl_vector_alloc(5);
   map { gsl_vector_set($vector, $_, $_**2) } (0..4);
   is(gsl_matrix_set_row($self->{matrix}, 1, $vector), 0);

   ok_similar( [ map { gsl_matrix_get($self->{matrix}, 1, $_) } (0..4) ],
               [ map { $_ ** 2 } (0..4) ],
             );
}

sub GSL_MATRIX_SET_COL : Tests {
   my $self = shift;
   my $vector = gsl_vector_alloc(5);
   map { gsl_vector_set($vector, $_, $_**2) } (0..4);
   is(gsl_matrix_set_col($self->{matrix}, 1, $vector), 0);

   ok_similar( [ map { gsl_matrix_get($self->{matrix}, $_, 1) } (0..4) ],
               [ map { $_ ** 2 } (0..4) ],
             );
} 

sub GSL_MATRIX_FREAD_FWRITE : Tests {
   my $self = shift;
   for my $line (0..4) {
        map { gsl_matrix_set($self->{matrix}, $line, $_, $_**2) } (0..4); 
   }

   my $fh = gsl_fopen("matrix", 'w');
   is( gsl_matrix_fwrite($fh, $self->{matrix}), 0);
   gsl_fclose($fh);

   for my $line (0..4) {
        map { gsl_matrix_set($self->{matrix}, $line, $_, $_**3) } (0..4); 
   }

   $fh = gsl_fopen("matrix", 'r');   
   
   is(gsl_matrix_fread($fh, $self->{matrix}), 0);
   for my $line (0..4) {
        ok_similar( 
                    [ map { gsl_matrix_get($self->{matrix}, $line, $_) } (0..4) ], 
                    [ map { $_**2 } (0..4) ],
                  );
   }
   gsl_fclose($fh); 
}

sub GSL_MATRIX_FPRINTF_FSCANF : Tests {
   my $self = shift;

   for my $line (0..4) {
        map { gsl_matrix_set($self->{matrix}, $line, $_, $_**2) } (0..4); 
   }

   my $write = is_windows() ? "w + b" : "w";
   my $read  = is_windows() ? "r + b" : "r";
   my $fh = fopen("matrix", $write);
   is( gsl_matrix_fprintf($fh, $self->{matrix}, "%f"), 0);
   fclose($fh);

   for my $line (0..4) {
        map { gsl_matrix_set($self->{matrix}, $line, $_, $_**3) } (0..4); 
   }

   $fh = fopen("matrix", $read);   
   
   is(gsl_matrix_fscanf($fh, $self->{matrix}), 0);
   for my $line (0..4) {
        ok_similar( 
                    [ map { gsl_matrix_get($self->{matrix}, $line, $_) } (0..4) ], 
                    [ map { $_**2 } (0..4) ],
                  );
   }
   fclose($fh); 
}

sub GSL_MATRIX_MINMAX_INDEX : Tests { 
   my $self = shift;
   my $line;
   for ($line = 0; $line<4; $line ++) {
   map { gsl_matrix_set($self->{matrix}, $line, $_, $_) } (0..4); }
   map { gsl_matrix_set($self->{matrix}, 4, $_, $_**2) } (0..4);
   my ($imin, $jmin, $imax, $jmax) = gsl_matrix_minmax_index($self->{matrix});
   ok_similar( [ $imin, $jmin, $imax, $jmax ], [ 0, 0, 4, 4], 'gsl_matrix_minmax_index' );
}

sub GSL_MATRIX_ADD_DIAGONAL : Tests {
   my $self = shift;
   map { gsl_matrix_set($self->{matrix}, $_, $_, $_) } (0..4);
   gsl_matrix_add_diagonal($self->{matrix}, 4);
   ok_similar( [ map { gsl_matrix_get($self->{matrix}, $_, $_)} (0..4) ],
               [ 4 .. 8 ], 
             );
}

sub GSL_MATRIX_NEW : Tests {
   my $self = shift;
   isa_ok( $self->{obj}, 'Math::GSL::Matrix' );
   isa_ok( $self->{obj}->raw, 'Math::GSL::Matrix::gsl_matrix' );
   ok( $self->{obj}->rows == 5, '->rows' );
   ok( $self->{obj}->cols == 5, '->cols' );
}

sub AS_LIST_SQUARE : Tests { 
    my $matrix = Math::GSL::Matrix->new(5,5);
    map { gsl_matrix_set($matrix->raw, $_, $_, 5 + $_**2) } (0..4);
    is_deeply( [
                5, 0, 0, 0, 0,
                0, 6, 0, 0, 0,
                0, 0, 9, 0, 0,
                0, 0, 0,14, 0,
                0, 0, 0, 0, 21 
                ], 
               [ $matrix->as_list],
               '$matrix->as_list',
    );
}

sub AS_LIST_ROW : Tests { 
    my $matrix = Math::GSL::Matrix->new(1,5);
    map { gsl_matrix_set($matrix->raw, 0 , $_, 5 + $_**2) } (0..4);
    is_deeply( [ 5, 6, 9, 14, 21, ], 
               [ $matrix->as_list],
               '$matrix->as_list',
    );
}

sub ROW : Tests {
    my $matrix = Math::GSL::Matrix->new(5,5);
    map { gsl_matrix_set($matrix->raw, $_, $_, 5 + $_**2) } (0..4);
    ok_similar( [qw/0 0 9 0 0/] , [$matrix->row(2)->as_list ] );
    map { gsl_matrix_set($matrix->raw, 0, $_, $_) } (0..4);
    ok_similar( [qw/0 1 2 3 4/] , [$matrix->row(0)->as_list ] );
    
}

sub COL : Tests {
    my $matrix = Math::GSL::Matrix->new(3,3);
    map { gsl_matrix_set($matrix->raw, $_, $_, 7 + $_**2) } (0..2);
    ok_similar([7,0,0], [$matrix->col(0)->as_list]);
}

sub NEW_SETS_VALUES_TO_ZERO : Tests {
    my $matrix = Math::GSL::Matrix->new(5,5);
    my $sum;

    map { $sum += $_ } $matrix->as_list;
    ok( $sum == 0, 'new sets values to zero');
}
sub HERMITIAN : Tests {
    my $matrix    = gsl_matrix_complex_alloc(2,2);
    my $transpose = gsl_matrix_complex_alloc(2,2);
    gsl_matrix_complex_set($matrix, 0, 0, gsl_complex_rect(3,0)); 
    gsl_matrix_complex_set($matrix, 0, 1, gsl_complex_rect(2,1));
    gsl_matrix_complex_set($matrix, 1, 0, gsl_complex_rect(2,-1));
    gsl_matrix_complex_set($matrix, 1, 1, gsl_complex_rect(1,0));
    gsl_matrix_complex_memcpy($transpose, $matrix);
    gsl_matrix_complex_transpose($transpose);

    for my $row (0..1) {
        map { gsl_matrix_complex_set($transpose, $row, $_, gsl_complex_conjugate(gsl_matrix_complex_get($transpose, $row, $_))) } (0..1); 
    }

    my $upper_right = gsl_matrix_complex_get($matrix, 0, 1 );
    my $lower_left  = gsl_matrix_complex_get($matrix, 1, 0 );

    ok( gsl_complex_eq( gsl_complex_conjugate($upper_right), $lower_left ), 'hermitian' );
}

sub SET_ROW : Tests {
 my $m = Math::GSL::Matrix->new(3,3);
 $m->set_row(0, [1,2,3]);
 ok_similar([$m->row(0)->as_list], [1,2,3]);
}
sub SET_ROW_CHAINED : Tests {
 my $m = Math::GSL::Matrix->new(3,3);
 $m->set_row(1, [4,5,6])
   ->set_row(2, [9,8,7]);
 ok_similar([$m->row(1)->as_list], [4,5,6]);
 ok_similar([$m->row(2)->as_list], [9,8,7]);
}

sub SET_COL_CHAINED : Tests {
 my $m = Math::GSL::Matrix->new(3,3);
 $m->set_col(1, [4,5,6])
   ->set_col(2, [9,8,7]);
 ok_similar([$m->col(1)->as_list], [4,5,6]);
 ok_similar([$m->col(2)->as_list], [9,8,7]);
}

sub GSL_MATRIX_VIEW_ARRAY : Tests {
 my $array = [8,4,3,7];
 my $matrix_view = gsl_matrix_view_array ($array, 2,2);
 ok_similar([map { gsl_matrix_get($matrix_view->{matrix}, 0, $_) } 0..1], [8, 4]);
 ok_similar([map { gsl_matrix_get($matrix_view->{matrix}, 1, $_) } 0..1], [3, 7]);
}

sub GSL_MATRIX_VIEW_ARRAY_WITH_TDA : Tests {
 my $array = [8,4,3,7,5];
 my $matrix_view = gsl_matrix_view_array_with_tda ($array, 2,2, 3);
 ok_similar([map { gsl_matrix_get($matrix_view->{matrix}, 0, $_) } 0..1], [8, 4]);
 ok_similar([map { gsl_matrix_get($matrix_view->{matrix}, 1, $_) } 0..1], [7, 5]);
}
1;
