package Math::GSL::Matrix::Test;
use base q{Test::Class};
use Test::More tests => 237;
use strict;
use warnings;

use Math::GSL           qw/:all/;
use Math::GSL::Test     qw/:all/;
use Math::GSL::Matrix   qw/:all/;
use Math::GSL::Vector   qw/:all/;
use Math::GSL::Complex  qw/:all/;
use Math::GSL::Errno    qw/:all/;
use Test::Exception;
use Math::Complex;
use Data::Dumper;

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

   my $fh = gsl_fopen("matrix", 'w');
   is( gsl_matrix_fprintf($fh, $self->{matrix}, "%f"), 0);
   ok_status(gsl_fclose($fh));

   for my $line (0..4) {
        map { gsl_matrix_set($self->{matrix}, $line, $_, $_**3) } (0..4);
   }

   $fh = gsl_fopen("matrix", 'r');
   is(gsl_matrix_fscanf($fh, $self->{matrix}), 0);
   for my $line (0..4) {
        ok_similar(
                    [ map { gsl_matrix_get($self->{matrix}, $line, $_) } (0..4) ],
                    [ map { $_**2 } (0..4) ],
                  );
   }
   ok_status(gsl_fclose($fh));
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

sub GSL_MATRIX_OO_ADDITION_CONSTANT : Tests {
    my $m = Math::GSL::Matrix->new(3,3);
    $m->set_col(1, [4,5,6])
      ->set_col(2, [9,8,7]);
    my $m2 = $m + 4;
    ok_similar([$m->col(2)->as_list], [9,8,7]);
    ok_similar([$m->col(1)->as_list], [4,5,6]);
    ok_similar([$m->col(0)->as_list], [0,0,0]);

    ok_similar([$m2->col(1)->as_list], [8,9,10]);
    ok_similar([$m2->col(2)->as_list], [13,12,11]);
    ok_similar([$m2->col(0)->as_list], [4,4,4]);
    
    my $m3 = 4 + $m; 
    ok_similar([$m3->col(1)->as_list], [8,9,10]);
    ok_similar([$m3->col(2)->as_list], [13,12,11]);
    ok_similar([$m3->col(0)->as_list], [4,4,4]);
}

sub GSL_MATRIX_OO_ADDITION_MATRICES : Tests {
    my $m = Math::GSL::Matrix->new(3,3);
    $m->set_col(1, [4,5,6])
      ->set_col(2, [9,8,7])
      ->set_col(0, [1,2,3]);
    my $m2 = $m + $m;
    ok_similar([$m->col(0)->as_list], [1,2,3]);
    ok_similar([$m->col(2)->as_list], [9,8,7]);
    ok_similar([$m->col(1)->as_list], [4,5,6]);

    ok_similar([$m2->col(0)->as_list], [2,4,6]);
    ok_similar([$m2->col(1)->as_list], [8,10,12]);
    ok_similar([$m2->col(2)->as_list], [18,16,14]);
}

sub GSL_MATRIX_OO_SUBSTRACTION_CONSTANT : Tests {
    my $m = Math::GSL::Matrix->new(3,3);
    $m->set_col(1, [4,5,6])
      ->set_col(2, [9,8,7]);
    my $m2 = $m - 4;
    ok_similar([$m->col(2)->as_list], [9,8,7]);
    ok_similar([$m->col(1)->as_list], [4,5,6]);
    ok_similar([$m->col(0)->as_list], [0,0,0]);

    ok_similar([$m2->col(1)->as_list], [0,1,2]);
    ok_similar([$m2->col(2)->as_list], [5,4,3]);
    ok_similar([$m2->col(0)->as_list], [-4,-4,-4]);
}

sub GSL_MATRIX_OO_SUBSTRACTION_MATRICES : Tests {
    my $m = Math::GSL::Matrix->new(3,3);
    my $m3 = Math::GSL::Matrix->new(3,3);
    $m->set_col(1, [4,5,6])
      ->set_col(2, [9,8,7])
      ->set_col(0, [1,2,3]);
    $m3->set_col(1, [1,2,3])
       ->set_col(2, [9,8,7])
       ->set_col(0, [1,2,3]);
    my $m2 = $m - $m3;
    ok_similar([$m->col(0)->as_list], [1,2,3]);
    ok_similar([$m->col(2)->as_list], [9,8,7]);
    ok_similar([$m->col(1)->as_list], [4,5,6]);

    ok_similar([$m2->col(0)->as_list], [0,0,0]);
    ok_similar([$m2->col(1)->as_list], [3,3,3]);
    ok_similar([$m2->col(2)->as_list], [0,0,0]);
}

sub GSL_MATRIX_OO_MULTIPLICATION_CONSTANT : Tests {
    my $m = Math::GSL::Matrix->new(3,3);
    $m->set_col(1, [4,5,6])
      ->set_col(2, [9,8,7]);
    my $m2 = $m * 4;
    ok_similar([$m->col(2)->as_list], [9,8,7]);
    ok_similar([$m->col(1)->as_list], [4,5,6]);
    ok_similar([$m->col(0)->as_list], [0,0,0]);

    ok_similar([$m2->col(1)->as_list], [16,20,24]);
    ok_similar([$m2->col(2)->as_list], [36,32,28]);
    ok_similar([$m2->col(0)->as_list], [0,0,0]);

    my $m3 = 4 * $m;
    ok_similar([$m3->col(1)->as_list], [16,20,24]);
    ok_similar([$m3->col(2)->as_list], [36,32,28]);
    ok_similar([$m3->col(0)->as_list], [0,0,0]);
}

sub GSL_MATRIX_EIGENVALUES: Tests(6) {
    my $matrix = Math::GSL::Matrix->new(2,2)
                              ->set_row(0, [0,-1] )
                              ->set_row(1, [1, 0] );
    my @eigs = $matrix->eigenvalues;
    ok_similar( [ Re($eigs[0]), Im($eigs[0]) ], [ 0,  1 ] ); #  i
    ok_similar( [ Re($eigs[1]), Im($eigs[1]) ], [ 0, -1 ] ); # -i

    my $rect = Math::GSL::Matrix->new(2,4);
    dies_ok( sub { $rect->eigenvalues }, 'eigenvalues for square matrices only' );

    my $matrix2 = Math::GSL::Matrix->new(2,2)
                              ->set_row(0, [1, 0] )
                              ->set_row(1, [0, 1] );
    my @eigs2 = $matrix2->eigenvalues;
    ok_similar( [ @eigs2 ], [ 1, 1 ] );

    my $matrix3 = Math::GSL::Matrix->new(2,2);
    ok_similar( [ $matrix3->eigenvalues ], [ 0, 0 ], 'zero matrix eigenvalues = 0');

    my $matrix4 = Math::GSL::Matrix->new(2,2)
                              ->set_row(0, [1, 3] )
                              ->set_row(1, [4, 2] );
    ok_similar( [ $matrix4->eigenvalues ], [ -2, 5 ] );
}

sub GSL_MATRIX_EIGENPAIR : Tests(11) {
    my $matrix = Math::GSL::Matrix->new(2,2)
                              ->set_row(0, [0,-1] )
                              ->set_row(1, [1, 0] );

    my ($eigenvalues, $eigenvectors) = $matrix->eigenpair;
    cmp_ok( $#$eigenvalues, '==', $#$eigenvectors, 'same # of values as vectors');

    my ($eig1,$eig2) = @$eigenvalues;
    isa_ok( $eig1, 'Math::Complex');
    isa_ok( $eig2, 'Math::Complex');

    ok_similar( [ Re $eig1 ], [ 0 ] );
    ok_similar( [ Im $eig1 ], [ 1 ] );

    ok_similar( [ Re $eig2 ], [ 0   ] );
    ok_similar( [ Im $eig2 ], [ -1  ] );

    my ($u,$v)       = @$eigenvectors;

    isa_ok( $u, 'Math::GSL::VectorComplex' );
    isa_ok( $v, 'Math::GSL::VectorComplex' );

    local $TODO = qq{ VectorComplex->as_list is funky };
    # we happen to know that these are real eigenvectors
    my ($u1,$u2)     = map { Re $_ } $u->as_list;
    my ($v1,$v2)     = map { Re $_ } $v->as_list;
    my $sqrt2by2     = sqrt(2)/2;

    ok_similar( [ $u1, $u2 ], [ $sqrt2by2, - $sqrt2by2 ] );
    ok_similar( [ $v1, $v2 ], [ $sqrt2by2,   $sqrt2by2 ] );

}

sub MATRIX_MULTIPLICATION_OVERLOAD : Tests {
    my $A = Math::GSL::Matrix->new(2,2)
                             ->set_row(0, [1,3] )
                             ->set_row(1, [4, 2] );
    my $B = Math::GSL::Matrix->new(2,2)
                             ->set_row(0, [2,5] )
                             ->set_row(1, [1, 3] );
    my $C = $A * $B;
    ok_similar([ $C->as_list ], [5, 14, 10, 26 ]);
}

sub MATRIX_IS_SQUARE : Tests(2) {
    my $A = Math::GSL::Matrix->new(2,2);
    ok( $A->is_square, 'is_square true for 2x2' );
    my $B = Math::GSL::Matrix->new(2,3);
    ok( ! $B->is_square, 'is_square false for 2x3' );
}

sub MATRIX_DETERMINANT : Tests(2) {
    my $A = Math::GSL::Matrix->new(2,2)
                             ->set_row(0, [1,3] )
                             ->set_row(1, [4, 2] );

    ok_similar( [ $A->det   ], [ -10 ], '->det() 2x2');
    ok_similar( [ $A->lndet ], [ log 10 ], '->lndet() 2x2');

}

sub MATRIX_ZERO : Tests(2) {
    my $A = Math::GSL::Matrix->new(2,2)
                             ->set_row(0, [1, 3] )
                             ->set_row(1, [4, 2] );
    isa_ok($A->zero, 'Math::GSL::Matrix');
    ok_similar( [ $A->zero->as_list ], [ 0, 0, 0, 0 ] );
}

sub MATRIX_IDENTITY : Tests(6) {
    my $A = Math::GSL::Matrix->new(2,2)->identity;
    isa_ok($A, 'Math::GSL::Matrix');
    ok_similar([ $A->as_list ], [ 1, 0, 0, 1 ] );
    ok_similar([ $A->inverse->as_list ], [ 1, 0, 0, 1 ] );
    ok_similar([ $A->det     ] ,[ 1 ] );
    ok_similar([ map { Re $_ } $A->eigenvalues ], [ 1, 1 ], 'identity eigs=1' );
    ok_similar([ map { Im $_ } $A->eigenvalues ], [ 0, 0 ], 'identity eigs=1' );
}

sub MATRIX_INVERSE : Tests(3) {
    my $A = Math::GSL::Matrix->new(2,2)
                             ->set_row(0, [1, 3] )
                             ->set_row(1, [4, 2] );
    my $Ainv = $A->inverse;
    isa_ok( $Ainv, 'Math::GSL::Matrix' );
    ok_similar([ $Ainv->as_list ] , [ map { -$_/10 } ( 2, -3, -4, 1 ) ] );
    my $B = Math::GSL::Matrix->new(2,3)
                             ->set_row(0, [1, 3, 5] )
                             ->set_row(1, [2, 4, 6] );
    dies_ok( sub { $B->inverse } , 'inverse of non square matrix dies' );
}

sub OVERLOAD_EQUAL : Tests(2) {
    my $A = Math::GSL::Matrix->new(2,2)
                             ->set_row(0, [1, 3] )
                             ->set_row(1, [4, 2] );
    my $B = $A->copy;
    ok ( $A == $B, 'should be equal');
    $B->set_row(0, [1,2]);
    ok ( $A != $B, 'should not be equal');
}

Test::Class->runtests;
