package Ver2Func;

use strict;
use warnings;

use Carp;
use File::Spec::Functions qw/:ALL/;

# THESE MUST BE IN ORDER
my @ver2func = (

    "1.15" => {
        subsystems => [
            qw/
              Diff         Machine      Statistics    BLAS
              Eigen        Matrix       Poly          MatrixComplex
              BSpline      Errno        PowInt        VectorComplex
              CBLAS        FFT          Min           IEEEUtils
              CDF          Fit          QRNG
              Chebyshev    Monte        RNG           Vector
              Heapsort     Randist      Roots
              Combination  Histogram    Multimin      Wavelet
              Complex      Histogram2D  Multiroots    Wavelet2D
              Const        Siman        Sum           Sys
              NTuple       Integration  Sort          Test
              DHT          Interp       ODEIV         SF
              Deriv        Linalg       Permutation   Spline
              Version      Multiset
              /
        ],
    },

    "1.16" => {
        new => [
            qw/
              ^gsl_stats_spearman$
              ^gsl_sort_vector2$
              ^gsl_poly_dd_hermite_init$
              ^gsl_linalg_SV_leverage$
              ^gsl_bspline_knots_greville$
              ^gsl_linalg_SV_leverage$
              ^gsl_sort2.*$
              ^gsl_sort_vector2_.*$
              ^gsl_stats_[a-z]+_spearman$
              /
        ]
    },

    "2.0" => {
        deprecated => [
            qw/
              ^gsl_bspline_deriv_alloc$
              ^gsl_bspline_deriv_free$
              /
        ],
        new => [
            qw/
              ^gsl_sf_legendre_nlm$
              ^gsl_sf_legendre_deriv.*
              ^gsl_sf_legendre_array.*
              ^gsl_multifit_robust.*$
              ^gsl_multifit_fsolver_driver$
              ^gsl_multifit_function_fdf$
              ^gsl_multifit_fdfsolver_.*
              ^gsl_multifit_fdfridge.*
              ^gsl_multifit_fdfsolver_driver$
              ^gsl_multifit_linear_svd$
              ^gsl_bspline_eval_nonzero$
              ^gsl_bspline_deriv.*
              ^gsl_bspline_workspace.*
              ^gsl_multifit_linear_solve$
              ^gsl_multifit_fdfsolver_residual$
              ^gsl_multifit_fdfsolver_jac$
              ^gsl_multifit_fdfsolver_niter$
              ^gsl_multifit_fdfsolver_test$
              ^gsl_multifit_fdfsolver_wset$
              ^gsl_multifit_eval_wf$
              ^gsl_multifit_eval_wdf$
              ^gsl_multifit_linear_stdform2$
              ^gsl_multifit_linear_wstdform2$
              ^gsl_multifit_linear_genform2$
              ^gsl_multifit_linear_wgenform2$
              ^gsl_multifit_linear_stdform1$
              ^gsl_multifit_linear_wstdform1$
              ^gsl_multifit_linear_genform1$
              ^gsl_multifit_linear_wgenform1$
              ^gsl_multifit_linear_bsvd$
              ^gsl_multifit_linear_lreg$
              ^gsl_multifit_linear_lcurve$
              ^gsl_multifit_linear_lcorner$
              ^gsl_multifit_linear_lcorner2$
              ^gsl_multifit_linear_Lk$
              ^gsl_multifit_linear_Lsobolev$
              ^gsl_multifit_linear_applyW$
              ^gsl_multifit_robust_maxiter$
              ^gsl_multifit_robust_residuals$
              ^gsl_multifit_robust_weights$
              ^gsl_multifit_covar_QRPT$
              ^gsl_multifit_linear_workspace.*
              ^gsl_linalg_givens$
              ^gsl_linalg_givens_gv$
              ^gsl_linalg_QR_matQ$
              /
        ],
        subsystems => [qw/ Rstat SparseMatrix /],
    },

    "2.1" => {
        new => [
            qw/
              ^gsl_multifit_linear_rcond$
              ^gsl_multifit_linear_L_decomp$
              /
        ],
        subsystems => [qw/ Multilarge Multifit /],
    },

    "2.2" => {
        new => [
            qw/
              ^gsl_rstat_rms$
              ^gsl_rstat_quantile_reset$
              ^gsl_matrix_tricpy$
              ^gsl_matrix_complex_tricpy$
              ^gsl_matrix_char_tricpy$
              ^gsl_matrix_int_tricpy$
              ^gsl_matrix_int_transpose_tricpy$
              ^gsl_matrix_complex_transpose_tricpy$
              ^gsl_matrix_char_transpose_tricpy$
              ^gsl_matrix_transpose_tricpy$
              ^gsl_ran_multivariate_gaussian_mean$
              ^gsl_ran_multivariate_gaussian_vcov$
              ^gsl_ran_multivariate_gaussian_pdf$
              ^gsl_ran_multivariate_gaussian_log_pdf$
              ^gsl_ran_multivariate_gaussian$
              ^gsl_linalg_COD.*$
              ^gsl_linalg_cholesky_rcond$
              ^gsl_linalg_cholesky_scale$
              ^gsl_linalg_cholesky_scale_apply$
              ^gsl_linalg_cholesky_decomp2$
              ^gsl_linalg_cholesky_svx2$
              ^gsl_linalg_cholesky_solve2$
              ^gsl_linalg_pcholesky_decomp$
              ^gsl_linalg_pcholesky_solve$
              ^gsl_linalg_pcholesky_svx$
              ^gsl_linalg_pcholesky_decomp2$
              ^gsl_linalg_pcholesky_solve2$
              ^gsl_linalg_pcholesky_svx2$
              ^gsl_linalg_pcholesky_rcond$
              ^gsl_linalg_pcholesky_invert$
              ^gsl_linalg_mcholesky_decomp$
              ^gsl_linalg_mcholesky_solve$
              ^gsl_linalg_mcholesky_svx$
              ^gsl_linalg_mcholesky_rcond$
              ^gsl_linalg_mcholesky_invert$
              ^gsl_linalg_invnorm1$
              ^gsl_linalg_QRPT_rank$
              ^gsl_linalg_QRPT_rcond$
              ^gsl_linalg_QRPT_lssolve$
              ^gsl_linalg_QRPT_lssolve2$
              ^gsl_linalg_tri_lower_invert$
              ^gsl_linalg_tri_lower_rcond$
              ^gsl_linalg_tri_lower_unit_invert$
              ^gsl_linalg_tri_upper_invert$
              ^gsl_linalg_tri_upper_rcond$
              ^gsl_linalg_tri_upper_unit_invert$
              ^gsl_multilarge_linear_lcurve$
              ^gsl_permute_matrix$
              ^gsl_spmatrix_ccs$
              ^gsl_spmatrix_crs$
              ^gsl_spmatrix_fprintf$
              ^gsl_spmatrix_fread$
              ^gsl_spmatrix_fscanf$
              ^gsl_spmatrix_fwrite$
              ^gsl_spmatrix_ptr$
              ^gsl_spmatrix_ptr$
              ^gsl_spmatrix_transpose$
              ^gsl_spmatrix_transpose2$
              ^gsl_spmatrix_tree_rebuild$
              /
        ]
    },
    "2.2.1" => {
        new => [
            qw/
              ^gsl_linalg_cholesky_decomp1$
              /
        ]
    },
    "2.3" => {
        new => [
            qw/
              ^gsl_multifit_linear_tsvd$
              ^gsl_multifit_linear_rank$
              ^gsl_multifit_wlinear_tsvd$
              ^gsl_multifit_linear_gcv_init$
              ^gsl_multifit_linear_gcv_curve$
              ^gsl_multifit_linear_gcv_min$
              ^gsl_multifit_linear_gcv_calc$
              ^gsl_multifit_linear_gcv$
              /
        ]
    },
    "2.4" => {
        deprecated => [
            qw/
              ^gsl_sf_coupling_6j_INCORRECT$
              ^gsl_sf_coupling_6j_INCORRECT_e$
              /
        ],
        new => [
            qw/
              ^gsl_integration_fixed
              ^gsl_linalg_COD_lssolve2$
              ^gsl_sf_hermite_prob_e$
              ^gsl_sf_hermite_prob$
              ^gsl_sf_hermite_prob_der_e$
              ^gsl_sf_hermite_prob_der$
              ^gsl_sf_hermite_phys_e$
              ^gsl_sf_hermite_phys$
              ^gsl_sf_hermite_phys_der_e$
              ^gsl_sf_hermite_phys_der$
              ^gsl_sf_hermite_func_e$
              ^gsl_sf_hermite_func$
              ^gsl_sf_hermite_prob_array$
              ^gsl_sf_hermite_prob_array_der$
              ^gsl_sf_hermite_prob_der_array$
              ^gsl_sf_hermite_prob_series_e$
              ^gsl_sf_hermite_prob_series$
              ^gsl_sf_hermite_phys_array$
              ^gsl_sf_hermite_phys_array_der$
              ^gsl_sf_hermite_phys_der_array$
              ^gsl_sf_hermite_phys_series_e$
              ^gsl_sf_hermite_phys_series$
              ^gsl_sf_hermite_func_array$
              ^gsl_sf_hermite_func_series_e$
              ^gsl_sf_hermite_func_series$
              ^gsl_sf_hermite_func_der_e$
              ^gsl_sf_hermite_func_der$
              ^gsl_sf_hermite_prob_zero_e$
              ^gsl_sf_hermite_prob_zero$
              ^gsl_sf_hermite_phys_zero_e$
              ^gsl_sf_hermite_phys_zero$
              ^gsl_sf_hermite_func_zero_e$
              ^gsl_sf_hermite_func_zero$
              /
        ],
    },

    "2.5" => {
        new => [
            qw/
	      ^gsl_stats_Qn0_from_sorted_data$
	      ^gsl_stats_Qn_from_sorted_data$
	      ^gsl_stats_Sn0_from_sorted_data$
	      ^gsl_stats_Sn_from_sorted_data$
	      ^gsl_stats_char_Qn0_from_sorted_data$
	      ^gsl_stats_char_Qn_from_sorted_data$
	      ^gsl_stats_char_Sn0_from_sorted_data$
	      ^gsl_stats_char_Sn_from_sorted_data$
	      ^gsl_stats_char_gastwirth_from_sorted_data$
	      ^gsl_stats_char_mad$
	      ^gsl_stats_char_mad0$
	      ^gsl_stats_char_median$
	      ^gsl_stats_char_trmean_from_sorted_data$
	      ^gsl_stats_int_Qn0_from_sorted_data$
	      ^gsl_stats_int_Qn_from_sorted_data$
	      ^gsl_stats_int_Sn0_from_sorted_data$
	      ^gsl_stats_int_Sn_from_sorted_data$
	      ^gsl_stats_int_gastwirth_from_sorted_data$
	      ^gsl_stats_int_mad$
	      ^gsl_stats_int_mad0$
	      ^gsl_stats_int_median$
	      ^gsl_stats_int_select$
	      ^gsl_stats_int_trmean_from_sorted_data$
              ^gsl_int_Qn_from_sorted_data$
              ^gsl_int_Sn_from_sorted_data$
              ^gsl_integration_romberg
              ^gsl_linalg_cholesky_solve_mat$
              ^gsl_linalg_cholesky_svx_mat$
              ^gsl_ran_wishart$
              ^gsl_ran_wishart_log_pdf$
              ^gsl_ran_wishart_pdf$
              ^gsl_spmatrix_work_sze
              ^gsl_stats_char_select$
              ^gsl_stats_gastwirth_from_sorted_data$
              ^gsl_stats_int_Sn_from_sorted_data$
              ^gsl_stats_mad$
              ^gsl_stats_mad0$
              ^gsl_stats_median$
              ^gsl_stats_select$
              ^gsl_stats_trmean_from_sorted_data$
              /,
            [ '$ignore', '%$isvariable', '%$ismember', 'work_dbl' ],
            [ '$ignore', '%$isvariable', '%$ismember', 'work_sze' ],
        ],
    },
    "2.6" => {
        new => [
            qw/
	      ^gsl_spmatrix_pool_node$
	      ^gsl_spmatrix_pool$
              ^gsl_vector_complex_axpby$
              ^gsl_vector_int_axpby$
              ^gsl_vector_ushort_axpby$
              ^gsl_vector_char_axpby$
              ^gsl_vector_long_axpby$
              ^gsl_vector_complex_float_axpby$
              ^gsl_vector_float_axpby$
              ^gsl_vector_long_double_axpby$
              ^gsl_vector_short_axpby$
              ^gsl_vector_uint_axpby$
              ^gsl_vector_ulong_axpby$
              ^gsl_vector_uchar_axpby$
              ^gsl_vector_complex_long_double_axpby$
              ^gsl_vector_axpby$
              ^gsl_vector_sum$
              ^gsl_vector_int_sum$
              ^gsl_vector_ushort_sum$
              ^gsl_vector_char_sum$
              ^gsl_vector_long_sum$
              ^gsl_vector_float_sum$
              ^gsl_vector_long_double_sum$
              ^gsl_vector_short_sum$
              ^gsl_vector_uint_sum$
              ^gsl_vector_ulong_sum$
              ^gsl_vector_uchar_sum$
              ^gsl_linalg_ldlt_band_solve$
              ^gsl_linalg_LQ_QTvec$
              ^gsl_linalg_QR_QTvec_r$
              ^gsl_linalg_cholesky_band_decomp$
              ^gsl_linalg_ldlt_band_decomp$
              ^gsl_linalg_ldlt_decomp$
              ^gsl_linalg_QL_decomp$
              ^gsl_linalg_QR_decomp_r$
              ^gsl_linalg_QR_TR_decomp$
              ^gsl_linalg_QR_QTmat_r$
              ^gsl_linalg_QR_rcond$
              ^gsl_linalg_cholesky_band_rcond$
              ^gsl_linalg_ldlt_rcond$
              ^gsl_linalg_ldlt_band_rcond$
              ^gsl_linalg_tri_rcond$
              ^gsl_linalg_cholesky_band_solve$
              ^gsl_linalg_ldlt_band_solve$
              ^gsl_linalg_ldlt_solve$
              ^gsl_linalg_LQ_lssolve$
              ^gsl_linalg_QR_lssolve_r$
              ^gsl_linalg_QR_solve_r$
              ^gsl_linalg_complex_tri_invert$
              ^gsl_linalg_complex_tri_LHL$
              ^gsl_linalg_complex_tri_UL$
              ^gsl_linalg_tri_invert$
              ^gsl_linalg_tri_LTL$
              ^gsl_linalg_tri_rcond$
              ^gsl_linalg_tri_UL$
              ^gsl_linalg_complex_householder_left$
              ^gsl_linalg_householder_left$
              ^gsl_linalg_householder_right$
              ^gsl_linalg_householder_transform2$
              ^gsl_linalg_cholesky_band_svx$
              ^gsl_linalg_cholesky_band_invert$
              ^gsl_linalg_cholesky_band_unpack$
              ^gsl_linalg_ldlt_band_svx$
              ^gsl_linalg_ldlt_band_unpack$
              ^gsl_linalg_LU_invx$
              ^gsl_linalg_complex_LU_invx$
              ^gsl_linalg_ldlt_svx$
              ^gsl_linalg_QL_unpack$
              ^gsl_linalg_QR_unpack_r$
              ^gsl_matrix_long_double_scale_rows$
              ^gsl_matrix_ulong_scale_rows$
              ^gsl_matrix_float_scale_rows$
              ^gsl_matrix_int_scale_columns$
              ^gsl_matrix_char_scale_columns$
              ^gsl_matrix_long_double_scale_columns$
              ^gsl_matrix_complex_long_double_scale_columns$
              ^gsl_matrix_short_scale_rows$
              ^gsl_matrix_ushort_scale_rows$
              ^gsl_matrix_ushort_scale_columns$
              ^gsl_matrix_ulong_scale_columns$
              ^gsl_matrix_uchar_scale_rows$
              ^gsl_matrix_complex_float_scale_rows$
              ^gsl_matrix_complex_scale_columns$
              ^gsl_matrix_complex_long_double_scale_rows$
              ^gsl_matrix_scale_columns$
              ^gsl_matrix_uint_scale_rows$
              ^gsl_matrix_complex_float_scale_columns$
              ^gsl_matrix_scale_rows$
              ^gsl_matrix_long_scale_rows$
              ^gsl_matrix_short_scale_columns$
              ^gsl_matrix_long_scale_columns$
              ^gsl_matrix_char_scale_rows$
              ^gsl_matrix_int_scale_rows$
              ^gsl_matrix_uchar_scale_columns$
              ^gsl_matrix_complex_scale_rows$
              ^gsl_matrix_float_scale_columns$
              ^gsl_matrix_uint_scale_columns$
              /
            ]
    },
    "2.7" => {
        new => [
            qw/
              ^gsl_vector_sum$
              ^gsl_vector_char_sum$
              ^gsl_vector_uchar_sum$
              ^gsl_vector_int_sum$
              ^gsl_vector_uint_sum$
              ^gsl_vector_ushort_sum$
              ^gsl_vector_long_sum$
              ^gsl_vector_ulong_sum$
              ^gsl_vector_long_double_sum$
              ^gsl_vector_float_sum$
              ^gsl_matrix_norm1$
              ^gsl_matrix_int_norm1$
              ^gsl_matrix_uchar_norm1$
              ^gsl_matrix_ushort_norm1$
              ^gsl_matrix_ulong_norm1$
              ^gsl_matrix_char_norm1$
              ^gsl_matrix_float_norm1$
              ^gsl_matrix_short_norm1$
              ^gsl_matrix_long_double_norm1$
              ^gsl_matrix_long_norm1$
              ^gsl_matrix_uint_norm1$
              ^gsl_matrix_scale_rows$
              ^gsl_matrix_complex_float_scale_rows$
              ^gsl_matrix_complex_scale_rows$
              ^gsl_matrix_uchar_scale_rows$
              ^gsl_matrix_ushort_scale_rows$
              ^gsl_matrix_ulong_scale_rows$
              ^gsl_matrix_char_scale_rows$
              ^gsl_matrix_float_scale_rows$
              ^gsl_matrix_short_scale_rows$
              ^gsl_matrix_complex_long_double_scale_rows$
              ^gsl_matrix_long_double_scale_rows$
              ^gsl_matrix_uint_scale_rows$
              ^gsl_matrix_int_scale_rows$
              ^gsl_matrix_scale_columns$
              ^gsl_matrix_complex_scale_columns$
              ^gsl_matrix_uchar_scale_columns$
              ^gsl_matrix_ushort_scale_columns$
              ^gsl_matrix_ulong_scale_columns$
              ^gsl_matrix_char_scale_columns$
              ^gsl_matrix_float_scale_columns$
              ^gsl_matrix_short_scale_columns$
              ^gsl_matrix_complex_long_double_scale_columns$
              ^gsl_matrix_long_double_scale_columns$
              ^gsl_matrix_uint_scale_columns$
              ^gsl_matrix_int_scale_columns$
              ^gsl_matrix_complex_conjtrans_memcpy$
              ^gsl_multifit_linear_lcurvature$
              ^gsl_spmatrix_dense_add$
              ^gsl_spmatrix_uint_dense_add$
              ^gsl_spmatrix_int_dense_add$
              ^gsl_spmatrix_long_double_dense_add$
              ^gsl_spmatrix_float_dense_add$
              ^gsl_spmatrix_long_dense_add$
              ^gsl_spmatrix_complex_float_dense_add$
              ^gsl_spmatrix_char_dense_add$
              ^gsl_spmatrix_uchar_dense_add$
              ^gsl_spmatrix_ulong_dense_add$
              ^gsl_spmatrix_short_dense_add$
              ^gsl_spmatrix_ushort_dense_add$
              ^gsl_spmatrix_long_double_dense_add$
              ^gsl_spmatrix_complex_dense_add$
              ^gsl_spmatrix_complex_long_double_dense_add$
              ^gsl_spmatrix_dense_sub$
              ^gsl_spmatrix_uint_dense_sub$
              ^gsl_spmatrix_int_dense_sub$
              ^gsl_spmatrix_long_double_dense_sub$
              ^gsl_spmatrix_float_dense_sub$
              ^gsl_spmatrix_long_dense_sub$
              ^gsl_spmatrix_complex_float_dense_sub$
              ^gsl_spmatrix_char_dense_sub$
              ^gsl_spmatrix_uchar_dense_sub$
              ^gsl_spmatrix_ulong_dense_sub$
              ^gsl_spmatrix_short_dense_sub$
              ^gsl_spmatrix_ushort_dense_sub$
              ^gsl_spmatrix_long_double_dense_sub$
              ^gsl_spmatrix_complex_long_double_dense_sub$
              ^gsl_spmatrix_complex_dense_sub$
              ^gsl_spmatrix_norm1
              ^gsl_spmatrix_int_norm1$
              ^gsl_spmatrix_float_norm1$
              ^gsl_spmatrix_long_norm1$
              ^gsl_spmatrix_char_norm1$
              ^gsl_spmatrix_ulong_norm1$
              ^gsl_spmatrix_short_norm1$
              ^gsl_spmatrix_ushort_norm1$
              ^gsl_spmatrix_long_double_norm1$
              ^gsl_spmatrix_uint_norm1$
              ^gsl_spmatrix_uchar_norm1$
              ^gsl_linalg_complex_QR_solve_r$
              ^gsl_linalg_complex_QR_solve$
              ^gsl_linalg_complex_QR_svx$
              ^gsl_linalg_complex_QR_decomp$
              ^gsl_linalg_complex_QR_decomp_r$
              ^gsl_linalg_complex_QR_lssolve$
              ^gsl_linalg_complex_QR_lssolve_r$
              ^gsl_linalg_complex_QR_QHvec$
              ^gsl_linalg_complex_QR_QHvec_r$
              ^gsl_linalg_complex_QR_Qvec$
              ^gsl_linalg_complex_QR_unpack$
              ^gsl_linalg_complex_QR_unpack_r$
              ^gsl_linalg_cholesky_band_solvem$
              ^gsl_linalg_cholesky_band_scale_apply$
              ^gsl_linalg_cholesky_band_svxm$
              ^gsl_linalg_cholesky_band_scale$
              ^gsl_linalg_QR_UU_QTvec$
              ^gsl_linalg_QR_UU_decomp$
              ^gsl_linalg_QR_UU_lssolve$
              ^gsl_linalg_QR_UZ_decomp$
              ^gsl_linalg_QR_UD_lssolve$
              ^gsl_linalg_QR_UD_decomp$
              ^gsl_linalg_QR_UR_decomp$
              ^gsl_linalg_QR_decomp_old$
              ^gsl_linalg_QR_band_decomp_L2$
              ^gsl_linalg_QR_band_unpack_L2$
              ^gsl_linalg_QL_decomp$
              ^gsl_linalg_QL_unpack$
              ^gsl_linalg_LU_band_unpack$
              ^gsl_linalg_LU_band_svx$
              ^gsl_linalg_LU_band_decomp$
              ^gsl_linalg_LU_band_solve$
              ^gsl_linalg_householder_transform2$

              /
        ]
    }

);

my ( %index, @info, @versions );

{
    my $idx = 0;

    while ( @ver2func ) {
        my ( $version, $info ) = splice( @ver2func, 0, 2 );
        $info->{$_} ||= [] for qw[ deprecated new subsystems ];
        $index{$version} = $idx++;
        push @versions, $version;
        push @info,     $info;
    }

}

sub new {
    my ( $class, $version ) = @_;

    $version = '1.16' if $version eq '1.16.1';

    defined( my $vers_idx = $index{$version} )
      or croak( "Unsupported GSL version!!! : $version" );

    my ( @ignore, @subsystems );

    my $idx;

    # ignore deprecated symbols in previous and current versions
    for ( $idx = 0 ; $idx <= $vers_idx ; ++$idx ) {
        push @ignore,     @{ $info[$idx]{deprecated} };
        push @subsystems, @{ $info[$idx]{subsystems} };
    }

    # ignore added symbols in future versions
    for ( ; $idx < @info ; ++$idx ) {
        push @ignore,     @{ $info[$idx]{new} };
    }

    return bless {
        ignore     => \@ignore,
        subsystems => [ grep { !/^Test$/ } @subsystems ],
    };
}

sub versions {

    ( undef, my $cur_ver ) = @_;

    return @versions unless defined $cur_ver;

    defined( my $idx = $index{$cur_ver} )
      or croak( "unsupported version: $cur_ver" );

    return @versions[ 0 .. $idx ];
}

{
    my %C_modules;
    @C_modules{qw[ Matrix Randist ]} = ();

    sub is_c_module {
        my ( $self, $module ) = @_;
        return exists $C_modules{$module};
    }

}

sub subsystems {
    return @{ $_[0]->{subsystems} };
}

sub ignore {
    return @{ $_[0]->{ignore} };
}

sub sources {
    my $self = shift;
    (
        map { [
                catfile( "swig", "$_.i" ),
                [
                    catfile( "pod", "$_.pod" ),
                    (
                        Ver2Func->is_c_module( $_ )
                        ? ( catfile( "c", "$_.c" ), catfile( "c", "$_.h" ) )
                        : (),
                    )
                ],
            ]
        } $self->subsystems
    );
}

sub swig_files {
    my $self = shift;
    return ( map { catfile( "swig", "$_.i" ) } $self->subsystems );
}

sub write_renames_i {

    my ( $self, $filename ) = @_;

    open( my $fh, '>', $filename )
      or die "Could not create $filename: $!";

    for my $ignore ( $self->ignore ) {

        my ( @args, $target );

        if ( 'ARRAY' eq ref $ignore ) {
            @args   = @$ignore;
            $target = pop @args;
        }
        else {
            @args   = ( qq["%(regex:/$ignore/\$ignore/)s"] );
            $target = q[""];
        }

	my $args = join( ', ', @args );
        print $fh qq{%rename($args) $target;} . "\n";
    }
    close( $fh ) or die "Could not close $filename: $!";
}

1;
