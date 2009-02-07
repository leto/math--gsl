// Only include if we have GSL >= 1.12
// This needs to be conditional
#ifdef GSL_VERSION &&  GSL_VERSION == "1.12"
    %include "gsl_inline.h"
#endif




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

%apply double const [] { 
    size_t *p ,double *data, double *dest, double *f_in, double *f_out,
    double data[], const double * src, double x[], double a[], double b[] , 
    const double * x, const double * y, const double * w , const double x_array[],
    const double xrange[], const double yrange[], double * base,
    const double * base, const double xrange[], const double yrange[] ,
    const double * array , const double data2[], const double w[] ,
    float const *A, float const *B, float const *C, float *C, double *v,
    gsl_complex_packed_array data
};

%apply int *OUTPUT { size_t *imin, size_t *imax, size_t *neval };
%apply double * OUTPUT {
    double * min_out, double * max_out, 
    double *abserr, double *result
};
%{
    static HV * Callbacks = (HV*)NULL;
    /* this function returns the value 
        of evaluating the function pointer
        stored in func with argument x
    */
    double callthis(double x , int func, void *params){
        SV ** sv;
        double y;
        dSP;

        //fprintf(stderr, "LOOKUP CALLBACK\n");
        sv = hv_fetch(Callbacks, (char*)func, sizeof(func), FALSE );
        if (sv == (SV**)NULL) {
            fprintf(stderr, "Math::GSL(callthis): %d not in Callbacks!\n", func);
            return;
        }

        PUSHMARK(SP);
        XPUSHs(sv_2mortal(newSVnv((double)x)));
        PUTBACK;
        call_sv(*sv, G_SCALAR);
        y = POPn;
        return y;
    }
%}
%typemap(in) gsl_monte_function * {
    croak("FOOBAR!");
    gsl_monte_function MF;
    int count;
    SV ** callback;
    double x;
    if (!SvROK($input)) {
        croak("Math::GSL : $$1_name is not a reference value!");
    }
    if (Callbacks == (HV*)NULL)
        Callbacks = newHV();
    fprintf(stderr,"STORE gsl_monte_function CALLBACK: %d\n", (int)$input);
    hv_store( Callbacks, (char*)&$input, sizeof($input), newSVsv($input), 0 );

    MF.params   = &$input;
    MF.function = &callthis;
    $1         = &MF;
};
%typemap(in) gsl_function * {
    gsl_function F;
    int count;
    SV ** callback;
    double x;

    if (!SvROK($input)) {
        croak("Math::GSL : $$1_name is not a reference value!");
    }
    if (Callbacks == (HV*)NULL)
        Callbacks = newHV();
    //fprintf(stderr,"STORE CALLBACK: %d\n", (int)$input);
    hv_store( Callbacks, (char*)&$input, sizeof($input), newSVsv($input), 0 );

    F.params   = &$input;
    F.function = &callthis;
    $1         = &F;
};

%typemap(in) gsl_function_fdf * {
    fprintf(stderr, 'FDF_FUNC');    

}

typedef int size_t;
