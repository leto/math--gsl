%module "Math::GSL::ODEIV"
%include "gsl_typemaps.i"
%include "typemaps.i"
%include "renames.i"

 //%newobject gsl_odeiv_step_alloc;
%newobject gsl_odeiv_driver_alloc_y_new;
//%newobject gsl_odeiv_evolve_alloc;

%{
#include "gsl/gsl_types.h"
#include "gsl/gsl_odeiv.h"
#include <stdarg.h>
#define SWIG_MATH_GSL_ODEIV_PACKAGE_NAME "Math::GSL::ODEIV"
#define SWIG_MATH_GSL_ODEIV_GUTS \
  SWIG_MATH_GSL_ODEIV_PACKAGE_NAME "::_guts"

    /* NOTE: We do not use C static variables to store the values since
       static variable are not thread-safe, and SWIG does not currently support the
       MY_CXT framework, see perldoc perlxs for more information.
       Perl package variables are on the other hand thread safe.
    */
    void swig_math_gsl_odeiv_set_gut_pv(
        const char *varname, const char *value
    )
    {
        SV *pvname;
        SV *sv;

        pvname = newSVpvf( "%s::%s", SWIG_MATH_GSL_ODEIV_GUTS, varname);
        /*char *pvname = form( "%s::%s", SWIG_MATH_GSL_ODEIV_GUTS, varname);*/
        sv = get_sv( SvPV_nolen(pvname), GV_ADD );
        SvREFCNT_dec(pvname);
        sv_setpv( sv, value );
    }

    const char *swig_math_gsl_odeiv_get_gut_pv(const char *varname)
    {
        SV *pvname, *sv;

        pvname = newSVpvf( "%s::%s", SWIG_MATH_GSL_ODEIV_GUTS, varname);
        /*char *pvname = form( "%s::%s", SWIG_MATH_GSL_ODEIV_GUTS, varname);*/
        sv = get_sv( SvPV_nolen(pvname), GV_ADD );
        SvREFCNT_dec(pvname);
        return SvPV_nolen(sv);
    }

    void swig_math_gsl_odeiv_set_callback_error_param( const char *func )
    {
        swig_math_gsl_odeiv_set_gut_pv( "cbname", func );
    }

    void swig_math_gsl_odeiv_set_error_param(
         const char *symname, const char *param
    )
    {
        swig_math_gsl_odeiv_set_gut_pv( "symname", symname );
        swig_math_gsl_odeiv_set_gut_pv( "param", param );
    }

    void swig_math_gsl_odeiv_callback_error(
        const char *msg, ...
    )
    {
        const char *cbname;
        va_list args;
        SV *msg2;

        cbname = swig_math_gsl_odeiv_get_gut_pv("cbname");
        va_start(args, msg);
        /*char *msg2 = form(
           "Math::GSL::ODEIV: callback function : %s() : %s", cbname, msg
        );*/
        msg2 = newSVpvf(
           "Math::GSL::ODEIV: callback function : %s() : %s", cbname, msg
        );
        vcroak( SvPV_nolen(msg2), &args );
        /* NOTE: these two lines will never be reached */
        SvREFCNT_dec(msg2);
        va_end(args);
    }

    void swig_math_gsl_odeiv_input_param_error(
        const char *msg, ...
    )
    {
        const char *subname;
        const char *param;
        va_list args;
        SV *msg2;

        subname = swig_math_gsl_odeiv_get_gut_pv("symname");
        param = swig_math_gsl_odeiv_get_gut_pv("param");
        va_start(args, msg);
        msg2 = newSVpvf(
           "Math::GSL::ODEIV:%s() : parameter $%s : %s", subname, param, msg
        );
        vcroak( SvPV_nolen(msg2), &args );
        /* NOTE: these two lines will never be reached */
        SvREFCNT_dec(msg2);
        va_end(args);
    }

    void swig_math_gsl_odeiv_input_error(
        const char *msg, ...
    )
    {
        const char *subname;
        SV *msg2;
        va_list args;

        subname = swig_math_gsl_odeiv_get_gut_pv("symname");
        va_start(args, msg);
        msg2 = newSVpvf( "Math::GSL::ODEIV:%s() : %s", subname, msg);
        vcroak( SvPV_nolen(msg2), &args );
        /* NOTE: these two lines will never be reached */
        SvREFCNT_dec(msg2);
        va_end(args);
    }

    SV *swig_math_gsl_odeiv_get_hash_sv(HV *hash, const char *key)
    {
        SV *key_sv, *value;
        HE *he;

        key_sv = newSVpv(key, strlen (key));
        value;
        if (hv_exists_ent(hash, key_sv, 0)) {
            he = hv_fetch_ent(hash, key_sv, 0, 0);
            value = HeVAL(he);
        }
        else {
            swig_math_gsl_odeiv_input_param_error(
                "The hash key '%s' doesn't exist", key
            );
        }
        return value;
    }

    IV swig_math_gsl_odeiv_get_hash_iv(HV *hash, const char *key) {
        SV *sv;
        sv = swig_math_gsl_odeiv_get_hash_sv(hash, key);
        if (SvROK(sv)) {
            swig_math_gsl_odeiv_input_param_error(
                "Hash value for key '%s' is not a scalar value", key
            );
        }
        if (!SvIOK(sv)) {
            swig_math_gsl_odeiv_input_param_error(
                "Hash value for key '%s' is not an integer", key
            );
        }
        return SvIV(sv);
    }

    SV *swig_math_gsl_odeiv_get_hash_hashref(HV *hash, const char *key) {
        SV *sv;

        sv = swig_math_gsl_odeiv_get_hash_sv(hash, key);
        if (!SvROK(sv)) {
            swig_math_gsl_odeiv_input_param_error(
                "Hash value for key '%s' is not a reference", key
            );
        }
        if (SvTYPE(SvRV(sv)) != SVt_PVHV) {
            swig_math_gsl_odeiv_input_param_error(
               "Hash value for key '%s' is not a hashref", key
            );
        }
        return sv;
    }

    SV *swig_math_gsl_odeiv_get_hash_coderef(HV *hash, const char *key) {
        SV *sv;

        sv = swig_math_gsl_odeiv_get_hash_sv(hash, key);
        if (!SvROK(sv)) {
            swig_math_gsl_odeiv_input_param_error(
                "Hash value for key '%s' is not a reference", key
            );
        }
        if (SvTYPE(SvRV(sv)) != SVt_PVCV) {
            swig_math_gsl_odeiv_input_param_error(
               "Hash value for key '%s' is not a coderef", key
            );
        }
        return sv;
    }

    void swig_math_gsl_odeiv_store_hash_ptr( HV *hash, const char *key, void *ptr)
    {
        SV *sv;

        sv = newSViv(PTR2IV(ptr));
        /* Let the hash take ownership of the sv */
        if( !hv_store(hash, key, strlen(key), sv, 0) ) {
            SvREFCNT_dec(sv);
            swig_math_gsl_odeiv_input_param_error(
                "Cannot store internal information in the hash"
            );
        }
    }

    void *swig_math_gsl_odeiv_get_hash_ptr(HV *hash, const char *key) {
        IV ptr;

        ptr = swig_math_gsl_odeiv_get_hash_iv(hash, key);
        return (void *) INT2PTR(SV*, ptr);
    }

    void swig_math_gsl_odeiv_store_double_in_av( AV *array, SSize_t index, double val)
    {
        SV *sval;

        sval = newSVnv(val);
        if( !av_store(array, index, sval) ) {
            SvREFCNT_dec(sval);
            swig_math_gsl_odeiv_callback_error(
                "Cannot store internal information in array"
            );
        }
    }

    void swig_math_gsl_odeiv_copy_av_to_carray(AV *array, double *y, size_t dim)
    {
        int i;
        SSize_t array_len;
        SV **sv_ptr;
        SV *sv;
        double val;

        array_len = av_len(array) + 1;
        if (array_len != dim ) {
            swig_math_gsl_odeiv_callback_error(
                "Callback returned array of wrong dimension"
            );
        }
        for (i = 0; i < dim; i++) {
            sv_ptr = av_fetch( array, i, 0 );
            if (!sv_ptr) {
                swig_math_gsl_odeiv_callback_error(
                    "Cannot extract values from returned array"
                );
            }
            sv = *sv_ptr;
            if (SvROK(sv)) {
                swig_math_gsl_odeiv_callback_error(
                    "Returned array value is not a scalar"
                );
            }
            /* TODO: Not sure if this check is necessary */
            if (SvTYPE(sv) >= SVt_PVAV) {
                swig_math_gsl_odeiv_callback_error(
                    "Returned array value is not of scalar type"
                );
            }
            val = (double ) SvNV(sv);
            y[i] = val;
        }
    }

    void swig_math_gsl_odeiv_copy_doubles_to_av(AV *array, const double *y, size_t dim)
    {
        int i;
        for (i = 0; i < dim; i++) {
            swig_math_gsl_odeiv_store_double_in_av(array, i, y[i]);
        }
    }

    typedef struct {
        SV *func;
        SV *jac;
        SV *params;
        size_t dim;
        gsl_odeiv_system *sys;
    } swig_math_gsl_odeiv_system;

    int swig_math_gsl_odeiv_call_perl_jac (
        SV *callback, double t, const double y[], double *dfdy, double *dfdt,
        swig_math_gsl_odeiv_system *params
    )
    {
        AV *ay, *a_dfdy, *a_dfdt;
        int count;
        IV result;

        ay = (AV *)sv_2mortal((SV *)newAV());
        a_dfdy = (AV *)sv_2mortal((SV *)newAV());
        a_dfdt = (AV *)sv_2mortal((SV *)newAV());
        dSP;     /* declares a local copy of stack pointer */
        ENTER;
        SAVETMPS;
        PUSHMARK(SP);
        EXTEND(SP, 5);
        PUSHs(sv_2mortal(newSVnv(t)));
        swig_math_gsl_odeiv_copy_doubles_to_av(ay, y, params->dim);
        PUSHs(sv_2mortal((SV *)newRV_inc((SV *) ay)));
        PUSHs(sv_2mortal((SV *)newRV_inc((SV *) a_dfdy)));
        PUSHs(sv_2mortal((SV *)newRV_inc((SV *) a_dfdt)));
        PUSHs(params->params);
        PUTBACK;
        count = call_sv(callback, G_SCALAR);  /* call the Perl callback */
        SPAGAIN;
        if (count != 1) {
            swig_math_gsl_odeiv_callback_error(
                "Bad return value from callback: expected 1 value, got %d", count
            );
        }
        result = POPi;  /* TODO: check ST(0) instead for valid value */
        swig_math_gsl_odeiv_copy_av_to_carray(a_dfdy, dfdy, (params->dim)*(params->dim));
        swig_math_gsl_odeiv_copy_av_to_carray(a_dfdt, dfdt, params->dim);
        PUTBACK;
        FREETMPS;
        LEAVE;
        return (int) result;
    }

    int swig_math_gsl_odeiv_call_perl_func (
        SV *callback, double t, const double y[], double dydt[],
        swig_math_gsl_odeiv_system *params)
    {
        AV *ay, *aj;
        int count;
        IV result;

        ay = (AV *)sv_2mortal((SV *)newAV());
        aj = (AV *)sv_2mortal((SV *)newAV());
        dSP;     /* declares a local copy of stack pointer */
        ENTER;
        SAVETMPS;
        PUSHMARK(SP);
        EXTEND(SP, 4);
        PUSHs(sv_2mortal(newSVnv(t)));
        swig_math_gsl_odeiv_copy_doubles_to_av(ay, y, params->dim);
        PUSHs(sv_2mortal((SV *)newRV_inc((SV *) ay)));
        PUSHs(sv_2mortal((SV *)newRV_inc((SV *) aj)));
        PUSHs(params->params);
        PUTBACK;
        count = call_sv(callback, G_SCALAR);  /* call the Perl callback */
        SPAGAIN;
        /* This should not happen for G_SCALAR, see perldoc perlcall.
         *  Even if the callback does not return anything, count will still be 1
         *  since we are not the G_DISCARD flag
         */
        if (count != 1) {
            swig_math_gsl_odeiv_callback_error(
                "Bad return value from callback: expected 1 value, got %d", count
            );
        }
        result = POPi;  /* TODO: check ST(0) instead for valid value */
        swig_math_gsl_odeiv_copy_av_to_carray(aj, dydt, params->dim);
        PUTBACK;
        FREETMPS;
        LEAVE;
        return result;
    }

    int swig_math_gsl_odeiv_callback_function(
        double t, const double y[], double dydt[], void *params)
    {
        swig_math_gsl_odeiv_set_callback_error_param( "func" );
        swig_math_gsl_odeiv_system *sparam = (swig_math_gsl_odeiv_system *) params;
        return swig_math_gsl_odeiv_call_perl_func(sparam->func, t, y, dydt, sparam);
    }

    int swig_math_gsl_odeiv_callback_jac(
        double t, const double y[], double *dfdy, double *dfdt, void *params
    )
    {
        swig_math_gsl_odeiv_set_callback_error_param( "jac" );
        swig_math_gsl_odeiv_system *sparam = (swig_math_gsl_odeiv_system *) params;
        return swig_math_gsl_odeiv_call_perl_jac(sparam->jac, t, y, dfdy, dfdt, sparam);
    }

    void swig_math_gsl_odeiv_fill_system_struct( HV *hash, gsl_odeiv_system *sys )
    {
        swig_math_gsl_odeiv_system *ssys;
        Newx(ssys, 1, swig_math_gsl_odeiv_system);
        ssys->func = swig_math_gsl_odeiv_get_hash_coderef( hash, "func" );
        ssys->jac = swig_math_gsl_odeiv_get_hash_coderef( hash, "jac" );
        ssys->params = swig_math_gsl_odeiv_get_hash_hashref( hash, "params" );
        ssys->dim = (size_t) swig_math_gsl_odeiv_get_hash_iv( hash, "dim" );
        sys->function = swig_math_gsl_odeiv_callback_function;
        sys->jacobian = swig_math_gsl_odeiv_callback_jac;
        sys->dimension = (size_t) swig_math_gsl_odeiv_get_hash_iv( hash, "dim" );
        sys->params = (void *) ssys;
    }
%}

%typemap(in) const gsl_odeiv_system * {
    SV *sv;
    HV *hash;

    swig_math_gsl_odeiv_set_error_param( "$symname", "$1_name" );

    if (!sv_isobject($input)) {
        swig_math_gsl_odeiv_input_error(
            "Input parameter $$1_name is not a blessed reference!"
        );
    }
    if (!sv_isa($input, "Math::GSL::ODEIV::gsl_odeiv_system")) {
        swig_math_gsl_odeiv_input_error(
            "Input parameter $$1_name is not an object of type "
            "Math::GSL::ODEIV::gsl_odeiv_system!"
        );
    }
    sv = SvRV($input);
    if ((SvTYPE(sv) != SVt_PVHV)) {
        swig_math_gsl_odeiv_input_error(
            "Input parameter $$1_name is not a blessed hash reference!"
        );
    }
    gsl_odeiv_system *sys;
    Newx(sys, 1, gsl_odeiv_system);
    swig_math_gsl_odeiv_fill_system_struct( (HV *)sv, sys);
    $1 = sys;
}

%typemap(freearg) const gsl_odeiv_system * {
    swig_math_gsl_odeiv_system *ssys = (swig_math_gsl_odeiv_system *)$1->params;
    Safefree(ssys);
    Safefree($1);
}

%ignore gsl_odeiv_evolve_apply;
%include "gsl/gsl_types.h"
%include "gsl/gsl_odeiv.h"
// unignore gsl_odeiv_evolve_apply()
%rename("%s") gsl_odeiv_evolve_apply;
/* We want handle the last parameter to gsl_odeiv_evolve_apply(...), see
 * include file gsl/gsl_odeiv.h for a definition. This parameter is of
 * type 'double []' and acts as an input-output array.
 *
 * NOTE: gsl_typemaps.i has typemaps for a float [] input-output array,
 * but note that that typemap also returns the array elements on the perl stack
 * (in addition to modifying the original array).
 * However, here we do not want to return the result on the stack, we only
 * want to modify the original array.
 *
 * TODO: These typemaps might warrant to be moved to gsl_typemaps.i at a later time,
 *   where they could be reused by other interface files, however currently they are
 *   regarded as specific to only gsl_odeiv_evolve_apply().
 */

%typemap(in) double y[] {
    struct perl_array * p_array = 0;  /* see gsl_typemaps.i for definition */
    I32 len;
    AV *array;
    int i;
    SV **tv;
    swig_math_gsl_odeiv_set_error_param( "$symname", "$1_name" );
    if (!SvROK($input)) {
        swig_math_gsl_odeiv_input_error(
            "Input parameter $$1_name is not a reference!"
        );
    }
    if (SvTYPE(SvRV($input)) != SVt_PVAV) {
        swig_math_gsl_odeiv_input_error(
            "Input parameter $$1_name is not an array reference!"
        );
    }
    array = (AV*)SvRV($input);
    len = av_len(array);
    p_array = (struct perl_array *)
        malloc((len+1)*sizeof(double)+sizeof(struct perl_array));
    p_array->len=len;
    p_array->array=array;
    $1 = (double *)&p_array[1];
    for (i = 0; i <= len; i++) {
        tv = av_fetch(array, i, 0);
        $1[i] = (double) SvNV(*tv);
    }
}

%typemap(argout) double y[] {
    struct perl_array * p_array = 0;  /* see gsl_typemaps.i for definition */
    int i;
    double val;
    SV **tv;

    p_array=(struct perl_array *)(((char*)$1)-sizeof(struct perl_array));
    for (i = 0; i <= p_array->len; i++) {
        val = $1[i];
        tv = av_fetch(p_array->array, i, 0);
        sv_setnv(*tv, val);
    }
}

%typemap(freearg) double y[] {
     if ($1) free(((char*)$1)-sizeof(struct perl_array));
}

%{
    typedef struct {
        double h;
        SV *sv;
    } swig_perl_double_in_out;

%}

%typemap(in) double *h {
    SV *sv;
    swig_perl_double_in_out *h_wrap;

    swig_math_gsl_odeiv_set_error_param( "$symname", "$1_name" );
    if (!SvROK($input)) {
        swig_math_gsl_odeiv_input_error(
            "Input parameter $$1_name is not a reference!"
        );
    }
    if (SvTYPE(SvRV($input)) >= SVt_PVAV) {
        swig_math_gsl_odeiv_input_error(
            "Input parameter $$1_name is not a scalar reference!"
        );
    }
    sv = SvRV($input);
    Newx(h_wrap, 1, swig_perl_double_in_out);
    h_wrap->sv = sv;
    h_wrap->h = (double) SvNV(sv);
    $1 = (double *) &h_wrap->h;
}

%typemap(argout) double *h {
    swig_perl_double_in_out *h_wrap;
    SV *sv;

    h_wrap = (swig_perl_double_in_out *) $1;
    sv = h_wrap->sv;
    sv_setnv(sv, h_wrap->h);
}

%typemap(freearg) double *h {
    Safefree( $1 );
}


%typemap(in) double *t = double *h;
%typemap(argout) double *t = double *h;
%typemap(freearg) double *t = double *h;

// define our own name for the last parameter to gsl_odeiv_evolve_apply()
int gsl_odeiv_evolve_apply(gsl_odeiv_evolve *e, gsl_odeiv_control *con, gsl_odeiv_step *step, const gsl_odeiv_system *dydt, double *t, double t1, double *h, double y[]);

%perlcode %{
    package Math::GSL::ODEIV::gsl_odeiv_system;

    sub new {
        my ($class, $func, $jac, $dim, $params ) = @_;

        my $check_ref = sub {
            if ( (ref $_[0]) ne $_[1] ) {
                die sprintf 'Usage: %s:new( $func, $jac, $dim, $params ). '
                . 'Argument %s is not %s reference',
                __PACKAGE__, $_[2], $_[3];
            }
        };
        my $check_subref = sub {
            $check_ref->($_[0], "CODE", $_[1], "code");
        };
        my $check_hashref = sub {
            $check_ref->($_[0], "HASH", $_[1], "hash");
        };
        $check_subref->($func, '$func');
        $check_subref->($jac, '$jac');
        $check_hashref->($params, '$params');
        return bless { func => $func, jac => $jac, dim => $dim, params => $params },
            $class;
    }
%}

%include "../pod/ODEIV.pod"
