%module "Math::GSL::SF"
%include "typemaps.i"

%apply double *OUTPUT { double * sn, double * cn, double * dn };

%{
    #include "gsl/gsl_mode.h"
    #include "gsl/gsl_sf.h"
    #include "gsl/gsl_sf_airy.h"
    #include "gsl/gsl_sf_bessel.h"
    #include "gsl/gsl_sf_clausen.h"
    #include "gsl/gsl_sf_coulomb.h"
    #include "gsl/gsl_sf_coupling.h"
    #include "gsl/gsl_sf_dawson.h"
    #include "gsl/gsl_sf_debye.h"
    #include "gsl/gsl_sf_dilog.h"
    #include "gsl/gsl_sf_elementary.h"
    #include "gsl/gsl_sf_ellint.h"
    #include "gsl/gsl_sf_elljac.h"
    #include "gsl/gsl_sf_erf.h"
    #include "gsl/gsl_sf_exp.h"
    #include "gsl/gsl_sf_expint.h"
    #include "gsl/gsl_sf_fermi_dirac.h"
    #include "gsl/gsl_sf_gamma.h"
    #include "gsl/gsl_sf_gegenbauer.h"
    #include "gsl/gsl_sf_hyperg.h"
    #include "gsl/gsl_sf_laguerre.h"
    #include "gsl/gsl_sf_lambert.h"
    #include "gsl/gsl_sf_legendre.h"
    #include "gsl/gsl_sf_log.h"
    #include "gsl/gsl_sf_mathieu.h"
    #include "gsl/gsl_sf_pow_int.h"
    #include "gsl/gsl_sf_psi.h"
    #include "gsl/gsl_sf_result.h"
    #include "gsl/gsl_sf_synchrotron.h"
    #include "gsl/gsl_sf_transport.h"
    #include "gsl/gsl_sf_trig.h"
    #include "gsl/gsl_sf_zeta.h"
%}

%include "gsl/gsl_mode.h"
%include "gsl/gsl_sf.h"
%include "gsl/gsl_sf_airy.h"
%include "gsl/gsl_sf_bessel.h"
%include "gsl/gsl_sf_clausen.h"
%include "gsl/gsl_sf_coulomb.h"
%include "gsl/gsl_sf_coupling.h"
%include "gsl/gsl_sf_dawson.h"
%include "gsl/gsl_sf_debye.h"
%include "gsl/gsl_sf_dilog.h"
%include "gsl/gsl_sf_elementary.h"
%include "gsl/gsl_sf_ellint.h"
%include "gsl/gsl_sf_elljac.h"
%include "gsl/gsl_sf_erf.h"
%include "gsl/gsl_sf_exp.h"
%include "gsl/gsl_sf_expint.h"
%include "gsl/gsl_sf_fermi_dirac.h"
%include "gsl/gsl_sf_gamma.h"
%include "gsl/gsl_sf_gegenbauer.h"
%include "gsl/gsl_sf_hyperg.h"
%include "gsl/gsl_sf_laguerre.h"
%include "gsl/gsl_sf_lambert.h"
%include "gsl/gsl_sf_legendre.h"
%include "gsl/gsl_sf_log.h"
%include "gsl/gsl_sf_mathieu.h"
%include "gsl/gsl_sf_pow_int.h"
%include "gsl/gsl_sf_psi.h"
%include "gsl/gsl_sf_result.h"
%include "gsl/gsl_sf_synchrotron.h"
%include "gsl/gsl_sf_transport.h"
%include "gsl/gsl_sf_trig.h"
%include "gsl/gsl_sf_zeta.h"


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
               gsl_sf_sin_pi_x_e
               gsl_sf_cos_e 
               gsl_sf_cos_pi_x_e
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

=head1 SYNOPSIS

    use Math::GSL::SF qw /:all/;

=head1 DESCRIPTION

This module contains a data structure named gsl_sf_result. To create a new one use

    $r = Math::GSL::SF::gsl_sf_result_struct->new;

You can then access the elements of the structure in this way :

    my $val   = $r->{val};

    my $error = $r->{err};

Here is a list of all included functions:

=over 

=item C<gsl_sf_airy_Ai_e($x, $mode)>

=item C<gsl_sf_airy_Ai($x, $mode, $result)> 

- These routines compute the Airy function Ai($x) with an accuracy specified by $mode. $mode should be $GSL_PREC_DOUBLE, $GSL_PREC_SINGLE or $GSL_PREC_APPROX. $result is a gsl_sf_result structure.

=back 

=over

=item C<gsl_sf_airy_Bi_e($x, $mode, $result)>

=item C<gsl_sf_airy_Bi($x, $mode)>

- These routines compute the Airy function Bi($x) with an accuracy specified by $mode. $mode should be $GSL_PREC_DOUBLE, $GSL_PREC_SINGLE or $GSL_PREC_APPROX. $result is a gsl_sf_result structure.

=back

=over

=item C<gsl_sf_airy_Ai_scaled_e($x, $mode, $result)>

=item C<gsl_sf_airy_Ai_scaled($x, $mode)> 

- These routines compute a scaled version of the Airy function S_A($x) Ai($x). For $x>0 the scaling factor S_A($x) is \exp(+(2/3) $x**(3/2)), and is 1 for $x<0. $result is a gsl_sf_result structure. 

=back

=over

=item C<gsl_sf_airy_Bi_scaled_e($x, $mode, $result)>

=item C<gsl_sf_airy_Bi_scaled($x, $mode)>

- These routines compute a scaled version of the Airy function S_B($x) Bi($x). For $x>0 the scaling factor S_B($x) is exp(-(2/3) $x**(3/2)), and is 1 for $x<0. $result is a gsl_sf_result structure.

=back

=over 

=item C<gsl_sf_airy_Ai_deriv_e($x, $mode, $result)>

=item C<gsl_sf_airy_Ai_deriv($x, $mode)>

- These routines compute the Airy function derivative Ai'($x) with an accuracy specified by $mode. $result is a gsl_sf_result structure.

=back

=over

=item C<gsl_sf_airy_Bi_deriv_e($x, $mode, $result)>

=item C<gsl_sf_airy_Bi_deriv($x, $mode)>

-These routines compute the Airy function derivative Bi'($x) with an accuracy specified by $mode. $result is a gsl_sf_result structure.

=back

=over

=item C<gsl_sf_airy_Ai_deriv_scaled_e($x, $mode, $result)>

=item C<gsl_sf_airy_Ai_deriv_scaled($x, $mode)>

-These routines compute the scaled Airy function derivative S_A(x) Ai'(x). For x>0 the scaling factor S_A(x) is \exp(+(2/3) x^(3/2)), and is 1 for x<0. $result is a gsl_sf_result structure.

=back

=over

=item C<gsl_sf_airy_Bi_deriv_scaled_e($x, $mode, $result)>

=item C<gsl_sf_airy_Bi_deriv_scaled($x, $mode)>

-These routines compute the scaled Airy function derivative S_B(x) Bi'(x). For x>0 the scaling factor S_B(x) is exp(-(2/3) x^(3/2)), and is 1 for x<0. $result is a gsl_sf_result structure.

=back

=over

=item C<gsl_sf_airy_zero_Ai_e($s, $result)>

=item C<gsl_sf_airy_zero_Ai($s)>

-These routines compute the location of the s-th zero of the Airy function Ai($x). $result is a gsl_sf_result structure.

=back

=over

=item C<gsl_sf_airy_zero_Bi_e($s, $result)>

=item C<gsl_sf_airy_zero_Bi($s)>

-These routines compute the location of the s-th zero of the Airy function Bi($x). $result is a gsl_sf_result structure.

=back

=over

=item C<gsl_sf_airy_zero_Ai_deriv_e($s, $result)>

=item C<gsl_sf_airy_zero_Ai_deriv($s)>

-These routines compute the location of the s-th zero of the Airy function derivative Ai'(x). $result is a gsl_sf_result structure.

=back

=over

=item C<gsl_sf_airy_zero_Bi_deriv_e($s, $result)>

=item C<gsl_sf_airy_zero_Bi_deriv($s)>

- These routines compute the location of the s-th zero of the Airy function derivative Bi'(x). $result is a gsl_sf_result structure.

=back

=over

=item C<gsl_sf_bessel_J0_e($x, $result)>

=item C<gsl_sf_bessel_J0($x)>

-These routines compute the regular cylindrical Bessel function of zeroth order, J_0($x). $result is a gsl_sf_result structure.

=back

=over

=item C<gsl_sf_bessel_J1_e($x, $result)>

=item C<gsl_sf_bessel_J1($x)>

- These routines compute the regular cylindrical Bessel function of first order, J_1($x). $result is a gsl_sf_result structure.

=back

=over

=item C<gsl_sf_bessel_Jn_e($n, $x, $result)>

=item C<gsl_sf_bessel_Jn($n, $x)>

-These routines compute the regular cylindrical Bessel function of order n, J_n($x).

=back

=over

=item C<gsl_sf_bessel_Jn_array($nmin, $nmax, $x, $result_array)> - This routine computes the values of the regular cylindrical Bessel functions J_n($x) for n from $nmin to $nmax inclusive, storing the results in the array $result_array. The values are computed using recurrence relations for efficiency, and therefore may differ slightly from the exact values.

=back

=over

=item C<gsl_sf_bessel_Y0_e($x, $result)>

=item C<gsl_sf_bessel_Y0($x)>

- These routines compute the irregular spherical Bessel function of zeroth order, y_0(x) = -\cos(x)/x.

=back

=over

=item C<gsl_sf_bessel_Y1_e($x, $result)>

=item C<gsl_sf_bessel_Y1($x)>

-These routines compute the irregular spherical Bessel function of first order, y_1(x) = -(\cos(x)/x + \sin(x))/x. 

=back

=over

=item C<gsl_sf_bessel_Yn_e>($n, $x, $result)

=item C<gsl_sf_bessel_Yn($n, $x)>

-These routines compute the irregular cylindrical Bessel function of order $n, Y_n(x), for x>0. 

=back

=over

=item C<gsl_sf_bessel_Yn_array>

-

=back

=over

=item C<gsl_sf_bessel_I0_e($x, $result)>

=item C<gsl_sf_bessel_I0($x)>

-These routines compute the regular modified cylindrical Bessel function of zeroth order, I_0(x). 

=back

=over

=item C<gsl_sf_bessel_I1_e($x, $result)>  

=item C<gsl_sf_bessel_I1($x)>

-These routines compute the regular modified cylindrical Bessel function of first order, I_1(x). 

=back

=over

=item C<gsl_sf_bessel_In_e($n, $x, $result)>

=item C<gsl_sf_bessel_In($n, $x)>

-These routines compute the regular modified cylindrical Bessel function of order $n, I_n(x). 

=back

=over

=item C<gsl_sf_bessel_In_array>

-

=back

=over

=item C<gsl_sf_bessel_I0_scaled_e($x, $result)>

=item C<gsl_sf_bessel_I0_scaled($x)>

-These routines compute the scaled regular modified cylindrical Bessel function of zeroth order \exp(-|x|) I_0(x). 

=back

=over

=item C<gsl_sf_bessel_I1_scaled_e($x, $result)>

=item C<gsl_sf_bessel_I1_scaled($x)>

-These routines compute the scaled regular modified cylindrical Bessel function of first order \exp(-|x|) I_1(x). 

=back

=over

=item C<gsl_sf_bessel_In_scaled_e($n, $x, $result)>

=item C<gsl_sf_bessel_In_scaled($n, $x)>

-These routines compute the scaled regular modified cylindrical Bessel function of order $n, \exp(-|x|) I_n(x) 

=back

=over

=item C<gsl_sf_bessel_In_scaled_array>

-

=back

=over

=item C<gsl_sf_bessel_K0_e($x, $result)>

=item C<gsl_sf_bessel_K0($x)>

-These routines compute the irregular modified cylindrical Bessel function of zeroth order, K_0(x), for x > 0.

=back

=over

=item C<gsl_sf_bessel_K1_e($x, $result)>

=item C<gsl_sf_bessel_K1($x)>

-These routines compute the irregular modified cylindrical Bessel function of first order, K_1(x), for x > 0. 

=back

=over

=item C<gsl_sf_bessel_Kn_e($n, $x, $result)>

=item C<gsl_sf_bessel_Kn($n, $x)>

-These routines compute the irregular modified cylindrical Bessel function of order $n, K_n(x), for x > 0.

=back

=over

=item C<gsl_sf_bessel_Kn_array>

-

=back

=over

=item C<gsl_sf_bessel_K0_scaled_e($x, $result)>

=item C<gsl_sf_bessel_K0_scaled($x)>

-These routines compute the scaled irregular modified cylindrical Bessel function of zeroth order \exp(x) K_0(x) for x>0. 

=back

=over

=item C<gsl_sf_bessel_K1_scaled_e($x, $result)>

=item C<gsl_sf_bessel_K1_scaled($x)>

-

=back

=over

=item C<gsl_sf_bessel_Kn_scaled_e($n, $x, $result)>

=item C<gsl_sf_bessel_Kn_scaled($n, $x)>

-

=back

=over

=item C<gsl_sf_bessel_Kn_scaled_array >

-

=back

=over

=item C<gsl_sf_bessel_j0_e($x, $result)>

=item C<gsl_sf_bessel_j0($x)>

-

=back

=over

=item C<gsl_sf_bessel_j1_e($x, $result)>

=item C<gsl_sf_bessel_j1($x)>

-

=back

=over

=item C<gsl_sf_bessel_j2_e($x, $result)>

=item C<gsl_sf_bessel_j2($x)>

-

=back

=over

=item C<gsl_sf_bessel_jl_e($l, $x, $result)>

=item C<gsl_sf_bessel_jl($l, $x)>

-

=back

=over

=item C<gsl_sf_bessel_jl_array>

-

=back

=over

=item C<gsl_sf_bessel_jl_steed_array>

-

=back

=over

=item C<gsl_sf_bessel_y0_e($x, $result)>

=item C<gsl_sf_bessel_y0($x)>

-

=back

=over

=item C<gsl_sf_bessel_y1_e($x, $result)>

=item C<gsl_sf_bessel_y1($x)>

-

=back

=over

=item C<gsl_sf_bessel_y2_e($x, $result)>

=item C<gsl_sf_bessel_y2($x)>

-

=back

=over

=item C<gsl_sf_bessel_yl_e($l, $x, $result)>

=item C<gsl_sf_bessel_yl($l, $x)>

-

=back

=over

=item C<gsl_sf_bessel_yl_array>

-

=back

=over

=item C<gsl_sf_bessel_i0_scaled_e($x, $result)>

=item C<gsl_sf_bessel_i0_scaled($x)>

-

=back

=over

=item C<gsl_sf_bessel_i1_scaled_e($x, $result)>

=item C<gsl_sf_bessel_i1_scaled($x)>

-

=back

=over

=item C<gsl_sf_bessel_i2_scaled_e($x, $result)>

=item C<gsl_sf_bessel_i2_scaled($x)>

-

=back

=over

=item C<gsl_sf_bessel_il_scaled_e($l, $x, $result)>

=item C<gsl_sf_bessel_il_scaled($x)>

-

=back

=over

=item C<gsl_sf_bessel_il_scaled_array>

-

=back

=over

=item C<gsl_sf_bessel_k0_scaled_e($x, $result)>

=item C<gsl_sf_bessel_k0_scale($x)>

-

=back

=over

=item C<gsl_sf_bessel_k1_scaled_e($x, $result)>

=item C<gsl_sf_bessel_k1_scaled($x)>

-

=back

=over

=item C<gsl_sf_bessel_k2_scaled_e($x, $result) >

=item C<gsl_sf_bessel_k2_scaled($x)>

-

=back

=over

=item C<gsl_sf_bessel_kl_scaled_e($l, $x, $result)>

=item C<gsl_sf_bessel_kl_scaled($l, $x)>

-

=back

=over

=item C<gsl_sf_bessel_kl_scaled_array>

-

=back

=over

=item C<gsl_sf_bessel_Jnu_e($nu, $x, $result)>

=item C<gsl_sf_bessel_Jnu($nu, $x)>

-

=back

=over

=item C<gsl_sf_bessel_sequence_Jnu_e >

-

=back

=over

=item C<gsl_sf_bessel_Ynu_e($nu, $x, $result)>

=item C<gsl_sf_bessel_Ynu($nu, $x)>

-

=back

=over

=item C<gsl_sf_bessel_Inu_scaled_e($nu, $x, $result)>

=item C<gsl_sf_bessel_Inu_scaled($nu, $x)>

-

=back

=over

=item C<gsl_sf_bessel_Inu_e($nu, $x, $result)>

=item C<gsl_sf_bessel_Inu($nu, $x)>

-

=back

=over

=item C<gsl_sf_bessel_Knu_scaled_e($nu, $x, $result)>

=item C<gsl_sf_bessel_Knu_scaled($nu, $x)>

-

=back

=over

=item C<gsl_sf_bessel_Knu_e($nu, $x, $result)>

=item C<gsl_sf_bessel_Knu($nu, $x)>

-

=back

=over

=item C<gsl_sf_bessel_lnKnu_e($nu, $x, $result)>

=item C<gsl_sf_bessel_lnKnu($nu, $x)>

-

=back

=over

=item C<gsl_sf_bessel_zero_J0_e($s, $result)>

=item C<gsl_sf_bessel_zero_J0($s)>

-

=back

=over

=item C<gsl_sf_bessel_zero_J1_e($s, $result)>

=item C<gsl_sf_bessel_zero_J1($s)>

-

=back

=over

=item C<gsl_sf_bessel_zero_Jnu_e($nu, $s, $result)>

=item C<gsl_sf_bessel_zero_Jnu($nu, $s)>

-

=back

=over

=item C<gsl_sf_clausen_e($x, $result)>

=item C<gsl_sf_clausen($x)>

-

=back

=over

=item C<gsl_sf_hydrogenicR_1_e($Z, $r, $result)>

=item C<gsl_sf_hydrogenicR_1($Z, $r)>

-

=back

=over

=item C<gsl_sf_hydrogenicR_e($n, $l, $Z, $r, $result)>

=item C<gsl_sf_hydrogenicR($n, $l, $Z, $r)>

-

=back

=over

=item C<gsl_sf_coulomb_wave_FG_e($eta, $x, $L_F, $k, $F, gsl_sf_result * Fp, gsl_sf_result * G, $Gp)> - This function computes the Coulomb wave functions F_L(\eta,x), G_{L-k}(\eta,x) and their derivatives F'_L(\eta,x), G'_{L-k}(\eta,x) with respect to $x. The parameters are restricted to L, L-k > -1/2, x > 0 and integer $k. Note that L itself is not restricted to being an integer. The results are stored in the parameters $F, $G for the function values and $Fp, $Gp for the derivative values. $F, $G, $Fp, $Gp are all gsl_result structs. If an overflow occurs, $GSL_EOVRFLW is returned and scaling exponents are returned as second and third values. 

=item C<gsl_sf_coulomb_wave_F_array > -

=item C<gsl_sf_coulomb_wave_FG_array> -

=item C<gsl_sf_coulomb_wave_FGp_array> -

=item C<gsl_sf_coulomb_wave_sphF_array> -

=item C<gsl_sf_coulomb_CL_e($L, $eta, $result)> - This function computes the Coulomb wave function normalization constant C_L($eta) for $L > -1. 

=item C<gsl_sf_coulomb_CL_arrayi> - 

=back

=over

=item C<gsl_sf_coupling_3j_e($two_ja, $two_jb, $two_jc, $two_ma, $two_mb, $two_mc, $result)>

=item C<gsl_sf_coupling_3j($two_ja, $two_jb, $two_jc, $two_ma, $two_mb, $two_mc)>

- These routines compute the Wigner 3-j coefficient,
   (ja jb jc
    ma mb mc)
 where the arguments are given in half-integer units, ja = $two_ja/2, ma = $two_ma/2, etc. 

=back

=over

=item C<gsl_sf_coupling_6j_e($two_ja, $two_jb, $two_jc, $two_jd, $two_je, $two_jf, $result)>

=item C<gsl_sf_coupling_6j($two_ja, $two_jb, $two_jc, $two_jd, $two_je, $two_jf)>

- These routines compute the Wigner 6-j coefficient,
   {ja jb jc
    jd je jf}
 where the arguments are given in half-integer units, ja = $two_ja/2, ma = $two_ma/2, etc. 

=back

=over

=item C<gsl_sf_coupling_RacahW_e>

=item C<gsl_sf_coupling_RacahW>

-

=back

=over

=item C<gsl_sf_coupling_9j_e($two_ja, $two_jb, $two_jc, $two_jd, $two_je, $two_jf, $two_jg, $two_jh, $two_ji, $result)>

=item C<gsl_sf_coupling_9j($two_ja, $two_jb, $two_jc, $two_jd, $two_je, $two_jf, $two_jg, $two_jh, $two_ji)>

-These routines compute the Wigner 9-j coefficient,

          {ja jb jc
           jd je jf
           jg jh ji}
 where the arguments are given in half-integer units, ja = two_ja/2, ma = two_ma/2, etc. 

=back

=over

=item C<gsl_sf_dawson_e($x, $result)> 

=item C<gsl_sf_dawson($x)>

-These routines compute the value of Dawson's integral for $x. 

=back

=over

=item C<gsl_sf_debye_1_e($x, $result)>

=item C<gsl_sf_debye_1($x)>

-These routines compute the first-order Debye function D_1(x) = (1/x) \int_0^x dt (t/(e^t - 1)). 

=back

=over

=item C<gsl_sf_debye_2_e($x, $result)>

=item C<gsl_sf_debye_2($x)>

-These routines compute the second-order Debye function D_2(x) = (2/x^2) \int_0^x dt (t^2/(e^t - 1)). 

=back

=over

=item C<gsl_sf_debye_3_e($x, $result)>

=item C<gsl_sf_debye_3($x)>

-These routines compute the third-order Debye function D_3(x) = (3/x^3) \int_0^x dt (t^3/(e^t - 1)). 

=back

=over

=item C<gsl_sf_debye_4_e($x, $result)>

=item C<gsl_sf_debye_4($x)>

-These routines compute the fourth-order Debye function D_4(x) = (4/x^4) \int_0^x dt (t^4/(e^t - 1)). 

=back

=over

=item C<gsl_sf_debye_5_e($x, $result)>

=item C<gsl_sf_debye_5($x)>

-These routines compute the fifth-order Debye function D_5(x) = (5/x^5) \int_0^x dt (t^5/(e^t - 1)). 

=back

=over

=item C<gsl_sf_debye_6_e($x, $result)>

=item C<gsl_sf_debye_6($x)>

-These routines compute the sixth-order Debye function D_6(x) = (6/x^6) \int_0^x dt (t^6/(e^t - 1)). 

=back

=over

=item C<gsl_sf_dilog_e ($x, $result)>

=item C<gsl_sf_dilog($x)>

- These routines compute the dilogarithm for a real argument. In Lewin's notation this is Li_2(x), the real part of the dilogarithm of a real x. It is defined by the integral representation Li_2(x) = - \Re \int_0^x ds \log(1-s) / s. Note that \Im(Li_2(x)) = 0 for x <= 1, and -\pi\log(x) for x > 1. Note that Abramowitz & Stegun refer to the Spence integral S(x)=Li_2(1-x) as the dilogarithm rather than Li_2(x). 

=back

=over

=item C<gsl_sf_complex_dilog_xy_e> -

=item C<gsl_sf_complex_dilog_e($r, $theta, $result_re, $result_im)> - This function computes the full complex-valued dilogarithm for the complex argument z = r \exp(i \theta). The real and imaginary parts of the result are returned in the $result_re and $result_im gsl_result structs. 

=item C<gsl_sf_complex_spence_xy_e> -

=back

=over

=item C<gsl_sf_multiply>

=item C<gsl_sf_multiply_e($x, $y, $result)> - This function multiplies $x and $y storing the product and its associated error in $result. 

=item C<gsl_sf_multiply_err_e($x, $dx, $y, $dy, $result)> - This function multiplies $x and $y with associated absolute errors $dx and $dy. The product xy +/- xy \sqrt((dx/x)^2 +(dy/y)^2) is stored in $result. 

-

=back

=over


=item C<gsl_sf_ellint_Kcomp_e($k, $mode, $result)>

=item C<gsl_sf_ellint_Kcomp($k, $mode)>

-These routines compute the complete elliptic integral K($k) to the accuracy specified by the mode variable mode. Note that Abramowitz & Stegun define this function in terms of the parameter m = k^2. 

=back

=over

=item C<gsl_sf_ellint_Ecomp_e>

=item C<gsl_sf_ellint_Ecomp>

-

=back

=over

=item C<gsl_sf_ellint_Pcomp_e >

=item C<gsl_sf_ellint_Pcomp>

-

=back

=over

=item C<gsl_sf_ellint_Dcomp_e>

=item C<gsl_sf_ellint_Dcomp >

-

=back

=over

=item C<gsl_sf_ellint_F_e>

=item C<gsl_sf_ellint_F>

-

=back

=over

=item C<gsl_sf_ellint_E_e>

=item C<gsl_sf_ellint_E>

-

=back

=over

=item C<gsl_sf_ellint_P_e>

=item C<gsl_sf_ellint_P>

-

=back

=over

=item C<gsl_sf_ellint_D_e>

=item C<gsl_sf_ellint_D>

-

=back

=over

=item C<gsl_sf_ellint_RC_e >

=item C<gsl_sf_ellint_RC>

-

=back

=over

=item C<gsl_sf_ellint_RD_e>

=item C<gsl_sf_ellint_RD >

-

=back

=over

=item C<gsl_sf_ellint_RF_e>

=item C<gsl_sf_ellint_RF>

-

=back

=over

=item C<gsl_sf_ellint_RJ_e >

=item C<gsl_sf_ellint_RJ>

-

=back

=over

=item C<gsl_sf_elljac_e($u, $m)> - This function computes the Jacobian elliptic functions sn(u|m), cn(u|m), dn(u|m) by descending Landen transformations. The function returns 0 if the operation succeded, 1 otherwise and then returns the result of sn, cn and dn in this order.

=item C<gsl_sf_erfc_e >

=item C<gsl_sf_erfc>

-

=back

=over

=item C<gsl_sf_log_erfc_e>

=item C<gsl_sf_log_erfc >

-

=back

=over

=item C<gsl_sf_erf_e>

=item C<gsl_sf_erf>

-

=back

=over

=item C<gsl_sf_erf_Z_e >

=item C<gsl_sf_erf_Z>

-

=back

=over

=item C<gsl_sf_erf_Q_e>

=item C<gsl_sf_erf_Q >

-

=back

=over

=item C<gsl_sf_hazard_e>

=item C<gsl_sf_hazard>

-

=back

=over

=item C<gsl_sf_exp_e >

=item C<gsl_sf_exp>

-

=back

=over

=item C<gsl_sf_exp_e10_e> -

=item C<gsl_sf_exp_mult_e >

=item C<gsl_sf_exp_mult>

-

=back

=over

=item C<gsl_sf_exp_mult_e10_e> - 

=item C<gsl_sf_expm1_e >

=item C<gsl_sf_expm1>

-

=back

=over

=item C<gsl_sf_exprel_e>

=item C<gsl_sf_exprel >

-

=back

=over

=item C<gsl_sf_exprel_2_e>

=item C<gsl_sf_exprel_2>

-

=back

=over

=item C<gsl_sf_exprel_n_e >

=item C<gsl_sf_exprel_n>

-

=back

=over

=item C<gsl_sf_exp_err_e> -

=item C<gsl_sf_exp_err_e10_e > - 

=item C<gsl_sf_exp_mult_err_e> - 

=item C<gsl_sf_exp_mult_err_e10_e> - 

=item C<gsl_sf_expint_E1_e >

=item C<gsl_sf_expint_E1>

-

=back

=over

=item C<gsl_sf_expint_E2_e>

=item C<gsl_sf_expint_E2 >

-

=back

=over

=item C<gsl_sf_expint_En_e>

=item C<gsl_sf_expint_En>

-

=back

=over

=item C<gsl_sf_expint_E1_scaled_e >

=item C<gsl_sf_expint_E1_scaled>

-

=back

=over

=item C<gsl_sf_expint_E2_scaled_e>

=item C<gsl_sf_expint_E2_scaled >

-

=back

=over

=item C<gsl_sf_expint_En_scaled_e>

=item C<gsl_sf_expint_En_scaled>

-

=back

=over

=item C<gsl_sf_expint_Ei_e >

=item C<gsl_sf_expint_Ei>

-

=back

=over

=item C<gsl_sf_expint_Ei_scaled_e>

=item C<gsl_sf_expint_Ei_scaled >

-

=back

=over

=item C<gsl_sf_Shi_e>

=item C<gsl_sf_Shi>

-

=back

=over

=item C<gsl_sf_Chi_e >

=item C<gsl_sf_Chi>

-

=back

=over

=item C<gsl_sf_expint_3_e>

=item C<gsl_sf_expint_3 >

-

=back

=over

=item C<gsl_sf_Si_e>

=item C<gsl_sf_Si>

-

=back

=over

=item C<gsl_sf_Ci_e >

=item C<gsl_sf_Ci>

-

=back

=over

=item C<gsl_sf_fermi_dirac_m1_e>

=item C<gsl_sf_fermi_dirac_m1 >

-

=back

=over

=item C<gsl_sf_fermi_dirac_0_e>

=item C<gsl_sf_fermi_dirac_0>

-

=back

=over

=item C<gsl_sf_fermi_dirac_1_e >

=item C<gsl_sf_fermi_dirac_1>

-

=back

=over

=item C<gsl_sf_fermi_dirac_2_e>

=item C<gsl_sf_fermi_dirac_2 >

-

=back

=over

=item C<gsl_sf_fermi_dirac_int_e>

=item C<gsl_sf_fermi_dirac_int>

-

=back

=over

=item C<gsl_sf_fermi_dirac_mhalf_e >

=item C<gsl_sf_fermi_dirac_mhalf>

-

=back

=over

=item C<gsl_sf_fermi_dirac_half_e>

=item C<gsl_sf_fermi_dirac_half >

-

=back

=over

=item C<gsl_sf_fermi_dirac_3half_e>

=item C<gsl_sf_fermi_dirac_3half>

-

=back

=over

=item C<gsl_sf_fermi_dirac_inc_0_e >

=item C<gsl_sf_fermi_dirac_inc_0>

-

=back

=over

=item C<gsl_sf_legendre_Pl_e>

=item C<gsl_sf_legendre_Pl >

-

=back

=over

=item C<gsl_sf_legendre_Pl_array>

=item C<gsl_sf_legendre_Pl_deriv_array>

-

=back

=over

=item C<gsl_sf_legendre_P1_e >

=item C<gsl_sf_legendre_P2_e>

=item C<gsl_sf_legendre_P3_e>

=item C<gsl_sf_legendre_P1 >

=item C<gsl_sf_legendre_P2>

=item C<gsl_sf_legendre_P3>

-

=back

=over

=item C<gsl_sf_legendre_Q0_e >

=item C<gsl_sf_legendre_Q0>

-

=back

=over

=item C<gsl_sf_legendre_Q1_e>

=item C<gsl_sf_legendre_Q1 >

-

=back

=over

=item C<gsl_sf_legendre_Ql_e>

=item C<gsl_sf_legendre_Ql>

-

=back

=over

=item C<gsl_sf_legendre_Plm_e >

=item C<gsl_sf_legendre_Plm>

-

=back

=over

=item C<gsl_sf_legendre_Plm_array>

=item C<gsl_sf_legendre_Plm_deriv_array >

-

=back

=over

=item C<gsl_sf_legendre_sphPlm_e>

=item C<gsl_sf_legendre_sphPlm>

-

=back

=over

=item C<gsl_sf_legendre_sphPlm_array >

=item C<gsl_sf_legendre_sphPlm_deriv_array>

-

=back

=over

=item C<gsl_sf_legendre_array_size> -

=item C<gsl_sf_lngamma_e >

=item C<gsl_sf_lngamma>

-

=back

=over

=item C<gsl_sf_lngamma_sgn_e>

=item C<gsl_sf_gamma_e >

=item C<gsl_sf_gamma>

=item C<gsl_sf_gammastar_e>

=item C<gsl_sf_gammastar >

=item C<gsl_sf_gammainv_e>

=item C<gsl_sf_gammainv>

=item C<gsl_sf_lngamma_complex_e >

=item C<gsl_sf_gamma_inc_Q_e>

=item C<gsl_sf_gamma_inc_Q>

=item C<gsl_sf_gamma_inc_P_e >

=item C<gsl_sf_gamma_inc_P>

=item C<gsl_sf_gamma_inc_e>

=item C<gsl_sf_gamma_inc >

=item C<gsl_sf_taylorcoeff_e>

=item C<gsl_sf_taylorcoeff>

=item C<gsl_sf_fact_e >

=item C<gsl_sf_fact>

=item C<gsl_sf_doublefact_e>

=item C<gsl_sf_doublefact >

=item C<gsl_sf_lnfact_e>

=item C<gsl_sf_lnfact>

=item C<gsl_sf_lndoublefact_e >

=item C<gsl_sf_lndoublefact>

=item C<gsl_sf_lnchoose_e>

=item C<gsl_sf_lnchoose >

=item C<gsl_sf_choose_e>

=item C<gsl_sf_choose>

=item C<gsl_sf_lnpoch_e >

=item C<gsl_sf_lnpoch>

=item C<gsl_sf_lnpoch_sgn_e>

=item C<gsl_sf_poch_e >

=item C<gsl_sf_poch>

=item C<gsl_sf_pochrel_e>

=item C<gsl_sf_pochrel >

=item C<gsl_sf_lnbeta_e>

=item C<gsl_sf_lnbeta>

=item C<gsl_sf_lnbeta_sgn_e >

=item C<gsl_sf_beta_e>

=item C<gsl_sf_beta>

=item C<gsl_sf_beta_inc_e >

=item C<gsl_sf_beta_inc>

=item C<gsl_sf_gegenpoly_1_e>

=item C<gsl_sf_gegenpoly_2_e >

=item C<gsl_sf_gegenpoly_3_e>

=item C<gsl_sf_gegenpoly_1>

=item C<gsl_sf_gegenpoly_2 >

=item C<gsl_sf_gegenpoly_3>

=item C<gsl_sf_gegenpoly_n_e>

=item C<gsl_sf_gegenpoly_n >

=item C<gsl_sf_gegenpoly_array>

=item C<gsl_sf_hyperg_0F1_e>

=item C<gsl_sf_hyperg_0F1 >

=item C<gsl_sf_hyperg_1F1_int_e>

=item C<gsl_sf_hyperg_1F1_int>

=item C<gsl_sf_hyperg_1F1_e >

=item C<gsl_sf_hyperg_1F1>

=item C<gsl_sf_hyperg_U_int_e>

=item C<gsl_sf_hyperg_U_int >

=item C<gsl_sf_hyperg_U_int_e10_e>

=item C<gsl_sf_hyperg_U_e>

=item C<gsl_sf_hyperg_U >

=item C<gsl_sf_hyperg_U_e10_e>

=item C<gsl_sf_hyperg_2F1_e>

=item C<gsl_sf_hyperg_2F1 >

=item C<gsl_sf_hyperg_2F1_conj_e>

=item C<gsl_sf_hyperg_2F1_conj>

=item C<gsl_sf_hyperg_2F1_renorm_e >

=item C<gsl_sf_hyperg_2F1_renorm>

=item C<gsl_sf_hyperg_2F1_conj_renorm_e>

=item C<gsl_sf_hyperg_2F1_conj_renorm >

=item C<gsl_sf_hyperg_2F0_e>

=item C<gsl_sf_hyperg_2F0>

=item C<gsl_sf_laguerre_1_e >

=item C<gsl_sf_laguerre_2_e>

=item C<gsl_sf_laguerre_3_e>

=item C<gsl_sf_laguerre_1 >

=item C<gsl_sf_laguerre_2>

=item C<gsl_sf_laguerre_3>

=item C<gsl_sf_laguerre_n_e >

=item C<gsl_sf_laguerre_n>

=item C<gsl_sf_lambert_W0_e>

=item C<gsl_sf_lambert_W0 >

=item C<gsl_sf_lambert_Wm1_e>

=item C<gsl_sf_lambert_Wm1>

=item C<gsl_sf_conicalP_half_e >

=item C<gsl_sf_conicalP_half>

=item C<gsl_sf_conicalP_mhalf_e>

=item C<gsl_sf_conicalP_mhalf >

=item C<gsl_sf_conicalP_0_e>

=item C<gsl_sf_conicalP_0>

=item C<gsl_sf_conicalP_1_e >

=item C<gsl_sf_conicalP_1>

=item C<gsl_sf_conicalP_sph_reg_e>

=item C<gsl_sf_conicalP_sph_reg >

=item C<gsl_sf_conicalP_cyl_reg_e>

=item C<gsl_sf_conicalP_cyl_reg>

=item C<gsl_sf_legendre_H3d_0_e >

=item C<gsl_sf_legendre_H3d_0>

=item C<gsl_sf_legendre_H3d_1_e>

=item C<gsl_sf_legendre_H3d_1 >

=item C<gsl_sf_legendre_H3d_e>

=item C<gsl_sf_legendre_H3d>

=item C<gsl_sf_legendre_H3d_array >

=item C<gsl_sf_log_e>

=item C<gsl_sf_log>

=item C<gsl_sf_log_abs_e >

=item C<gsl_sf_log_abs>

=item C<gsl_sf_complex_log_e>

=item C<gsl_sf_log_1plusx_e >

=item C<gsl_sf_log_1plusx>

=item C<gsl_sf_log_1plusx_mx_e>

=item C<gsl_sf_log_1plusx_mx >

=item C<gsl_sf_mathieu_a_array>

=item C<gsl_sf_mathieu_b_array>

=item C<gsl_sf_mathieu_a >

=item C<gsl_sf_mathieu_b>

=item C<gsl_sf_mathieu_a_coeff>

=item C<gsl_sf_mathieu_b_coeff >

=item C<gsl_sf_mathieu_alloc>

=item C<gsl_sf_mathieu_free>

=item C<gsl_sf_mathieu_ce >

=item C<gsl_sf_mathieu_se>

=item C<gsl_sf_mathieu_ce_array>

=item C<gsl_sf_mathieu_se_array >

=item C<gsl_sf_mathieu_Mc>

=item C<gsl_sf_mathieu_Ms>

=item C<gsl_sf_mathieu_Mc_array >

=item C<gsl_sf_mathieu_Ms_array>

=item C<gsl_sf_pow_int_e>

=item C<gsl_sf_pow_int >

=item C<gsl_sf_psi_int_e>

=item C<gsl_sf_psi_int>

=item C<gsl_sf_psi_e >

=item C<gsl_sf_psi>

=item C<gsl_sf_psi_1piy_e>

=item C<gsl_sf_psi_1piy >

=item C<gsl_sf_complex_psi_e gsl_sf_psi_1_int_e>

=item C<gsl_sf_psi_1_int >

=item C<gsl_sf_psi_1_e >

=item C<gsl_sf_psi_1>

=item C<gsl_sf_psi_n_e >

=item C<gsl_sf_psi_n>

=item C<gsl_sf_result_smash_e>

=item C<gsl_sf_synchrotron_1_e >

=item C<gsl_sf_synchrotron_1>

=item C<gsl_sf_synchrotron_2_e>

=item C<gsl_sf_synchrotron_2 >

=item C<gsl_sf_transport_2_e>

=item C<gsl_sf_transport_2>

=item C<gsl_sf_transport_3_e >

=item C<gsl_sf_transport_3>

=item C<gsl_sf_transport_4_e>

=item C<gsl_sf_transport_4 >

=item C<gsl_sf_transport_5_e>

=item C<gsl_sf_transport_5>

=item C<gsl_sf_sin_e >

=item C<gsl_sf_sin>

=item C<gsl_sf_cos_e>

=item C<gsl_sf_cos >

=item C<gsl_sf_hypot_e>

=item C<gsl_sf_hypot>

=item C<gsl_sf_complex_sin_e >

=item C<gsl_sf_complex_cos_e>

=item C<gsl_sf_complex_logsin_e>

=item C<gsl_sf_sinc_e >

=item C<gsl_sf_sinc>

=item C<gsl_sf_lnsinh_e>

=item C<gsl_sf_lnsinh >

=item C<gsl_sf_lncosh_e>

=item C<gsl_sf_lncosh>

=item C<gsl_sf_polar_to_rect >

=item C<gsl_sf_rect_to_polar>

=item C<gsl_sf_sin_err_e>

=item C<gsl_sf_cos_err_e >

=item C<gsl_sf_angle_restrict_symm_e>

=item C<gsl_sf_angle_restrict_symm>

=item C<gsl_sf_angle_restrict_pos_e >

=item C<gsl_sf_angle_restrict_pos>

=item C<gsl_sf_angle_restrict_symm_err_e>

=item C<gsl_sf_angle_restrict_pos_err_e >

=item C<gsl_sf_atanint_e>

=item C<gsl_sf_atanint>

=item C<gsl_sf_zeta_int_e >

=item C<gsl_sf_zeta_int>

=item C<gsl_sf_zeta_e gsl_sf_zeta >

=item C<gsl_sf_zetam1_e>

=item C<gsl_sf_zetam1>

=item C<gsl_sf_zetam1_int_e >

=item C<gsl_sf_zetam1_int>

=item C<gsl_sf_hzeta_e>

=item C<gsl_sf_hzeta >

=item C<gsl_sf_eta_int_e>

=item C<gsl_sf_eta_int>

=item C<gsl_sf_eta_e>

=item C<gsl_sf_eta >

=back

This module also contains the following constants used as mode in various of those functions :

=over

=item * GSL_PREC_DOUBLE - Double-precision, a relative accuracy of approximately 2 * 10^-16.

=item * GSL_PREC_SINGLE - Single-precision, a relative accuracy of approximately 10^-7.

=item * GSL_PREC_APPROX - Approximate values, a relative accuracy of approximately 5 * 10^-4. 

=back

 You can import the functions that you want to use by giving a space separated
 list to Math::GSL::SF when you use the package.  You can also write 
 use Math::GSL::SF qw/:all/ 
 to use all avaible functions of the module. Note that
 the tag names begin with a colon.  Other tags are also available, here is a
 complete list of all tags for this module :

=over

=item C<airy>

=item C<bessel> 

=item C<clausen> 

=item C<hydrogenic>

=item C<coulumb>

=item C<coupling>

=item C<dawson>

=item C<debye>

=item C<dilog>

=item C<factorial>

=item C<misc>

=item C<elliptic>

=item C<error>

=item C<hypergeometric>

=item C<laguerre>

=item C<legendre>

=item C<gamma>

=item C<transport>

=item C<trig>

=item C<zeta>

=item C<eta>

=item C<vars>

=back

For more informations on the functions, we refer you to the GSL offcial
documentation: L<http://www.gnu.org/software/gsl/manual/html_node/>

Tip : search on google: site:http://www.gnu.org/software/gsl/manual/html_node/name_of_the_function_you_want

=head1 EXAMPLES

This example computes the dilogarithm of 1/10 :

    use Math::GSL::SF qw/dilog/;
    my $x = gsl_sf_dilog(0.1);
    print "gsl_sf_dilog(0.1) = $x\n";

An example using Math::GSL::SF and gnuplot is in the B<examples/sf> folder of the source code.

=head1 AUTHORS

Jonathan Leto <jonathan@leto.net> and Thierry Moisan <thierry.moisan@gmail.com>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2008 Jonathan Leto and Thierry Moisan

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut
%}
