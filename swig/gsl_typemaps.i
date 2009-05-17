%include "system.i"
%include "gsl/gsl_nan.h"
#if defined GSL_MINOR_VERSION && (GSL_MINOR_VERSION >= 12)
    %include "gsl/gsl_inline.h"
#endif

typedef int size_t;

%{
    #include "gsl/gsl_nan.h"
    #include "gsl/gsl_math.h"
    #include "gsl/gsl_monte.h"
%}

%typemap(in) double const [] {
    AV *tempav;
    I32 len;
    int i;
    SV **tv;
    if (!SvROK($input))
        croak("Math::GSL : $$1_name is not a reference!");
    if (SvTYPE(SvRV($input)) != SVt_PVAV)
        croak("Math::GSL : $$1_name is not an array ref!");

    tempav = (AV*)SvRV($input);
    len = av_len(tempav);
    $1 = (double *) malloc((len+1)*sizeof(double));
    for (i = 0; i <= len; i++) {
        tv = av_fetch(tempav, i, 0);
        $1[i] = (double) SvNV(*tv);
    }
}

%typemap(freearg) double const [] {
        if ($1) free($1);
}

%typemap(in) float const [] {
    AV *tempav;
    I32 len;
    int i;
    SV **tv;
    if (!SvROK($input))
        croak("Math::GSL : $$1_name is not a reference!");
    if (SvTYPE(SvRV($input)) != SVt_PVAV)
        croak("Math::GSL : $$1_name is not an array ref!");

    tempav = (AV*)SvRV($input);
    len = av_len(tempav);
    $1 = (float *) malloc((len+1)*sizeof(float));
    for (i = 0; i <= len; i++) {
        tv = av_fetch(tempav, i, 0);
        $1[i] = (float)(double) SvNV(*tv);
    }
}

%typemap(freearg) float const [] {
        if ($1) free($1);
}

%typemap(in) size_t const [] {
    AV *tempav;
    I32 len;
    int i;
    SV **tv;
    if (!SvROK($input))
        croak("Math::GSL : $$1_name is not a reference!");
    if (SvTYPE(SvRV($input)) != SVt_PVAV)
        croak("Math::GSL : $$1_name is not an array ref!");

    tempav = (AV*)SvRV($input);
    len = av_len(tempav);
    $1 = (size_t *) malloc((len+1)*sizeof(size_t));
    for (i = 0; i <= len; i++) {
        tv = av_fetch(tempav, i, 0);
        $1[i] = SvIV(*tv);
    }
}

%typemap(freearg) size_t const [] {
        if ($1) free($1);
}

%apply double const [] {
    double *data, double *dest, double *f_in, double *f_out,
    double data[], const double * src, double x[], double a[], double b[],
    double xu[], double xl[],
    const double * x, const double * y, const double * w , const double x_array[],
    const double xrange[], const double yrange[], double * base,
    const double * base, const double xrange[], const double yrange[] ,
    const double * array , const double data2[], const double w[] ,
    double *v,
    gsl_complex_packed_array data
};

%apply float const [] { 
    float const *A, float const *B, float const *C, float *C
};

%apply size_t const [] { 
    size_t *p
}

%apply int *OUTPUT { size_t *imin, size_t *imax, size_t *neval };
%apply double * OUTPUT {
    double * min_out, double * max_out,
    double *abserr, double *result
};
%{

    struct gsl_function_perl {
        gsl_function C_gsl_function;
        SV * function;
        SV * params;
    };
    struct gsl_monte_function_perl {
        gsl_monte_function C_gsl_monte_function;
        SV * f;
        SV * dim;
        SV * params;
    };


    /* this function returns the value 
        of evaluating the function pointer
        stored in func with argument x
    */
    double call_gsl_function(double x , void *params){
        struct gsl_function_perl *F=(struct gsl_function_perl*)params;
        unsigned int count;
        double y;
        dSP;

        //fprintf(stderr, "LOOKUP CALLBACK\n");
        ENTER;
        SAVETMPS;

        PUSHMARK(SP);
        XPUSHs(sv_2mortal(newSVnv((double)x)));
        XPUSHs(F->params);
        PUTBACK;                                /* make local stack pointer global */

        count = call_sv(F->function, G_SCALAR);
        SPAGAIN;

        if (count != 1)
                croak("Expected to call subroutine in scalar context!");

        y = POPn;

        PUTBACK;                                /* make local stack pointer global */
        FREETMPS;
        LEAVE;
         
        return y;
    }
    double call_gsl_monte_function(double *x_array , size_t dim, void *params){
        struct gsl_monte_function_perl *F=(struct gsl_monte_function_perl*)params;
        unsigned int count;
        unsigned int i;
        AV* perl_array;
        double y;
        dSP;

        //fprintf(stderr, "LOOKUP CALLBACK\n");
        ENTER;
        SAVETMPS;

        PUSHMARK(SP);
        perl_array=newAV();
        sv_2mortal((SV*)perl_array);
        XPUSHs(sv_2mortal(newRV((SV *)perl_array)));
        for(i=0; i<dim; i++) {
                /* no mortal : it is referenced by the array */
                av_push(perl_array, newSVnv(x_array[i]));
        }
        XPUSHs(sv_2mortal(newSViv(dim)));
        XPUSHs(F->params);
        PUTBACK;                                /* make local stack pointer global */

        count = call_sv(F->f, G_SCALAR);
        SPAGAIN;

        if (count != 1)
                croak("Expected to call subroutine in scalar context!");

        y = POPn;

        PUTBACK;                                /* make local stack pointer global */
        FREETMPS;
        LEAVE;
         
        return y;
    }
%}

%typemap(in) gsl_monte_function * (struct gsl_monte_function_perl w_gsl_monte_function) {
    SV * f = 0;
    SV * dim = 0;
    SV * params = 0;
    size_t C_dim;

    if (SvROK($input) && (SvTYPE(SvRV($input)) == SVt_PVAV)) {
        AV* array=(AV*)SvRV($input);
        SV ** p_f = 0;
        if (av_len(array)<0) {
            croak("Math::GSL : $$1_name is an empty array!");
        }
        if (av_len(array)>2) {
            croak("Math::GSL : $$1_name is an array with more than 3 elements!");
        }
        p_f = av_fetch(array, 0, 0);
        f = *p_f;
        if (av_len(array)>0) {
            SV ** p_dim = 0;
            p_dim = av_fetch(array, 1, 0);
            dim = *p_dim;
        }
        if (av_len(array)>1) {
            SV ** p_params = 0;
            p_params = av_fetch(array, 1, 0);
            params = *p_params;
        }
    } else {
        f = $input;
    }

    if (!f || !(SvPOK(f) || (SvROK(f) && (SvTYPE(SvRV(f)) == SVt_PVCV)))) {
        croak("Math::GSL : $$1_name is not a reference to code!");
    }

    f = newSVsv(f);

    if (! dim) {
        dim=&PL_sv_undef;
        C_dim=0;
    } else {
        if (!SvIOK(dim)) {
            croak("Math::GSL : $$1_name is not an integer for dim!");
        }
        C_dim=SvIV(dim);
    }
    dim = newSVsv(dim);

    if (! params) {
        params=&PL_sv_undef;
    }
    params = newSVsv(params);
            
    w_gsl_monte_function.f = f;
    w_gsl_monte_function.dim = dim;
    w_gsl_monte_function.params = params;
    w_gsl_monte_function.C_gsl_monte_function.f = &call_gsl_monte_function;
    w_gsl_monte_function.C_gsl_monte_function.dim = C_dim;
    w_gsl_monte_function.C_gsl_monte_function.params   = &w_gsl_monte_function;
    $1         = &w_gsl_monte_function.C_gsl_monte_function;
};

%typemap(in) gsl_function * (struct gsl_function_perl w_gsl_function) {
    SV * function = 0;
    SV * params = 0;

    if (SvROK($input) && (SvTYPE(SvRV($input)) == SVt_PVAV)) {
        AV* array=(AV*)SvRV($input);
        SV ** p_function = 0;
        if (av_len(array)<0) {
            croak("Math::GSL : $$1_name is an empty array!");
        }
        if (av_len(array)>1) {
            croak("Math::GSL : $$1_name is an array with more than 2 elements!");
        }
        p_function = av_fetch(array, 0, 0);
        function = *p_function;
        if (av_len(array)>0) {
            SV ** p_params = 0;
            p_params = av_fetch(array, 1, 0);
            params = *p_params;
        }
    } else {
        function = $input;
    }

    if (!function || !(SvPOK(function) || (SvROK(function) && (SvTYPE(SvRV(function)) == SVt_PVCV)))) {
        croak("Math::GSL : $$1_name is not a reference to code!");
    }

    function = newSVsv(function);

    if (! params) {
        params=&PL_sv_undef;
    }
    params = newSVsv(params);
            
    w_gsl_function.params = params;
    w_gsl_function.function = function;
    w_gsl_function.C_gsl_function.params   = &w_gsl_function;
    w_gsl_function.C_gsl_function.function = &call_gsl_function;
    $1         = &w_gsl_function.C_gsl_function;
};

%typemap(freearg) gsl_monte_function * {
    struct gsl_monte_function_perl *p=(struct gsl_monte_function_perl *) $1->params;
    SvREFCNT_dec(p->f);
    SvREFCNT_dec(p->dim);
    SvREFCNT_dec(p->params);
};

%typemap(freearg) gsl_function * {
    struct gsl_function_perl *p=(struct gsl_function_perl *) $1->params;
    SvREFCNT_dec(p->function);
    SvREFCNT_dec(p->params);
};

%typemap(in) gsl_function_fdf * {
    fprintf(stderr, 'FDF_FUNC');
    return GSL_NAN;
}
