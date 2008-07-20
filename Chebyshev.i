%module "Math::GSL::Chebyshev"
%{
    #include "gsl/gsl_chebyshev.h"
%}

%include "gsl/gsl_chebyshev.h"


%perlcode %{
@EXPORT_OK = qw/
               gsl_cheb_alloc 
               gsl_cheb_free 
               gsl_cheb_init 
               gsl_cheb_eval 
               gsl_cheb_eval_err 
               gsl_cheb_eval_n 
               gsl_cheb_eval_n_err 
               gsl_cheb_eval_mode 
               gsl_cheb_eval_mode_e 
               gsl_cheb_calc_deriv 
               gsl_cheb_calc_integ 
             /;
%EXPORT_TAGS = ( all => [ @EXPORT_OK ] );
%}
