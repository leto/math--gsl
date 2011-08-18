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

%ignore gsl_ran_dirichlet;
%rename (gsl_ran_dirichlet) gsl_ran_dirichlet_wrapper;
array_wrapper * gsl_ran_dirichlet_wrapper(const gsl_rng * r, size_t K, const double alpha[]);

%{
    #include "gsl/gsl_randist.h"
    
    // void gsl_ran_dirichlet (const gsl_rng * r, size_t K, const double alpha[], double theta[])
    array_wrapper * gsl_ran_dirichlet_wrapper(const gsl_rng * r, size_t K, const double alpha[]){
        array_wrapper * wrapper = array_wrapper_alloc(K, awDouble);
        gsl_ran_dirichlet(r, wrapper->size, alpha, (double*)(wrapper->data));
        return wrapper;
    }
    
%}


%include "gsl/gsl_randist.h"
%include "../pod/Randist.pod"


