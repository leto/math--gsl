%module "Math::GSL::SF"
%include "typemaps.i"
%include "gsl_typemaps.i"
%include "renames.i"
%include "system.i"

%apply double *OUTPUT { double * sn, double * cn, double * dn, double * sgn };

%ignore gsl_sf_ellint_D_e;
%ignore gsl_sf_ellint_D;
%ignore gsl_sf_mathieu_a_e;
%ignore gsl_sf_mathieu_a;
%ignore gsl_sf_mathieu_b_e;
%ignore gsl_sf_mathieu_b;
%ignore gsl_sf_mathieu_ce_e;
%ignore gsl_sf_mathieu_ce;
%ignore gsl_sf_mathieu_se_e;
%ignore gsl_sf_mathieu_se;
%ignore gsl_sf_mathieu_Mc_e;
%ignore gsl_sf_mathieu_Mc;
%ignore gsl_sf_mathieu_Ms_e;
%ignore gsl_sf_mathieu_Ms;

// rename wrappers to original

%ignore gsl_sf_bessel_Jn_array;
%rename (gsl_sf_bessel_Jn_array) gsl_sf_bessel_Jn_array_wrapper;
array_wrapper* gsl_sf_bessel_Jn_array_wrapper(int nmin, int nmax, double x);
%ignore gsl_sf_bessel_Yn_array;
%rename (gsl_sf_bessel_Yn_array) gsl_sf_bessel_Yn_array_wrapper;
array_wrapper* gsl_sf_bessel_Yn_array_wrapper(int nmin, int nmax, double x);
%ignore gsl_sf_bessel_In_array;
%rename (gsl_sf_bessel_In_array) gsl_sf_bessel_In_array_wrapper;
array_wrapper* gsl_sf_bessel_In_array_wrapper(int nmin, int nmax, double x);
%ignore gsl_sf_bessel_In_scaled_array;
%rename (gsl_sf_bessel_In_scaled_array) gsl_sf_bessel_In_scaled_array_wrapper;
array_wrapper* gsl_sf_bessel_In_scaled_array_wrapper(int nmin, int nmax, double x);
%ignore gsl_sf_bessel_Kn_array;
%rename (gsl_sf_bessel_Kn_array) gsl_sf_bessel_Kn_array_wrapper;
array_wrapper* gsl_sf_bessel_Kn_array_wrapper(int nmin, int nmax, double x);
%ignore gsl_sf_bessel_Kn_scaled_array;
%rename (gsl_sf_bessel_Kn_scaled_array) gsl_sf_bessel_Kn_scaled_array_wrapper;
array_wrapper* gsl_sf_bessel_Kn_scaled_array_wrapper(int nmin, int nmax, double x);
%ignore gsl_sf_bessel_jl_array;
%rename (gsl_sf_bessel_jl_array) gsl_sf_bessel_jl_array_wrapper;
array_wrapper* gsl_sf_bessel_jl_array_wrapper(int lmax, double x);
%ignore gsl_sf_bessel_jl_steed_array;
%rename (gsl_sf_bessel_jl_steed_array) gsl_sf_bessel_jl_steed_array_wrapper;
array_wrapper* gsl_sf_bessel_jl_steed_array_wrapper(int lmax, double x);
%ignore gsl_sf_bessel_yl_array;
%rename (gsl_sf_bessel_yl_array) gsl_sf_bessel_yl_array_wrapper;
array_wrapper* gsl_sf_bessel_yl_array_wrapper(int lmax, double x);
%ignore gsl_sf_bessel_il_scaled_array;
%rename (gsl_sf_bessel_il_scaled_array) gsl_sf_bessel_il_scaled_array_wrapper;
array_wrapper* gsl_sf_bessel_il_scaled_array_wrapper(int lmax, double x);
%ignore gsl_sf_bessel_kl_scaled_array;
%rename (gsl_sf_bessel_kl_scaled_array) gsl_sf_bessel_kl_scaled_array_wrapper;

%ignore gsl_sf_legendre_Plm_array;
%ignore gsl_sf_legendre_Plm_deriv_array;
%ignore gsl_sf_legendre_array_size;
%ignore gsl_sf_legendre_sphPlm_array;
%ignore gsl_sf_legendre_sphPlm_deriv_array;

%{
    #include "gsl/gsl_types.h"
    #include "gsl/gsl_version.h"
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

    array_wrapper* gsl_sf_bessel_Jn_array_wrapper(int nmin, int nmax, double x) {
        int ret;
        array_wrapper * wrapper = array_wrapper_alloc(nmax - nmin + 1, awDouble);
        ret = gsl_sf_bessel_Jn_array(nmin,nmax,x, (double*)(wrapper->data));
        if (ret != GSL_SUCCESS)
           croak("Math::GSL::SF::gsl_sf_bessel_Jn_array returned %s", gsl_strerror(ret));
        return wrapper;
    }
    array_wrapper* gsl_sf_bessel_Yn_array_wrapper(int nmin, int nmax, double x) {
        int ret;
        array_wrapper * wrapper = array_wrapper_alloc(nmax - nmin + 1, awDouble);
        ret = gsl_sf_bessel_Yn_array(nmin,nmax,x, (double*)(wrapper->data));
        if (ret != GSL_SUCCESS)
           croak("Math::GSL::SF::gsl_sf_bessel_Yn_array returned %s", gsl_strerror(ret));
        return wrapper;
    }
    array_wrapper* gsl_sf_bessel_In_array_wrapper(int nmin, int nmax, double x) {
        int ret;
        array_wrapper * wrapper = array_wrapper_alloc(nmax - nmin + 1, awDouble);
        ret = gsl_sf_bessel_In_array(nmin,nmax,x, (double*)(wrapper->data));
        if (ret != GSL_SUCCESS)
           croak("Math::GSL::SF::gsl_sf_bessel_In_array returned %s", gsl_strerror(ret));
        return wrapper;
    }
    array_wrapper* gsl_sf_bessel_In_scaled_array_wrapper(int nmin, int nmax, double x) {
        int ret;
        array_wrapper * wrapper = array_wrapper_alloc(nmax - nmin + 1, awDouble);
        ret = gsl_sf_bessel_In_scaled_array(nmin,nmax,x, (double*)(wrapper->data));
        if (ret != GSL_SUCCESS)
           croak("Math::GSL::SF::gsl_sf_bessel_In_scaled_array returned %s", gsl_strerror(ret));
        return wrapper;
    }
    array_wrapper* gsl_sf_bessel_Kn_array_wrapper(int nmin, int nmax, double x) {
        int ret;
        array_wrapper * wrapper = array_wrapper_alloc(nmax - nmin + 1, awDouble);
        ret = gsl_sf_bessel_Kn_array(nmin,nmax,x, (double*)(wrapper->data));
        if (ret != GSL_SUCCESS)
           croak("Math::GSL::SF::gsl_sf_bessel_Kn_array returned %s", gsl_strerror(ret));
        return wrapper;
    }
    array_wrapper* gsl_sf_bessel_Kn_scaled_array_wrapper(int nmin, int nmax, double x) {
        int ret;
        array_wrapper * wrapper = array_wrapper_alloc(nmax - nmin + 1, awDouble);
        ret = gsl_sf_bessel_Kn_scaled_array(nmin,nmax,x, (double*)(wrapper->data));
        if (ret != GSL_SUCCESS)
           croak("Math::GSL::SF::gsl_sf_bessel_Kn_scaled_array returned %s", gsl_strerror(ret));
        return wrapper;
    }
    array_wrapper* gsl_sf_bessel_jl_array_wrapper(int lmax, double x) {
        int ret;
        array_wrapper * wrapper = array_wrapper_alloc(lmax + 1, awDouble);
        ret = gsl_sf_bessel_jl_array(lmax,x, (double*)(wrapper->data));
        if (ret != GSL_SUCCESS)
           croak("Math::GSL::SF::gsl_sf_bessel_jl_array returned %s", gsl_strerror(ret));
        return wrapper;
    }
    array_wrapper* gsl_sf_bessel_jl_steed_array_wrapper(int lmax, double x) {
        int ret;
        array_wrapper * wrapper = array_wrapper_alloc(lmax + 1, awDouble);
        ret = gsl_sf_bessel_jl_steed_array(lmax,x, (double*)(wrapper->data));
        if (ret != GSL_SUCCESS)
           croak("Math::GSL::SF::gsl_sf_bessel_jl_steed_array returned %s", gsl_strerror(ret));
        return wrapper;
    }
    array_wrapper* gsl_sf_bessel_yl_array_wrapper(int lmax, double x) {
        int ret;
        array_wrapper * wrapper = array_wrapper_alloc(lmax + 1, awDouble);
        ret = gsl_sf_bessel_yl_array(lmax,x, (double*)(wrapper->data));
        if (ret != GSL_SUCCESS)
           croak("Math::GSL::SF::gsl_sf_bessel_yl_array returned %s", gsl_strerror(ret));
        return wrapper;
    }
    array_wrapper* gsl_sf_bessel_il_scaled_array_wrapper(int lmax, double x) {
        int ret;
        array_wrapper * wrapper = array_wrapper_alloc(lmax + 1, awDouble);
        ret = gsl_sf_bessel_il_scaled_array(lmax,x, (double*)(wrapper->data));
        if (ret != GSL_SUCCESS)
           croak("Math::GSL::SF::gsl_sf_bessel_il_scaled_array returned %s", gsl_strerror(ret));
        return wrapper;
    }
    array_wrapper* gsl_sf_bessel_kl_scaled_array_wrapper(int lmax, double x) {
        int ret;
        array_wrapper * wrapper = array_wrapper_alloc(lmax + 1, awDouble);
        ret = gsl_sf_bessel_kl_scaled_array(lmax,x, (double*)(wrapper->data));
        if (ret != GSL_SUCCESS)
           croak("Math::GSL::SF::gsl_sf_bessel_kl_scaled_array returned %s", gsl_strerror(ret));
        return wrapper;
    }

%}

%inline %{
#if defined GSL_MAJOR_VERSION && (GSL_MAJOR_VERSION < 2)
    /* TOTAL HACKERY TO GET THINGS TO COMPILE on 1.15 and 1.16 */
    typedef enum
    {
    GSL_SF_LEGENDRE_SCHMIDT,
    GSL_SF_LEGENDRE_SPHARM,
    GSL_SF_LEGENDRE_FULL,
    GSL_SF_LEGENDRE_NONE
    } gsl_sf_legendre_t;

#endif
%}

%include "gsl/gsl_types.h"
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

%include "../pod/SF.pod"
