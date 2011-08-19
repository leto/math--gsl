%module "Math::GSL::Randist"
%include "typemaps.i"
%include "gsl_typemaps.i"
%include "renames.i"

void gsl_ran_dir_2d (const gsl_rng * r, double *OUTPUT, double *OUTPUT);
void gsl_ran_dir_2d_trig_method (const gsl_rng * r, double *OUTPUT, double *OUTPUT);
void gsl_ran_dir_3d (const gsl_rng * r, double *OUTPUT, double *OUTPUT, double *OUTPUT);
void gsl_ran_bivariate_gaussian (const gsl_rng * r, double sigma_x, double sigma_y, double rho, double *OUTPUT, double *OUTPUT);

%typemap(in) void * {
    AV *tempav;
    I32 len;
    int i,x;
    SV  **tv;

    if (!SvROK($input))
        croak("Argument $argnum is not a reference.");
    if (SvTYPE(SvRV($input)) != SVt_PVAV)
        croak("Argument $argnum is not an array.");

    tempav = (AV*)SvRV($input);
    len = av_len(tempav);
    $1 = (int **) malloc((len+2)*sizeof(int *));
    for (i = 0; i <= len; i++) {
        tv = av_fetch(tempav, i, 0);    
        x  = SvIV(*tv);
        memset((int*)($1+i), x , 1);
        //printf("curr = %d\n", (int)($1+i) );
    }
};
%typemap(freearg) void * {
    free($1);
}

/* rename wrappers to original */

%ignore gsl_ran_dirichlet;
%rename (gsl_ran_dirichlet) gsl_ran_dirichlet_wrapper;
array_wrapper * gsl_ran_dirichlet_wrapper(const gsl_rng * r, size_t SIZE, const double ARRAY[]);

%ignore gsl_ran_dirichlet_pdf;
%rename (gsl_ran_dirichlet_pdf) gsl_ran_dirichlet_pdf_wrapper;
double gsl_ran_dirichlet_pdf_wrapper(size_t SIZE, const double ARRAY[], size_t SIZE, const double ARRAY[]);

%ignore gsl_ran_dirichlet_lnpdf;
%rename (gsl_ran_dirichlet_lnpdf) gsl_ran_dirichlet_lnpdf_wrapper;
double gsl_ran_dirichlet_lnpdf_wrapper(size_t SIZE, const double ARRAY[], size_t SIZE, const double ARRAY[]);

%ignore gsl_ran_multinomial;
%rename (gsl_ran_multinomial) gsl_ran_multinomial_wrapper;
array_wrapper * gsl_ran_multinomial_wrapper (const gsl_rng * r, size_t SIZE, const double ARRAY[], unsigned int N);

%ignore gsl_ran_multinomial_pdf;
%rename (gsl_ran_multinomial_pdf) gsl_ran_multinomial_pdf_wrapper;
double gsl_ran_multinomial_pdf_wrapper (size_t SIZE, const unsigned int ARRAY[], size_t SIZE, const double ARRAY[]);

%ignore gsl_ran_multinomial_lnpdf;
%rename (gsl_ran_multinomial_lnpdf) gsl_ran_multinomial_lnpdf_wrapper;
double gsl_ran_multinomial_lnpdf_wrapper (size_t SIZE, const unsigned int ARRAY[], size_t SIZE, const double ARRAY[]);

%ignore gsl_ran_dir_nd;
%rename (gsl_ran_dir_nd) gsl_ran_dir_nd_wrapper;
array_wrapper * gsl_ran_dir_nd_wrapper (const gsl_rng * r, size_t n);

%{
    #include "gsl/gsl_randist.h"

    /* create wrappers for multinormial and dirichlet */
    
    /* void gsl_ran_dirichlet (const gsl_rng * r, size_t K, const double alpha[], double theta[]) */
    array_wrapper * gsl_ran_dirichlet_wrapper(const gsl_rng * r, size_t K, const double alpha[]){
        array_wrapper * wrapper = array_wrapper_alloc(K, awDouble);
        gsl_ran_dirichlet(r, wrapper->size, alpha, (double*)(wrapper->data));
        return wrapper;
    }
    /* double gsl_ran_dirichlet_pdf (size_t K, const double alpha[], const double theta[]) */
    double gsl_ran_dirichlet_pdf_wrapper(size_t K1, const double theta[], size_t K2, const double alpha[]){
        if (K1 != K2)   
            croak("gsl_ran_dirichlet_pdf - arrays need to be same size");
        return gsl_ran_dirichlet_pdf (K1, alpha, theta);
    }
    /* double gsl_ran_dirichlet_lnpdf (size_t K, const double alpha[], const double theta[]) */
    double gsl_ran_dirichlet_lnpdf_wrapper(size_t K1, const double theta[], size_t K2, const double alpha[]){
        if (K1 != K2)   
            croak("gsl_ran_dirichlet_lnpdf - arrays need to be same size");
        return gsl_ran_dirichlet_lnpdf (K1, alpha, theta);
    }

    /* void gsl_ran_multinomial (const gsl_rng * r, size_t K, unsigned int N, const double p[], unsigned int n[]) */
    array_wrapper * gsl_ran_multinomial_wrapper (const gsl_rng * r, size_t K, const double p[], unsigned int N){
        array_wrapper * wrapper = array_wrapper_alloc(K, awUnsigned);
        gsl_ran_multinomial(r, wrapper->size, N, p, (unsigned int*)(wrapper->data));
        return wrapper;
    }
    /* double gsl_ran_multinomial_pdf (size_t K, const double p[], const unsigned int n[]) */
    double gsl_ran_multinomial_pdf_wrapper (size_t K1, const unsigned int n[], size_t K2, const double p[]){
        if (K1 != K2)   
            croak("gsl_ran_multinomial_pdf - arrays need to be same size");
        return gsl_ran_multinomial_pdf (K1, p, n);
    }
    /* double gsl_ran_multinomial_lnpdf (size_t K, const double p[], const unsigned int n[]) */
    double gsl_ran_multinomial_lnpdf_wrapper (size_t K1, const unsigned int n[], size_t K2, const double p[]){
        if (K1 != K2)   
            croak("gsl_ran_multinomial_lnpdf - arrays need to be same size");
        return gsl_ran_multinomial_lnpdf (K1, p, n);
    }

    /* void gsl_ran_dir_nd (const gsl_rng * r, size_t n, double * x) */
    array_wrapper * gsl_ran_dir_nd_wrapper (const gsl_rng * r, size_t n) {
        array_wrapper * wrapper = array_wrapper_alloc(n, awDouble);
        gsl_ran_dir_nd(r, n, (double*)(wrapper->data));
        return wrapper;
    }
    
%}


%include "gsl/gsl_randist.h"
%include "../pod/Randist.pod"


