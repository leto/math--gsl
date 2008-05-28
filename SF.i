%module SF
%{
    #include "/usr/local/include/gsl/gsl_mode.h"
    #include "/usr/local/include/gsl/gsl_sf.h"
    #include "/usr/local/include/gsl/gsl_sf_airy.h"
    #include "/usr/local/include/gsl/gsl_sf_bessel.h"
    #include "/usr/local/include/gsl/gsl_sf_clausen.h"
    #include "/usr/local/include/gsl/gsl_sf_coulomb.h"
    #include "/usr/local/include/gsl/gsl_sf_coupling.h"
    #include "/usr/local/include/gsl/gsl_sf_dawson.h"
    #include "/usr/local/include/gsl/gsl_sf_debye.h"
    #include "/usr/local/include/gsl/gsl_sf_dilog.h"
    #include "/usr/local/include/gsl/gsl_sf_elementary.h"
    #include "/usr/local/include/gsl/gsl_sf_ellint.h"
    #include "/usr/local/include/gsl/gsl_sf_elljac.h"
    #include "/usr/local/include/gsl/gsl_sf_erf.h"
    #include "/usr/local/include/gsl/gsl_sf_exp.h"
    #include "/usr/local/include/gsl/gsl_sf_expint.h"
    #include "/usr/local/include/gsl/gsl_sf_fermi_dirac.h"
    #include "/usr/local/include/gsl/gsl_sf_gamma.h"
    #include "/usr/local/include/gsl/gsl_sf_gegenbauer.h"
    #include "/usr/local/include/gsl/gsl_sf_hyperg.h"
    #include "/usr/local/include/gsl/gsl_sf_laguerre.h"
    #include "/usr/local/include/gsl/gsl_sf_lambert.h"
    #include "/usr/local/include/gsl/gsl_sf_legendre.h"
    #include "/usr/local/include/gsl/gsl_sf_log.h"
    #include "/usr/local/include/gsl/gsl_sf_mathieu.h"
    #include "/usr/local/include/gsl/gsl_sf_pow_int.h"
    #include "/usr/local/include/gsl/gsl_sf_psi.h"
    #include "/usr/local/include/gsl/gsl_sf_result.h"
    #include "/usr/local/include/gsl/gsl_sf_synchrotron.h"
    #include "/usr/local/include/gsl/gsl_sf_transport.h"
    #include "/usr/local/include/gsl/gsl_sf_trig.h"
    #include "/usr/local/include/gsl/gsl_sf_zeta.h"
%}
//%import "/usr/local/include/gsl/gsl_types.h"

// Grab the declarations  
%include "/usr/local/include/gsl/gsl_mode.h"
%include "/usr/local/include/gsl/gsl_sf.h"
%include "/usr/local/include/gsl/gsl_sf_airy.h"
%include "/usr/local/include/gsl/gsl_sf_bessel.h"
%include "/usr/local/include/gsl/gsl_sf_clausen.h"
%include "/usr/local/include/gsl/gsl_sf_coulomb.h"
%include "/usr/local/include/gsl/gsl_sf_coupling.h"
%include "/usr/local/include/gsl/gsl_sf_dawson.h"
%include "/usr/local/include/gsl/gsl_sf_debye.h"
%include "/usr/local/include/gsl/gsl_sf_dilog.h"
%include "/usr/local/include/gsl/gsl_sf_elementary.h"
%include "/usr/local/include/gsl/gsl_sf_ellint.h"
%include "/usr/local/include/gsl/gsl_sf_elljac.h"
%include "/usr/local/include/gsl/gsl_sf_erf.h"
%include "/usr/local/include/gsl/gsl_sf_exp.h"
%include "/usr/local/include/gsl/gsl_sf_expint.h"
%include "/usr/local/include/gsl/gsl_sf_fermi_dirac.h"
%include "/usr/local/include/gsl/gsl_sf_gamma.h"
%include "/usr/local/include/gsl/gsl_sf_gegenbauer.h"
%include "/usr/local/include/gsl/gsl_sf_hyperg.h"
%include "/usr/local/include/gsl/gsl_sf_laguerre.h"
%include "/usr/local/include/gsl/gsl_sf_lambert.h"
%include "/usr/local/include/gsl/gsl_sf_legendre.h"
%include "/usr/local/include/gsl/gsl_sf_log.h"
%include "/usr/local/include/gsl/gsl_sf_mathieu.h"
%include "/usr/local/include/gsl/gsl_sf_pow_int.h"
%include "/usr/local/include/gsl/gsl_sf_psi.h"
%include "/usr/local/include/gsl/gsl_sf_result.h"
%include "/usr/local/include/gsl/gsl_sf_synchrotron.h"
%include "/usr/local/include/gsl/gsl_sf_transport.h"
%include "/usr/local/include/gsl/gsl_sf_trig.h"
%include "/usr/local/include/gsl/gsl_sf_zeta.h"

%include "typemaps.i"

%perlcode %{

@EXPORT_airy = qw/
               gsl_sf_airy_Ai_e 
               gsl_sf_airy_Ai 
               gsl_sf_airy_Bi_e 
               gsl_sf_airy_Bi 
               gsl_sf_airy_Ai_scaled_e 
               gsl_sf_airy_Ai_scaled 
               gsl_sf_airy_Bi_scaled_e 
               gsl_sf_airy_Bi_scaled 
               gsl_sf_airy_Ai_deriv_e 
               gsl_sf_airy_Ai_deriv 
               gsl_sf_airy_Bi_deriv_e 
               gsl_sf_airy_Bi_deriv 
               gsl_sf_airy_Ai_deriv_scaled_e 
               gsl_sf_airy_Ai_deriv_scaled 
               gsl_sf_airy_Bi_deriv_scaled_e 
               gsl_sf_airy_Bi_deriv_scaled 
               gsl_sf_airy_zero_Ai_e 
               gsl_sf_airy_zero_Ai 
               gsl_sf_airy_zero_Bi_e 
               gsl_sf_airy_zero_Bi 
               gsl_sf_airy_zero_Ai_deriv_e 
               gsl_sf_airy_zero_Ai_deriv 
               gsl_sf_airy_zero_Bi_deriv_e 
               gsl_sf_airy_zero_Bi_deriv 
               /;
@EXPORT_bessel =qw/
               gsl_sf_bessel_J0_e 
               gsl_sf_bessel_J0 
               gsl_sf_bessel_J1_e 
               gsl_sf_bessel_J1 
               gsl_sf_bessel_Jn_e 
               gsl_sf_bessel_Jn 
               gsl_sf_bessel_Jn_array 
               gsl_sf_bessel_Y0_e 
               gsl_sf_bessel_Y0 
               gsl_sf_bessel_Y1_e 
               gsl_sf_bessel_Y1 
               gsl_sf_bessel_Yn_e 
               gsl_sf_bessel_Yn 
               gsl_sf_bessel_Yn_array 
               gsl_sf_bessel_I0_e 
               gsl_sf_bessel_I0 
               gsl_sf_bessel_I1_e 
               gsl_sf_bessel_I1 
               gsl_sf_bessel_In_e 
               gsl_sf_bessel_In 
               gsl_sf_bessel_In_array 
               gsl_sf_bessel_I0_scaled_e 
               gsl_sf_bessel_I0_scaled 
               gsl_sf_bessel_I1_scaled_e 
               gsl_sf_bessel_I1_scaled 
               gsl_sf_bessel_In_scaled_e 
               gsl_sf_bessel_In_scaled 
               gsl_sf_bessel_In_scaled_array 
               gsl_sf_bessel_K0_e 
               gsl_sf_bessel_K0 
               gsl_sf_bessel_K1_e 
               gsl_sf_bessel_K1 
               gsl_sf_bessel_Kn_e 
               gsl_sf_bessel_Kn 
               gsl_sf_bessel_Kn_array 
               gsl_sf_bessel_K0_scaled_e 
               gsl_sf_bessel_K0_scaled 
               gsl_sf_bessel_K1_scaled_e 
               gsl_sf_bessel_K1_scaled 
               gsl_sf_bessel_Kn_scaled_e 
               gsl_sf_bessel_Kn_scaled 
               gsl_sf_bessel_Kn_scaled_array 
               gsl_sf_bessel_j0_e 
               gsl_sf_bessel_j0 
               gsl_sf_bessel_j1_e 
               gsl_sf_bessel_j1 
               gsl_sf_bessel_j2_e 
               gsl_sf_bessel_j2 
               gsl_sf_bessel_jl_e 
               gsl_sf_bessel_jl 
               gsl_sf_bessel_jl_array 
               gsl_sf_bessel_jl_steed_array 
               gsl_sf_bessel_y0_e 
               gsl_sf_bessel_y0 
               gsl_sf_bessel_y1_e 
               gsl_sf_bessel_y1 
               gsl_sf_bessel_y2_e 
               gsl_sf_bessel_y2 
               gsl_sf_bessel_yl_e 
               gsl_sf_bessel_yl 
               gsl_sf_bessel_yl_array 
               gsl_sf_bessel_i0_scaled_e 
               gsl_sf_bessel_i0_scaled 
               gsl_sf_bessel_i1_scaled_e 
               gsl_sf_bessel_i1_scaled 
               gsl_sf_bessel_i2_scaled_e 
               gsl_sf_bessel_i2_scaled 
               gsl_sf_bessel_il_scaled_e 
               gsl_sf_bessel_il_scaled 
               gsl_sf_bessel_il_scaled_array 
               gsl_sf_bessel_k0_scaled_e 
               gsl_sf_bessel_k0_scaled 
               gsl_sf_bessel_k1_scaled_e 
               gsl_sf_bessel_k1_scaled 
               gsl_sf_bessel_k2_scaled_e 
               gsl_sf_bessel_k2_scaled 
               gsl_sf_bessel_kl_scaled_e 
               gsl_sf_bessel_kl_scaled 
               gsl_sf_bessel_kl_scaled_array 
               gsl_sf_bessel_Jnu_e 
               gsl_sf_bessel_Jnu 
               gsl_sf_bessel_Ynu_e 
               gsl_sf_bessel_Ynu 
               gsl_sf_bessel_sequence_Jnu_e 
               gsl_sf_bessel_Inu_scaled_e 
               gsl_sf_bessel_Inu_scaled 
               gsl_sf_bessel_Inu_e 
               gsl_sf_bessel_Inu 
               gsl_sf_bessel_Knu_scaled_e 
               gsl_sf_bessel_Knu_scaled 
               gsl_sf_bessel_Knu_e 
               gsl_sf_bessel_Knu 
               gsl_sf_bessel_lnKnu_e 
               gsl_sf_bessel_lnKnu 
               gsl_sf_bessel_zero_J0_e 
               gsl_sf_bessel_zero_J0 
               gsl_sf_bessel_zero_J1_e 
               gsl_sf_bessel_zero_J1 
               gsl_sf_bessel_zero_Jnu_e 
               gsl_sf_bessel_zero_Jnu 
               /;
@EXPORT_clausen = qw/
               gsl_sf_clausen_e 
               gsl_sf_clausen 
               /;
@EXPORT_hydrogenic =  qw/
               gsl_sf_hydrogenicR_1_e 
               gsl_sf_hydrogenicR_1 
               gsl_sf_hydrogenicR_e 
               gsl_sf_hydrogenicR 
               /;
@EXPORT_coulumb = qw/
               gsl_sf_coulomb_wave_FG_e 
               gsl_sf_coulomb_wave_F_array 
               gsl_sf_coulomb_wave_FG_array 
               gsl_sf_coulomb_wave_FGp_array 
               gsl_sf_coulomb_wave_sphF_array 
               gsl_sf_coulomb_CL_e 
               gsl_sf_coulomb_CL_array 
               /;
@EXPORT_coupling = qw/
               gsl_sf_coupling_3j_e 
               gsl_sf_coupling_3j 
               gsl_sf_coupling_6j_e 
               gsl_sf_coupling_6j 
               gsl_sf_coupling_RacahW_e 
               gsl_sf_coupling_RacahW 
               gsl_sf_coupling_9j_e 
               gsl_sf_coupling_9j 
               gsl_sf_coupling_6j_INCORRECT_e 
               gsl_sf_coupling_6j_INCORRECT  
               /;
@EXPORT_dawson = qw/
               gsl_sf_dawson_e 
               gsl_sf_dawson 
               /;
@EXPORT_debye = qw/
               gsl_sf_debye_1_e 
               gsl_sf_debye_1 
               gsl_sf_debye_2_e 
               gsl_sf_debye_2 
               gsl_sf_debye_3_e 
               gsl_sf_debye_3 
               gsl_sf_debye_4_e 
               gsl_sf_debye_4 
               gsl_sf_debye_5_e 
               gsl_sf_debye_5 
               gsl_sf_debye_6_e 
               gsl_sf_debye_6 
               /;
@EXPORT_dilog = qw/
               gsl_sf_dilog_e 
               gsl_sf_dilog 
               gsl_sf_complex_dilog_xy_e 
               gsl_sf_complex_dilog_e 
               /;

@EXPORT_misc = qw/
               gsl_sf_complex_spence_xy_e 
               gsl_sf_multiply_e 
               gsl_sf_multiply 
               gsl_sf_multiply_err_e 
               /;
@EXPORT_elliptic = qw/
               gsl_sf_ellint_Kcomp_e 
               gsl_sf_ellint_Kcomp 
               gsl_sf_ellint_Ecomp_e 
               gsl_sf_ellint_Ecomp 
               gsl_sf_ellint_Pcomp_e 
               gsl_sf_ellint_Pcomp 
               gsl_sf_ellint_Dcomp_e 
               gsl_sf_ellint_Dcomp 
               gsl_sf_ellint_F_e 
               gsl_sf_ellint_F 
               gsl_sf_ellint_E_e 
               gsl_sf_ellint_E 
               gsl_sf_ellint_P_e 
               gsl_sf_ellint_P 
               gsl_sf_ellint_D_e 
               gsl_sf_ellint_D 
               gsl_sf_ellint_RC_e 
               gsl_sf_ellint_RC 
               gsl_sf_ellint_RD_e 
               gsl_sf_ellint_RD 
               gsl_sf_ellint_RF_e 
               gsl_sf_ellint_RF 
               gsl_sf_ellint_RJ_e 
               gsl_sf_ellint_RJ 
               gsl_sf_elljac_e 
               /;
@EXPORT_error = qw/
               gsl_sf_erfc_e 
               gsl_sf_erfc 
               gsl_sf_log_erfc_e 
               gsl_sf_log_erfc 
               gsl_sf_erf_e 
               gsl_sf_erf 
               gsl_sf_erf_Z_e 
               gsl_sf_erf_Q_e 
               gsl_sf_erf_Z 
               gsl_sf_erf_Q 
               gsl_sf_hazard_e 
               gsl_sf_hazard 
               /;
push @EXPORT_misc, qw/
               gsl_sf_exp_e 
               gsl_sf_exp 
               gsl_sf_exp_e10_e 
               gsl_sf_exp_mult_e 
               gsl_sf_exp_mult 
               gsl_sf_exp_mult_e10_e 
               gsl_sf_expm1_e 
               gsl_sf_expm1 
               gsl_sf_exprel_e 
               gsl_sf_exprel 
               gsl_sf_exprel_2_e 
               gsl_sf_exprel_2 
               gsl_sf_exprel_n_e 
               gsl_sf_exprel_n 
               gsl_sf_exp_err_e 
               gsl_sf_exp_err_e10_e 
               gsl_sf_exp_mult_err_e 
               gsl_sf_exp_mult_err_e10_e 
               gsl_sf_expint_E1_e 
               gsl_sf_expint_E1 
               gsl_sf_expint_E2_e 
               gsl_sf_expint_E2 
               gsl_sf_expint_En_e 
               gsl_sf_expint_En 
               gsl_sf_expint_E1_scaled_e 
               gsl_sf_expint_E1_scaled 
               gsl_sf_expint_E2_scaled_e 
               gsl_sf_expint_E2_scaled 
               gsl_sf_expint_En_scaled_e 
               gsl_sf_expint_En_scaled 
               gsl_sf_expint_Ei_e 
               gsl_sf_expint_Ei 
               gsl_sf_expint_Ei_scaled_e 
               gsl_sf_expint_Ei_scaled 
               gsl_sf_Shi_e 
               gsl_sf_Shi 
               gsl_sf_Chi_e 
               gsl_sf_Chi 
               gsl_sf_expint_3_e 
               gsl_sf_expint_3 
               gsl_sf_Si_e 
               gsl_sf_Si 
               gsl_sf_Ci_e 
               gsl_sf_Ci 
               /;
@EXPORT_fermi_dirac = qw/
               gsl_sf_fermi_dirac_m1_e 
               gsl_sf_fermi_dirac_m1 
               gsl_sf_fermi_dirac_0_e 
               gsl_sf_fermi_dirac_0 
               gsl_sf_fermi_dirac_1_e 
               gsl_sf_fermi_dirac_1 
               gsl_sf_fermi_dirac_2_e 
               gsl_sf_fermi_dirac_2 
               gsl_sf_fermi_dirac_int_e 
               gsl_sf_fermi_dirac_int 
               gsl_sf_fermi_dirac_mhalf_e 
               gsl_sf_fermi_dirac_mhalf 
               gsl_sf_fermi_dirac_half_e 
               gsl_sf_fermi_dirac_half 
               gsl_sf_fermi_dirac_3half_e 
               gsl_sf_fermi_dirac_3half 
               gsl_sf_fermi_dirac_inc_0_e 
               gsl_sf_fermi_dirac_inc_0 
               /;
@EXPORT_legendre = qw/
               gsl_sf_legendre_Pl_e 
               gsl_sf_legendre_Pl 
               gsl_sf_legendre_Pl_array 
               gsl_sf_legendre_Pl_deriv_array 
               gsl_sf_legendre_P1_e 
               gsl_sf_legendre_P2_e 
               gsl_sf_legendre_P3_e 
               gsl_sf_legendre_P1 
               gsl_sf_legendre_P2 
               gsl_sf_legendre_P3 
               gsl_sf_legendre_Q0_e 
               gsl_sf_legendre_Q0 
               gsl_sf_legendre_Q1_e 
               gsl_sf_legendre_Q1 
               gsl_sf_legendre_Ql_e 
               gsl_sf_legendre_Ql 
               gsl_sf_legendre_Plm_e 
               gsl_sf_legendre_Plm 
               gsl_sf_legendre_Plm_array 
               gsl_sf_legendre_Plm_deriv_array 
               gsl_sf_legendre_sphPlm_e 
               gsl_sf_legendre_sphPlm 
               gsl_sf_legendre_sphPlm_array 
               gsl_sf_legendre_sphPlm_deriv_array 
               gsl_sf_legendre_array_size 
               gsl_sf_legendre_H3d_0_e 
               gsl_sf_legendre_H3d_0 
               gsl_sf_legendre_H3d_1_e 
               gsl_sf_legendre_H3d_1 
               gsl_sf_legendre_H3d_e 
               gsl_sf_legendre_H3d 
               gsl_sf_legendre_H3d_array 
               /;
@EXPORT_gamma = qw/
               gsl_sf_lngamma_e 
               gsl_sf_lngamma 
               gsl_sf_lngamma_sgn_e 
               gsl_sf_gamma_e 
               gsl_sf_gamma 
               gsl_sf_gammastar_e 
               gsl_sf_gammastar 
               gsl_sf_gammainv_e 
               gsl_sf_gammainv 
               gsl_sf_lngamma_complex_e 
               gsl_sf_gamma_inc_Q_e 
               gsl_sf_gamma_inc_Q 
               gsl_sf_gamma_inc_P_e 
               gsl_sf_gamma_inc_P 
               gsl_sf_gamma_inc_e 
               gsl_sf_gamma_inc 
               /;
@EXPORT_factorial = qw/
               gsl_sf_fact_e 
               gsl_sf_fact 
               gsl_sf_doublefact_e 
               gsl_sf_doublefact 
               gsl_sf_lnfact_e 
               gsl_sf_lnfact 
               gsl_sf_lndoublefact_e 
               gsl_sf_lndoublefact 
               /;
@EXPORT_hypergeometric = qw/
               gsl_sf_hyperg_0F1_e 
               gsl_sf_hyperg_0F1 
               gsl_sf_hyperg_1F1_int_e 
               gsl_sf_hyperg_1F1_int 
               gsl_sf_hyperg_1F1_e 
               gsl_sf_hyperg_1F1 
               gsl_sf_hyperg_U_int_e 
               gsl_sf_hyperg_U_int 
               gsl_sf_hyperg_U_int_e10_e 
               gsl_sf_hyperg_U_e 
               gsl_sf_hyperg_U 
               gsl_sf_hyperg_U_e10_e 
               gsl_sf_hyperg_2F1_e 
               gsl_sf_hyperg_2F1 
               gsl_sf_hyperg_2F1_conj_e 
               gsl_sf_hyperg_2F1_conj 
               gsl_sf_hyperg_2F1_renorm_e 
               gsl_sf_hyperg_2F1_renorm 
               gsl_sf_hyperg_2F1_conj_renorm_e 
               gsl_sf_hyperg_2F1_conj_renorm 
               gsl_sf_hyperg_2F0_e 
               gsl_sf_hyperg_2F0 
               /;
@EXPORT_laguerre = qw/
               gsl_sf_laguerre_1_e 
               gsl_sf_laguerre_2_e 
               gsl_sf_laguerre_3_e 
               gsl_sf_laguerre_1 
               gsl_sf_laguerre_2 
               gsl_sf_laguerre_3 
               gsl_sf_laguerre_n_e 
               gsl_sf_laguerre_n 
               /;
push @EXPORT_misc, qw/
               gsl_sf_taylorcoeff_e 
               gsl_sf_taylorcoeff 
               gsl_sf_lnchoose_e 
               gsl_sf_lnchoose 
               gsl_sf_choose_e 
               gsl_sf_choose 
               gsl_sf_lnpoch_e 
               gsl_sf_lnpoch 
               gsl_sf_lnpoch_sgn_e 
               gsl_sf_poch_e 
               gsl_sf_poch 
               gsl_sf_pochrel_e 
               gsl_sf_pochrel 
               gsl_sf_lnbeta_e 
               gsl_sf_lnbeta 
               gsl_sf_lnbeta_sgn_e 
               gsl_sf_beta_e 
               gsl_sf_beta 
               gsl_sf_beta_inc_e 
               gsl_sf_beta_inc 
               gsl_sf_gegenpoly_1_e 
               gsl_sf_gegenpoly_2_e 
               gsl_sf_gegenpoly_3_e 
               gsl_sf_gegenpoly_1 
               gsl_sf_gegenpoly_2 
               gsl_sf_gegenpoly_3 
               gsl_sf_gegenpoly_n_e 
               gsl_sf_gegenpoly_n 
               gsl_sf_gegenpoly_array 
               gsl_sf_lambert_W0_e 
               gsl_sf_lambert_W0 
               gsl_sf_lambert_Wm1_e 
               gsl_sf_lambert_Wm1 
               gsl_sf_conicalP_half_e 
               gsl_sf_conicalP_half 
               gsl_sf_conicalP_mhalf_e 
               gsl_sf_conicalP_mhalf 
               gsl_sf_conicalP_0_e 
               gsl_sf_conicalP_0 
               gsl_sf_conicalP_1_e 
               gsl_sf_conicalP_1 
               gsl_sf_conicalP_sph_reg_e 
               gsl_sf_conicalP_sph_reg 
               gsl_sf_conicalP_cyl_reg_e 
               gsl_sf_conicalP_cyl_reg 
               gsl_sf_log_e 
               gsl_sf_log 
               gsl_sf_log_abs_e 
               gsl_sf_log_abs 
               gsl_sf_complex_log_e 
               gsl_sf_log_1plusx_e 
               gsl_sf_log_1plusx 
               gsl_sf_log_1plusx_mx_e 
               gsl_sf_log_1plusx_mx 
               gsl_sf_pow_int_e 
               gsl_sf_pow_int 
               gsl_sf_psi_int_e 
               gsl_sf_psi_int 
               gsl_sf_psi_e 
               gsl_sf_psi 
               gsl_sf_psi_1piy_e 
               gsl_sf_psi_1piy 
               gsl_sf_complex_psi_e 
               gsl_sf_psi_1_int_e 
               gsl_sf_psi_1_int 
               gsl_sf_psi_1_e 
               gsl_sf_psi_1 
               gsl_sf_psi_n_e 
               gsl_sf_psi_n 
               gsl_sf_result_smash_e 
               gsl_sf_synchrotron_1_e 
               gsl_sf_synchrotron_1 
               gsl_sf_synchrotron_2_e 
               gsl_sf_synchrotron_2 
               /;
@EXPORT_mathieu = qw/
               gsl_sf_mathieu_a_array 
               gsl_sf_mathieu_b_array 
               gsl_sf_mathieu_a 
               gsl_sf_mathieu_b 
               gsl_sf_mathieu_a_coeff 
               gsl_sf_mathieu_b_coeff 
               gsl_sf_mathieu_alloc 
               gsl_sf_mathieu_free 
               gsl_sf_mathieu_ce 
               gsl_sf_mathieu_se 
               gsl_sf_mathieu_ce_array 
               gsl_sf_mathieu_se_array 
               gsl_sf_mathieu_Mc 
               gsl_sf_mathieu_Ms 
               gsl_sf_mathieu_Mc_array 
               gsl_sf_mathieu_Ms_array 
               /;
@EXPORT_transport = qw/
               gsl_sf_transport_2_e 
               gsl_sf_transport_2 
               gsl_sf_transport_3_e 
               gsl_sf_transport_3 
               gsl_sf_transport_4_e 
               gsl_sf_transport_4 
               gsl_sf_transport_5_e 
               gsl_sf_transport_5 
               /;
@EXPORT_trig = qw/
               gsl_sf_sin_e 
               gsl_sf_sin 
               gsl_sf_cos_e 
               gsl_sf_cos 
               gsl_sf_hypot_e 
               gsl_sf_hypot 
               gsl_sf_complex_sin_e 
               gsl_sf_complex_cos_e 
               gsl_sf_complex_logsin_e 
               gsl_sf_sinc_e 
               gsl_sf_sinc 
               gsl_sf_lnsinh_e 
               gsl_sf_lnsinh 
               gsl_sf_lncosh_e 
               gsl_sf_lncosh 
               gsl_sf_polar_to_rect 
               gsl_sf_rect_to_polar 
               gsl_sf_sin_err_e 
               gsl_sf_cos_err_e 
               gsl_sf_angle_restrict_symm_e 
               gsl_sf_angle_restrict_symm 
               gsl_sf_angle_restrict_pos_e 
               gsl_sf_angle_restrict_pos 
               gsl_sf_angle_restrict_symm_err_e 
               gsl_sf_angle_restrict_pos_err_e 
               gsl_sf_atanint_e 
               gsl_sf_atanint 
               /;
@EXPORT_zeta = qw/
               gsl_sf_zeta_int_e 
               gsl_sf_zeta_int 
               gsl_sf_zeta_e 
               gsl_sf_zeta 
               gsl_sf_zetam1_e 
               gsl_sf_zetam1 
               gsl_sf_zetam1_int_e 
               gsl_sf_zetam1_int 
               gsl_sf_hzeta_e 
               gsl_sf_hzeta 
               /;
@EXPORT_eta = qw/
               gsl_sf_eta_int_e 
               gsl_sf_eta_int 
               gsl_sf_eta_e 
               gsl_sf_eta 
               /;
@EXPORT_vars = qw/
               GSL_SF_GAMMA_XMAX 
               GSL_SF_FACT_NMAX 
               GSL_SF_DOUBLEFACT_NMAX 
               GSL_SF_MATHIEU_COEFF 
               /;

@EXPORT_OK = ( 
               @EXPORT_airy, @EXPORT_bessel, @EXPORT_clausen, @EXPORT_hydrogenic,
               @EXPORT_coulumb, @EXPORT_coupling, @EXPORT_dawson, @EXPORT_debye,
               @EXPORT_dilog, @EXPORT_misc, @EXPORT_elliptic, @EXPORT_error, @EXPORT_legendre,
               @EXPORT_gamma, @EXPORT_transport, @EXPORT_trig, @EXPORT_zeta, @EXPORT_eta,
               @EXPORT_vars
             );

%EXPORT_TAGS = ( 
                 all            => [ @EXPORT_OK ],
                 airy           => [ @EXPORT_airy ], 
                 bessel         => [ @EXPORT_bessel ], 
                 clausen        => [ @EXPORT_clausen ], 
                 coulumb        => [ @EXPORT_coulumb ], 
                 coupling       => [ @EXPORT_coupling ], 
                 dawson         => [ @EXPORT_dawson ], 
                 debye          => [ @EXPORT_debye ], 
                 dilog          => [ @EXPORT_dilog ], 
                 eta            => [ @EXPORT_eta ], 
                 elliptic       => [ @EXPORT_elliptic ], 
                 error          => [ @EXPORT_error ], 
                 factorial      => [ @EXPORT_factorial ],
                 gamma          => [ @EXPORT_gamma ], 
                 hydrogenic     => [ @EXPORT_hydrogenic ], 
                 hypergeometric => [ @EXPORT_hypergeometric ],
                 laguerre       => [ @EXPORT_laguerre ],
                 legendre       => [ @EXPORT_legendre ], 
                 mathieu        => [ @EXPORT_mathieu ], 
                 misc           => [ @EXPORT_misc ], 
                 transport      => [ @EXPORT_transport ], 
                 trig           => [ @EXPORT_trig ], 
                 vars           => [ @EXPORT_vars ],
                 zeta           => [ @EXPORT_zeta ],
                );

__END__

=head1 NAME

Math::GSL::SF - Special Functions

=head1 SYPNOPSIS

use Math::GSL::SF qw /:all/;
use Math::GSL::SF qw /:bessel :airy :zeta/;

=head1 DESCRIPTION

Here is a list of all included functions:
gsl_sf_airy_Ai_e, gsl_sf_airy_Ai, gsl_sf_airy_Bi_e, 
gsl_sf_airy_Bi, gsl_sf_airy_Ai_scaled_e, gsl_sf_airy_Ai_scaled, 
gsl_sf_airy_Bi_scaled_e, gsl_sf_airy_Bi_scaled, gsl_sf_airy_Ai_deriv_e, 
gsl_sf_airy_Ai_deriv, gsl_sf_airy_Bi_deriv_e, gsl_sf_airy_Bi_deriv, 
gsl_sf_airy_Ai_deriv_scaled_e, gsl_sf_airy_Ai_deriv_scaled, gsl_sf_airy_Bi_deriv_scaled_e, 
gsl_sf_airy_Bi_deriv_scaled, gsl_sf_airy_zero_Ai_e, gsl_sf_airy_zero_Ai, 
gsl_sf_airy_zero_Bi_e, gsl_sf_airy_zero_Bi, gsl_sf_airy_zero_Ai_deriv_e, 
gsl_sf_airy_zero_Ai_deriv, gsl_sf_airy_zero_Bi_deriv_e, gsl_sf_airy_zero_Bi_deriv, 
gsl_sf_bessel_J0_e, gsl_sf_bessel_J0, gsl_sf_bessel_J1_e, 
gsl_sf_bessel_J1, gsl_sf_bessel_Jn_e, gsl_sf_bessel_Jn, 
gsl_sf_bessel_Jn_array, gsl_sf_bessel_Y0_e, gsl_sf_bessel_Y0, 
gsl_sf_bessel_Y1_e, gsl_sf_bessel_Y1, gsl_sf_bessel_Yn_e, 
gsl_sf_bessel_Yn, gsl_sf_bessel_Yn_array, gsl_sf_bessel_I0_e, 
gsl_sf_bessel_I0, gsl_sf_bessel_I1_e, gsl_sf_bessel_I1, 
gsl_sf_bessel_In_e, gsl_sf_bessel_In, gsl_sf_bessel_In_array, 
gsl_sf_bessel_I0_scaled_e, gsl_sf_bessel_I0_scaled, gsl_sf_bessel_I1_scaled_e, 
gsl_sf_bessel_I1_scaled, gsl_sf_bessel_In_scaled_e, gsl_sf_bessel_In_scaled, 
gsl_sf_bessel_In_scaled_array, gsl_sf_bessel_K0_e, gsl_sf_bessel_K0, 
gsl_sf_bessel_K1_e, gsl_sf_bessel_K1, gsl_sf_bessel_Kn_e, 
gsl_sf_bessel_Kn, gsl_sf_bessel_Kn_array, gsl_sf_bessel_K0_scaled_e, 
gsl_sf_bessel_K0_scaled, gsl_sf_bessel_K1_scaled_e, gsl_sf_bessel_K1_scaled, 
gsl_sf_bessel_Kn_scaled_e, gsl_sf_bessel_Kn_scaled, gsl_sf_bessel_Kn_scaled_array, 
gsl_sf_bessel_j0_e, gsl_sf_bessel_j0, gsl_sf_bessel_j1_e, 
gsl_sf_bessel_j1, gsl_sf_bessel_j2_e, gsl_sf_bessel_j2, 
gsl_sf_bessel_jl_e, gsl_sf_bessel_jl, gsl_sf_bessel_jl_array, 
gsl_sf_bessel_jl_steed_array, gsl_sf_bessel_y0_e, gsl_sf_bessel_y0, 
gsl_sf_bessel_y1_e, gsl_sf_bessel_y1, gsl_sf_bessel_y2_e, 
gsl_sf_bessel_y2, gsl_sf_bessel_yl_e, gsl_sf_bessel_yl, 
gsl_sf_bessel_yl_array, gsl_sf_bessel_i0_scaled_e, gsl_sf_bessel_i0_scaled, 
gsl_sf_bessel_i1_scaled_e, gsl_sf_bessel_i1_scaled, gsl_sf_bessel_i2_scaled_e, 
gsl_sf_bessel_i2_scaled, gsl_sf_bessel_il_scaled_e, gsl_sf_bessel_il_scaled, 
gsl_sf_bessel_il_scaled_array, gsl_sf_bessel_k0_scaled_e, gsl_sf_bessel_k0_scaled, 
gsl_sf_bessel_k1_scaled_e, gsl_sf_bessel_k1_scaled, gsl_sf_bessel_k2_scaled_e, 
gsl_sf_bessel_k2_scaled, gsl_sf_bessel_kl_scaled_e, gsl_sf_bessel_kl_scaled, 
gsl_sf_bessel_kl_scaled_array, gsl_sf_bessel_Jnu_e, gsl_sf_bessel_Jnu, 
gsl_sf_bessel_Ynu_e, gsl_sf_bessel_Ynu, gsl_sf_bessel_sequence_Jnu_e, 
gsl_sf_bessel_Inu_scaled_e, gsl_sf_bessel_Inu_scaled, gsl_sf_bessel_Inu_e, 
gsl_sf_bessel_Inu, gsl_sf_bessel_Knu_scaled_e, gsl_sf_bessel_Knu_scaled, 
gsl_sf_bessel_Knu_e, gsl_sf_bessel_Knu, gsl_sf_bessel_lnKnu_e, 
gsl_sf_bessel_lnKnu, gsl_sf_bessel_zero_J0_e, gsl_sf_bessel_zero_J0, 
gsl_sf_bessel_zero_J1_e, gsl_sf_bessel_zero_J1, gsl_sf_bessel_zero_Jnu_e, 
gsl_sf_bessel_zero_Jnu, gsl_sf_clausen_e, gsl_sf_clausen, 
gsl_sf_hydrogenicR_1_e, gsl_sf_hydrogenicR_1, gsl_sf_hydrogenicR_e, 
gsl_sf_hydrogenicR, gsl_sf_coulomb_wave_FG_e, gsl_sf_coulomb_wave_F_array, 
gsl_sf_coulomb_wave_FG_array, gsl_sf_coulomb_wave_FGp_array, gsl_sf_coulomb_wave_sphF_array, 
gsl_sf_coulomb_CL_e, gsl_sf_coulomb_CL_array, gsl_sf_coupling_3j_e, 
gsl_sf_coupling_3j, gsl_sf_coupling_6j_e, gsl_sf_coupling_6j, 
gsl_sf_coupling_RacahW_e, gsl_sf_coupling_RacahW, gsl_sf_coupling_9j_e, 
gsl_sf_coupling_9j, gsl_sf_coupling_6j_INCORRECT_e, gsl_sf_coupling_6j_INCORRECT, 
gsl_sf_dawson_e, gsl_sf_dawson, gsl_sf_debye_1_e, 
gsl_sf_debye_1, gsl_sf_debye_2_e, gsl_sf_debye_2, 
gsl_sf_debye_3_e, gsl_sf_debye_3, gsl_sf_debye_4_e, 
gsl_sf_debye_4, gsl_sf_debye_5_e, gsl_sf_debye_5, 
gsl_sf_debye_6_e, gsl_sf_debye_6, gsl_sf_dilog_e, 
gsl_sf_dilog, gsl_sf_complex_dilog_xy_e, gsl_sf_complex_dilog_e, 
gsl_sf_complex_spence_xy_e, gsl_sf_multiply_e, gsl_sf_multiply, 
gsl_sf_multiply_err_e, gsl_sf_ellint_Kcomp_e, gsl_sf_ellint_Kcomp, 
gsl_sf_ellint_Ecomp_e, gsl_sf_ellint_Ecomp, gsl_sf_ellint_Pcomp_e, 
gsl_sf_ellint_Pcomp, gsl_sf_ellint_Dcomp_e, gsl_sf_ellint_Dcomp, 
gsl_sf_ellint_F_e, gsl_sf_ellint_F, gsl_sf_ellint_E_e, 
gsl_sf_ellint_E, gsl_sf_ellint_P_e, gsl_sf_ellint_P, 
gsl_sf_ellint_D_e, gsl_sf_ellint_D, gsl_sf_ellint_RC_e, 
gsl_sf_ellint_RC, gsl_sf_ellint_RD_e, gsl_sf_ellint_RD, 
gsl_sf_ellint_RF_e, gsl_sf_ellint_RF, gsl_sf_ellint_RJ_e, 
gsl_sf_ellint_RJ, gsl_sf_elljac_e, gsl_sf_erfc_e, 
gsl_sf_erfc, gsl_sf_log_erfc_e, gsl_sf_log_erfc, 
gsl_sf_erf_e, gsl_sf_erf, gsl_sf_erf_Z_e, 
gsl_sf_erf_Q_e, gsl_sf_erf_Z, gsl_sf_erf_Q, 
gsl_sf_hazard_e, gsl_sf_hazard, gsl_sf_exp_e, 
gsl_sf_exp, gsl_sf_exp_e10_e, gsl_sf_exp_mult_e, 
gsl_sf_exp_mult, gsl_sf_exp_mult_e10_e, gsl_sf_expm1_e, 
gsl_sf_expm1, gsl_sf_exprel_e, gsl_sf_exprel, 
gsl_sf_exprel_2_e, gsl_sf_exprel_2, gsl_sf_exprel_n_e, 
gsl_sf_exprel_n, gsl_sf_exp_err_e, gsl_sf_exp_err_e10_e, 
gsl_sf_exp_mult_err_e, gsl_sf_exp_mult_err_e10_e, gsl_sf_expint_E1_e, 
gsl_sf_expint_E1, gsl_sf_expint_E2_e, gsl_sf_expint_E2, 
gsl_sf_expint_En_e, gsl_sf_expint_En, gsl_sf_expint_E1_scaled_e, 
gsl_sf_expint_E1_scaled, gsl_sf_expint_E2_scaled_e, gsl_sf_expint_E2_scaled, 
gsl_sf_expint_En_scaled_e, gsl_sf_expint_En_scaled, gsl_sf_expint_Ei_e, 
gsl_sf_expint_Ei, gsl_sf_expint_Ei_scaled_e, gsl_sf_expint_Ei_scaled, 
gsl_sf_Shi_e, gsl_sf_Shi, gsl_sf_Chi_e, 
gsl_sf_Chi, gsl_sf_expint_3_e, gsl_sf_expint_3, 
gsl_sf_Si_e, gsl_sf_Si, gsl_sf_Ci_e, 
gsl_sf_Ci, gsl_sf_fermi_dirac_m1_e, gsl_sf_fermi_dirac_m1, 
gsl_sf_fermi_dirac_0_e, gsl_sf_fermi_dirac_0, gsl_sf_fermi_dirac_1_e, 
gsl_sf_fermi_dirac_1, gsl_sf_fermi_dirac_2_e, gsl_sf_fermi_dirac_2, 
gsl_sf_fermi_dirac_int_e, gsl_sf_fermi_dirac_int, gsl_sf_fermi_dirac_mhalf_e, 
gsl_sf_fermi_dirac_mhalf, gsl_sf_fermi_dirac_half_e, gsl_sf_fermi_dirac_half, 
gsl_sf_fermi_dirac_3half_e, gsl_sf_fermi_dirac_3half, gsl_sf_fermi_dirac_inc_0_e, 
gsl_sf_fermi_dirac_inc_0, gsl_sf_legendre_Pl_e, gsl_sf_legendre_Pl, 
gsl_sf_legendre_Pl_array, gsl_sf_legendre_Pl_deriv_array, gsl_sf_legendre_P1_e, 
gsl_sf_legendre_P2_e, gsl_sf_legendre_P3_e, gsl_sf_legendre_P1, 
gsl_sf_legendre_P2, gsl_sf_legendre_P3, gsl_sf_legendre_Q0_e, 
gsl_sf_legendre_Q0, gsl_sf_legendre_Q1_e, gsl_sf_legendre_Q1, 
gsl_sf_legendre_Ql_e, gsl_sf_legendre_Ql, gsl_sf_legendre_Plm_e, 
gsl_sf_legendre_Plm, gsl_sf_legendre_Plm_array, gsl_sf_legendre_Plm_deriv_array, 
gsl_sf_legendre_sphPlm_e, gsl_sf_legendre_sphPlm, gsl_sf_legendre_sphPlm_array, 
gsl_sf_legendre_sphPlm_deriv_array, gsl_sf_legendre_array_size, gsl_sf_lngamma_e, 
gsl_sf_lngamma, gsl_sf_lngamma_sgn_e, gsl_sf_gamma_e, 
gsl_sf_gamma, gsl_sf_gammastar_e, gsl_sf_gammastar, 
gsl_sf_gammainv_e, gsl_sf_gammainv, gsl_sf_lngamma_complex_e, 
gsl_sf_gamma_inc_Q_e, gsl_sf_gamma_inc_Q, gsl_sf_gamma_inc_P_e, 
gsl_sf_gamma_inc_P, gsl_sf_gamma_inc_e, gsl_sf_gamma_inc, 
gsl_sf_taylorcoeff_e, gsl_sf_taylorcoeff, gsl_sf_fact_e, 
gsl_sf_fact, gsl_sf_doublefact_e, gsl_sf_doublefact, 
gsl_sf_lnfact_e, gsl_sf_lnfact, gsl_sf_lndoublefact_e, 
gsl_sf_lndoublefact, gsl_sf_lnchoose_e, gsl_sf_lnchoose, 
gsl_sf_choose_e, gsl_sf_choose, gsl_sf_lnpoch_e, 
gsl_sf_lnpoch, gsl_sf_lnpoch_sgn_e, gsl_sf_poch_e, 
gsl_sf_poch, gsl_sf_pochrel_e, gsl_sf_pochrel, 
gsl_sf_lnbeta_e, gsl_sf_lnbeta, gsl_sf_lnbeta_sgn_e, 
gsl_sf_beta_e, gsl_sf_beta, gsl_sf_beta_inc_e, 
gsl_sf_beta_inc, gsl_sf_gegenpoly_1_e, gsl_sf_gegenpoly_2_e, 
gsl_sf_gegenpoly_3_e, gsl_sf_gegenpoly_1, gsl_sf_gegenpoly_2, 
gsl_sf_gegenpoly_3, gsl_sf_gegenpoly_n_e, gsl_sf_gegenpoly_n, 
gsl_sf_gegenpoly_array, gsl_sf_hyperg_0F1_e, gsl_sf_hyperg_0F1, 
gsl_sf_hyperg_1F1_int_e, gsl_sf_hyperg_1F1_int, gsl_sf_hyperg_1F1_e, 
gsl_sf_hyperg_1F1, gsl_sf_hyperg_U_int_e, gsl_sf_hyperg_U_int, 
gsl_sf_hyperg_U_int_e10_e, gsl_sf_hyperg_U_e, gsl_sf_hyperg_U, 
gsl_sf_hyperg_U_e10_e, gsl_sf_hyperg_2F1_e, gsl_sf_hyperg_2F1, 
gsl_sf_hyperg_2F1_conj_e, gsl_sf_hyperg_2F1_conj, gsl_sf_hyperg_2F1_renorm_e, 
gsl_sf_hyperg_2F1_renorm, gsl_sf_hyperg_2F1_conj_renorm_e, gsl_sf_hyperg_2F1_conj_renorm, 
gsl_sf_hyperg_2F0_e, gsl_sf_hyperg_2F0, gsl_sf_laguerre_1_e, 
gsl_sf_laguerre_2_e, gsl_sf_laguerre_3_e, gsl_sf_laguerre_1, 
gsl_sf_laguerre_2, gsl_sf_laguerre_3, gsl_sf_laguerre_n_e, 
gsl_sf_laguerre_n, gsl_sf_lambert_W0_e, gsl_sf_lambert_W0, 
gsl_sf_lambert_Wm1_e, gsl_sf_lambert_Wm1, gsl_sf_conicalP_half_e, 
gsl_sf_conicalP_half, gsl_sf_conicalP_mhalf_e, gsl_sf_conicalP_mhalf, 
gsl_sf_conicalP_0_e, gsl_sf_conicalP_0, gsl_sf_conicalP_1_e, 
gsl_sf_conicalP_1, gsl_sf_conicalP_sph_reg_e, gsl_sf_conicalP_sph_reg, 
gsl_sf_conicalP_cyl_reg_e, gsl_sf_conicalP_cyl_reg, gsl_sf_legendre_H3d_0_e, 
gsl_sf_legendre_H3d_0, gsl_sf_legendre_H3d_1_e, gsl_sf_legendre_H3d_1, 
gsl_sf_legendre_H3d_e, gsl_sf_legendre_H3d, gsl_sf_legendre_H3d_array, 
gsl_sf_log_e, gsl_sf_log, gsl_sf_log_abs_e, 
gsl_sf_log_abs, gsl_sf_complex_log_e, gsl_sf_log_1plusx_e, 
gsl_sf_log_1plusx, gsl_sf_log_1plusx_mx_e, gsl_sf_log_1plusx_mx, 
gsl_sf_mathieu_a_array, gsl_sf_mathieu_b_array, gsl_sf_mathieu_a, 
gsl_sf_mathieu_b, gsl_sf_mathieu_a_coeff, gsl_sf_mathieu_b_coeff, 
gsl_sf_mathieu_alloc, gsl_sf_mathieu_free, gsl_sf_mathieu_ce, 
gsl_sf_mathieu_se, gsl_sf_mathieu_ce_array, gsl_sf_mathieu_se_array, 
gsl_sf_mathieu_Mc, gsl_sf_mathieu_Ms, gsl_sf_mathieu_Mc_array, 
gsl_sf_mathieu_Ms_array, gsl_sf_pow_int_e, gsl_sf_pow_int, 
gsl_sf_psi_int_e, gsl_sf_psi_int, gsl_sf_psi_e, 
gsl_sf_psi, gsl_sf_psi_1piy_e, gsl_sf_psi_1piy, 
gsl_sf_complex_psi_e, gsl_sf_psi_1_int_e, gsl_sf_psi_1_int, 
gsl_sf_psi_1_e, gsl_sf_psi_1, gsl_sf_psi_n_e, 
gsl_sf_psi_n, gsl_sf_result_smash_e, gsl_sf_synchrotron_1_e, 
gsl_sf_synchrotron_1, gsl_sf_synchrotron_2_e, gsl_sf_synchrotron_2, 
gsl_sf_transport_2_e, gsl_sf_transport_2, gsl_sf_transport_3_e, 
gsl_sf_transport_3, gsl_sf_transport_4_e, gsl_sf_transport_4, 
gsl_sf_transport_5_e, gsl_sf_transport_5, gsl_sf_sin_e, 
gsl_sf_sin, gsl_sf_cos_e, gsl_sf_cos, 
gsl_sf_hypot_e, gsl_sf_hypot, gsl_sf_complex_sin_e, 
gsl_sf_complex_cos_e, gsl_sf_complex_logsin_e, gsl_sf_sinc_e, 
gsl_sf_sinc, gsl_sf_lnsinh_e, gsl_sf_lnsinh, 
gsl_sf_lncosh_e, gsl_sf_lncosh, gsl_sf_polar_to_rect, 
gsl_sf_rect_to_polar, gsl_sf_sin_err_e, gsl_sf_cos_err_e, 
gsl_sf_angle_restrict_symm_e, gsl_sf_angle_restrict_symm, gsl_sf_angle_restrict_pos_e, 
gsl_sf_angle_restrict_pos, gsl_sf_angle_restrict_symm_err_e, gsl_sf_angle_restrict_pos_err_e, 
gsl_sf_atanint_e, gsl_sf_atanint, gsl_sf_zeta_int_e, 
gsl_sf_zeta_int, gsl_sf_zeta_e, gsl_sf_zeta, 
gsl_sf_zetam1_e, gsl_sf_zetam1, gsl_sf_zetam1_int_e, 
gsl_sf_zetam1_int, gsl_sf_hzeta_e, gsl_sf_hzeta, 
gsl_sf_eta_int_e, gsl_sf_eta_int, gsl_sf_eta_e, gsl_sf_eta 


You can import the functions that you want to use by giving a space separated list to Math::GSL::SF when you use the package. You can also write 

    use Math::GSL::SF qw/:all/
    
to use all avaible functions of the module. Note that tag names begin with a colon. 
Other tags are also available, here is a complete list of all tags for this module :

airy
bessel 
clausen 
hydrogenic
coulumb
coupling
dawson
debye
dilog
factorial
misc
elliptic
error
hypergeometric
laguerre
legendre
gamma
transport
trig
zeta
eta
vars

For more informations on the functions, we refer you to the GSL offcial documentation: 

http://www.gnu.org/software/gsl/manual/html_node/

Tip : search on google: site:http://www.gnu.org/software/gsl/manual/html_node/name_of_the_function_you_want

=head1 EXAMPLES


=head1 AUTHOR

Jonathan Leto <jaleto@gmail.com> and Thierry Moisan <thierry.moisan@gmail.com>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2008 Jonathan Leto and Thierry Moisan

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut
%}
