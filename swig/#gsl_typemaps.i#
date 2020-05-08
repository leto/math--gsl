%include "system.i"
%include "gsl/gsl_nan.h"

#if defined GSL_MAJOR_VERSION
# if GSL_MAJOR_VERSION == 1
#  if defined GSL_MINOR_VERSION && (GSL_MINOR_VERSION >= 12)
    %include "gsl/gsl_inline.h"
#  endif
# elif GSL_MAJOR_VERSION > 1
    %include "gsl/gsl_inline.h"
# endif
#endif

%include "gsl/gsl_errno.h"
%{
    #include "gsl/gsl_nan.h"
    #include "gsl/gsl_errno.h"
    #include "gsl/gsl_math.h"
    #include "gsl/gsl_monte.h"
%}

/*****************************
 * handle 'int const []' as an input array of doubles
 * We allocate the C array at the beginning and free it at the end
 */
%typemap(in) int const [] {
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
    $1 = (int *) malloc((len+2)*sizeof(int));
    for (i = 0; i <= len; i++) {
        tv = av_fetch(tempav, i, 0);
        $1[i] = (int) SvNV(*tv);
    }
}

%typemap(freearg) int const [] {
       if ($1) free($1);
}

%apply int const [] {
    int *v
}

/*****************************
 * handle 'double const []' as an input array of doubles
 * We allocate the C array at the beginning and free it at the end
 */
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
    $1 = (double *) malloc((len+2)*sizeof(double));
    for (i = 0; i <= len; i++) {
        tv = av_fetch(tempav, i, 0);
        $1[i] = (double) SvNV(*tv);
    }
}

%typemap(freearg) double const [] {
       if ($1) free($1);
}

%apply double const [] {
    double *data, double *dest, double *f_in, double *f_out,
    double data[], const double * src, double x[], double a[], double b[],
    const double * x, const double * y, const double * w , const double x_array[],
    const double xrange[], const double yrange[], double * base,
    const double * base, const double xrange[], const double yrange[] ,
    const double * array , const double data2[], const double w[] ,
    double *v, const double alpha[], const double real_coefficient[],
    double complex_coefficient [],
    gsl_complex_packed_array data, const double halfcomplex_coefficient[]
};

/*****************************
 * handle 'float const []' as an input array of floats
 * We allocate the C array at the beginning and free it at the end
 */
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
    $1 = (float *) malloc((len+2)*sizeof(float));
    for (i = 0; i <= len; i++) {
        tv = av_fetch(tempav, i, 0);
        $1[i] = (float)(double) SvNV(*tv);
    }
}

%typemap(freearg) float const [] {
        //if ($1) free($1);
}

%apply float const [] {
    float const *A, float const *B, float const *C, float const *y
};

/*****************************
 * handle 'float []' as an in/out array of floats
 * We allocate the C array at the begining and free it at the end
 * We modify the perl array IN PLACE (not sure other langage can do that
 *   but perl can)
 * Note the trick to store some private info before the C array
 * as swig require that $1 points to the C array (as it uses it
 * when calling the gsl function)
 */
%{
    struct perl_array {
        I32 len;
        AV *array;
    };
%}

%typemap(in) float [] {
    struct perl_array * p_array = 0;
    I32 len;
    AV *array;
    int i;
    SV **tv;
    if (!SvROK($input))
        croak("Math::GSL : $$1_name is not a reference!");
    if (SvTYPE(SvRV($input)) != SVt_PVAV)
        croak("Math::GSL : $$1_name is not an array ref!");

    array = (AV*)SvRV($input);
    len = av_len(array);
    p_array = (struct perl_array *) malloc((len+1)*sizeof(float)+sizeof(struct perl_array));
    p_array->len=len;
    p_array->array=array;
    $1 = (float *)&p_array[1];
    for (i = 0; i <= len; i++) {
        tv = av_fetch(array, i, 0);
        $1[i] = (float)(double) SvNV(*tv);
    }
}

%typemap(argout) float [] {
    struct perl_array * p_array = 0;
    int i;
    SV **tv;
    p_array=(struct perl_array *)(((char*)$1)-sizeof(struct perl_array));
    for (i = 0; i <= p_array->len; i++) {
        double val=(double)(float)($1[i]);
        tv = av_fetch(p_array->array, i, 0);
        sv_setnv(*tv, val);
        if (argvi >= items) {
            EXTEND(sp,1);              /* Extend the stack by 1 object */
        }
        $result = sv_newmortal();
        sv_setnv($result, val);
        argvi++;
    }
}


%typemap(freearg) float [] {
    // if ($1) free(((char*)$1)-sizeof(struct perl_array));
}

%apply float const [] {
    float *C
};

%apply float [] {
    float *C, float *x, float *y,
    float *a, float *b, float *c,
    float *s,
    float *b1, float *b2,
    float *d1, float *d2
};


/*****************************
 * handle 'size_t const []' as an input array of size_t
 * We allocate the C array at the begining and free it at the end
 */
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
    /* Why does this need to be len+2 ? */
    $1 = (size_t *) malloc((len+2)*sizeof(size_t));
    for (i = 0; i <= len; i++) {
        tv = av_fetch(tempav, i, 0);
        $1[i] = (size_t) SvIV(*tv);
    }
}

%typemap(freearg) size_t const [] {
      //  if ($1) free($1);
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
    double result_array[],
    gsl_complex_packed_array data
};

%apply float const [] {
    float const *A, float const *B, float const *C, float *C
};

%apply size_t const [] {
    size_t *p
}

/*****************************
 * handle some parameters as input or output
 */
%apply int *OUTPUT { size_t *imin, size_t *imax, size_t *neval };
%apply double * OUTPUT {
    double * min_out, double * max_out,
    double *abserr, double *result
};

/*****************************
 * array_wrapper
 */

%{

enum awType { awDouble, awFloat, awInt, awUnsigned };

typedef struct {
    I32 size;
    enum awType type;
    void * data;
} array_wrapper;

array_wrapper * array_wrapper_alloc(int numelem, enum awType type){
    array_wrapper * rv =  malloc(sizeof(array_wrapper));

    if (rv == NULL)
        croak("array_wrapper_alloc: can't malloc wrapper\n");

    switch (type){
        case awDouble:
            rv->data = malloc(sizeof(double) * numelem);
            break;
        case awFloat:
            rv->data = malloc(sizeof(float) * numelem);
            break;
        case awInt:
            rv->data = malloc(sizeof(int) * numelem);
            break;
        case awUnsigned:
            rv->data = malloc(sizeof(unsigned int) * numelem);
            break;
        default:
            croak("array_wrapper_alloc: type should be awDouble, awFloat, awInt, or awUnsigned");
    }

    if (rv->data == NULL)
        croak("array_wrapper_alloc: can't malloc data");

    rv->size = numelem;
    rv->type = type;
    return rv;
}

void array_wrapper_free(array_wrapper * daw){
    free(daw->data);
    free(daw);
}
%}

%typemap(out) array_wrapper * {
    SV** tmparr;
    AV* av;
    array_wrapper * wrapper;
    int i;

    double * dptr;
    float * fptr;
    int * iptr;
    unsigned int * uptr;

    wrapper = $1;

    tmparr = malloc(sizeof(SV*) * wrapper->size);
    if (tmparr == NULL)
        croak("out typemap for array_wrapper: couldn't malloc tmparr");

    switch (wrapper->type){
        case awDouble:
            dptr = (double *)wrapper->data;
            for (i=0; i< wrapper->size; i++){
                tmparr[i] = newSVnv(dptr[i]);
            }
            break;
        case awFloat:
            fptr = (float *)wrapper->data;
            for (i=0; i< wrapper->size; i++){
                tmparr[i] = newSVnv((double)fptr[i]);
            }
            break;
        case awInt:
            iptr = (int *)wrapper->data;
            for (i=0; i< wrapper->size; i++){
                tmparr[i] = newSViv(iptr[i]);
            }
            break;
        case awUnsigned:
            uptr = (unsigned int*)wrapper->data;
            for (i=0; i< wrapper->size; i++){
                tmparr[i] = newSVuv(uptr[i]);
            }
            break;
        default:
            croak("out typemap for array_wrapper : type should be awDouble, awFloat, awInt, or awUnsigned");
    }

    av = av_make(wrapper->size, tmparr);
    $result = sv_2mortal(newRV_noinc((SV*) av));
    free(tmparr);
    array_wrapper_free(wrapper);
    argvi++;
}

/*****************************
 * input arrays with lengths
 */
%typemap(arginit) (size_t SIZE, const double ARRAY[]) {
    $2 = 0; /* apparently arrays are not null'd for multi-args? */
}

%typemap(in) (int min, int nmax, double x, double result_array[]) {
    AV* av;
    int i;

    if (!SvROK($input))
        croak("Argument $argnum is not a reference.");
    if (SvTYPE(SvRV($input)) != SVt_PVAV)
        croak("Argument $argnum is not an array.");
    av = (AV*)SvRV($input);
    $1 = av_len(av) + 1;

    $2 = malloc($1 * sizeof(double));
    if ($4 == NULL)
        croak("%%typemap(in) - can't malloc");

    for (i = 0; i < $1; i++) {
        $4[i] = (double) SvNV(* av_fetch(av, i, 0));
    }
}

%typemap(in) (size_t SIZE, const double ARRAY[]) {
    AV* av;
    int i;

    if (!SvROK($input))
        croak("Argument $argnum is not a reference.");
    if (SvTYPE(SvRV($input)) != SVt_PVAV)
        croak("Argument $argnum is not an array.");
    av = (AV*)SvRV($input);
    $1 = av_len(av) + 1;

    $2 = malloc($1 * sizeof(double));
    if ($2 == NULL)
        croak("%%typemap(in) (int , const double []) - can't malloc");

    for (i = 0; i < $1; i++) {
        $2[i] = (double) SvNV(* av_fetch(av, i, 0));
    }
}

%typemap(freearg) (size_t SIZE, const double ARRAY[]) {
    if ($2)
        free($2);
}

%typemap(arginit) (size_t SIZE, const unsigned int ARRAY[]) {
    $2 = NULL;
}

%typemap(in) (size_t SIZE, const unsigned int ARRAY[]) {
    AV* av;
    int i;

    if (!SvROK($input))
        croak("Argument $argnum is not a reference.");
    if (SvTYPE(SvRV($input)) != SVt_PVAV)
        croak("Argument $argnum is not an array.");
    av = (AV*)SvRV($input);
    $1 = av_len(av) + 1;

    $2 = malloc($1 * sizeof(unsigned int));
    if ($2 == NULL)
        croak("%%typemap(in) (int , unsigned int []) - can't malloc");

    for (i = 0; i < $1; i++) {
        $2[i] = (unsigned int) SvUV(* av_fetch(av, i, 0));
    }
}

%typemap(freearg) (size_t SIZE, const unsigned int ARRAY[]) {
    if ($2)
        free($2);
}

/*****************************
 * Callback managment
 */
%{
    /* structure to hold required information while the gsl function call
       for each callback
     */
    struct gsl_function_perl {
        gsl_function C_gsl_function;
        SV * function;
        SV * params;
    };

    struct gsl_function_fdf_perl {
        gsl_function_fdf C_gsl_function_fdf;
        SV * f;
        SV * df;
        SV * fdf;
        SV * params;
    };

    struct gsl_monte_function_perl {
        gsl_monte_function C_gsl_monte_function;
        SV * f;
        SV * dim;
        SV * params;
    };

    void gsl_function_perl_free(struct gsl_function_perl * perl_f){
        if (perl_f != NULL) {
            SvREFCNT_dec(perl_f->function);
            SvREFCNT_dec(perl_f->params);
            Safefree(perl_f);
        }
    }

    void gsl_function_fdf_perl_free(struct gsl_function_fdf_perl * perl_fdf){
        if (perl_fdf != NULL) {
	  SvREFCNT_dec(perl_fdf->f);
	  SvREFCNT_dec(perl_fdf->df);
	  SvREFCNT_dec(perl_fdf->fdf);
	  SvREFCNT_dec(perl_fdf->params);
	  Safefree(perl_fdf);
        }
    }

    /* These functions (C callbacks) calls the perl callbacks.
       Info for perl callback can be found using the 'void*params' parameter
    */
    double call_gsl_function_x_params(SV* function, double x, SV *params){
        unsigned int count;
        double y;
        dSP;

        //fprintf(stderr, "LOOKUP CALLBACK\n");
        ENTER;
        SAVETMPS;

        PUSHMARK(SP);
        XPUSHs(sv_2mortal(newSVnv((double)x)));
        XPUSHs(params);
        PUTBACK;                                /* make local stack pointer global */

        count = call_sv(function, G_SCALAR);
        SPAGAIN;

        if (count != 1)
                croak("Expected to call subroutine in scalar context!");

        y = POPn;

        PUTBACK;                                /* make local stack pointer global */
        FREETMPS;
        LEAVE;

        return y;
    }

    double call_gsl_function(double x , void *params){
        struct gsl_function_perl *F=(struct gsl_function_perl*)params;
	return call_gsl_function_x_params( F->function, x, F->params );
    }

    double call_gsl_function_fdf_f(double x , void *params){
        struct gsl_function_fdf_perl *F=(struct gsl_function_fdf_perl*)params;
	return call_gsl_function_x_params( F->f, x, F->params );
    }

    double call_gsl_function_fdf_df(double x , void *params){
        struct gsl_function_fdf_perl *F=(struct gsl_function_fdf_perl*)params;
	return call_gsl_function_x_params( F->df, x, F->params );
    }

    void call_gsl_function_fdf_fdf(double x , void *params, double *f, double *df ){
        struct gsl_function_fdf_perl *F=(struct gsl_function_fdf_perl*)params;

        dSP;

        ENTER;
        SAVETMPS;

        PUSHMARK(SP);
	EXTEND(SP, 2);
        PUSHs(sv_2mortal(newSVnv((double)x)));
        PUSHs(F->params);
        PUTBACK;                                /* make local stack pointer global */

	{
	  unsigned int count = call_sv(F->fdf, G_ARRAY);
	  SPAGAIN;

	  if (count != 2)
	    croak( "Expected two return values, got %d", count );
	}

	*df = POPn;
        *f = POPn;

        PUTBACK;                                /* make local stack pointer global */
        FREETMPS;
        LEAVE;
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

%typemap(in) gsl_function * {
    SV * function = 0;
    SV * params = 0;
    struct gsl_function_perl *w_gsl_function;
    Newx(w_gsl_function, 1, struct gsl_function_perl);

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

    w_gsl_function->params = params;
    w_gsl_function->function = function;
    w_gsl_function->C_gsl_function.params = w_gsl_function;
    w_gsl_function->C_gsl_function.function = &call_gsl_function;

    $1 = &(w_gsl_function->C_gsl_function);
};

%typemap(freearg) gsl_monte_function * {
    struct gsl_monte_function_perl *p=(struct gsl_monte_function_perl *) $1->params;
    SvREFCNT_dec(p->f);
    SvREFCNT_dec(p->dim);
    SvREFCNT_dec(p->params);
};

%{
  void gsl_function_fdf_extract( char* param_name, HV* hash, SV* func[] ) {
    static const char *keys[3] = { "f", "df", "fdf" };

    int ikey;

    for ( ikey = 0 ; ikey < 3 ; ++ikey ) {
      func[ikey] = 0;
      const char* key = keys[ikey];
      /* it just so happens that strlen(keys[ikey]) == ikey + 1 */
      SV** pp_sv = hv_fetch( hash, key, ikey+1, 0 );
      SV* function;

      if ( !pp_sv )
	croak("Math::GSL : %s: missing key %s!", param_name, key);

      function = *pp_sv;

      if ( SvPOK(function) || ( SvROK( function ) && SvTYPE(SvRV(function)) == SVt_PVCV ) ) {
        /* hold on to SV after the enclosing hash goes away */
        SvREFCNT_inc( function );
	func[ikey] = function;
      }
      else {
	croak( "Math::GSL : %s:  key %s is not a reference to code!", param_name, key);
      }
    }
  }

%}

%typemap(in) gsl_function_fdf * {
    SV* func[3];
    SV * params = 0;

    struct gsl_function_fdf_perl *w_gsl_function_fdf;
    Newx(w_gsl_function_fdf, 1, struct gsl_function_fdf_perl);

    if (SvROK($input) && (SvTYPE(SvRV($input)) == SVt_PVAV)) {
	AV* array=(AV*)SvRV($input);

	if (av_len(array)<0) {
	    croak("Math::GSL : $$1_name is an empty array!");
	}
	if (av_len(array)>1) {
	    croak("Math::GSL : $$1_name is an array with more than 2 elements!");
	}

	{
	  SV** pp_sv = av_fetch(array, 0, 0);
	  if ( ! SvROK( *pp_sv ) || SvTYPE(SvRV(*pp_sv)) != SVt_PVHV )
	    croak("Math::GSL : first element of $$1_name must be a hashref!");

	  gsl_function_fdf_extract( "$$1_name", (HV*) SvRV(*pp_sv), func );
	}

	if (av_len(array)>0) {
	    SV ** p_params = 0;
	    p_params = av_fetch(array, 1, 0);
	    params = *p_params;
	}
    } else if (SvROK($input) && (SvTYPE(SvRV($input)) == SVt_PVHV)) {

	HV* hash = (HV*) SvRV($input );
	gsl_function_fdf_extract( "$$1_name", hash, func );

    } else {
      croak("Math::GSL : $$1_name must be a hashref!");
    }

    if (! params) {
	params=&PL_sv_undef;
    }
    params = newSVsv(params);

    w_gsl_function_fdf->params = params;
    w_gsl_function_fdf->f   = func[0];
    w_gsl_function_fdf->df  = func[1];
    w_gsl_function_fdf->fdf = func[2];


    w_gsl_function_fdf->C_gsl_function_fdf.params = w_gsl_function_fdf;
    w_gsl_function_fdf->C_gsl_function_fdf.f   = &call_gsl_function_fdf_f;
    w_gsl_function_fdf->C_gsl_function_fdf.df  = &call_gsl_function_fdf_df;
    w_gsl_function_fdf->C_gsl_function_fdf.fdf = &call_gsl_function_fdf_fdf;

    $1 = &w_gsl_function_fdf->C_gsl_function_fdf;
};

%typemap(freearg) gsl_function_fdf * {
    struct gsl_function_fdf_perl *p=(struct gsl_function_fdf_perl *) $1->params;
    gsl_function_fdf_perl_free(p);
};

%typemap(freearg) gsl_function * {
    struct gsl_function_perl *p=(struct gsl_function_perl *) $1->params;
    gsl_function_perl_free(p);
};

%typemap(in) (const gsl_qrng * q, double x[]) (void *argp = 0, int res) {
    res = SWIG_ConvertPtr(ST(0), &argp1,SWIGTYPE_p_gsl_qrng, 0 );
    if (!SWIG_IsOK(res)) {
      SWIG_exception_fail(SWIG_ArgError(res), "in method '" "$symname" "', argument " "1"" of type '" "gsl_qrng *""'");
    }
    $1 = (gsl_qrng*) argp;
	$2 = (double*) calloc($1->dimension, sizeof(double));
}

%typemap(argout) (const gsl_qrng * q, double x[])  {
	int ii;
	EXTEND(sp, $1->dimension);

	for (ii = 0; ii < $1->dimension; ++ii) {
		ST(argvi) = sv_newmortal();
		sv_setnv(ST(argvi),(NV) *($2+ii));
		argvi++;
	}
	free($2);
}

