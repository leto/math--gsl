%module "Math::GSL::ODEIV"
%{
    #include "gsl/gsl_odeiv.h"
%}

%import "gsl/gsl_types.h"
%include "gsl/gsl_odeiv.h"

%perlcode %{
@EXPORT_OK = qw/
               gsl_odeiv_step_alloc 
               gsl_odeiv_step_reset 
               gsl_odeiv_step_free 
               gsl_odeiv_step_name 
               gsl_odeiv_step_order 
               gsl_odeiv_step_apply 
               gsl_odeiv_control_alloc 
               gsl_odeiv_control_init 
               gsl_odeiv_control_free 
               gsl_odeiv_control_hadjust 
               gsl_odeiv_control_name 
               gsl_odeiv_control_standard_new 
               gsl_odeiv_control_y_new 
               gsl_odeiv_control_yp_new 
               gsl_odeiv_control_scaled_new 
               gsl_odeiv_evolve_alloc 
               gsl_odeiv_evolve_apply 
               gsl_odeiv_evolve_reset 
               gsl_odeiv_evolve_free 
               $gsl_odeiv_step_rk2
               $gsl_odeiv_step_rk4
               $gsl_odeiv_step_rkf45
               $gsl_odeiv_step_rkck
               $gsl_odeiv_step_rk8pd
               $gsl_odeiv_step_rk2imp
               $gsl_odeiv_step_rk2simp
               $gsl_odeiv_step_rk4imp
               $gsl_odeiv_step_bsimp
               $gsl_odeiv_step_gear1
               $gsl_odeiv_step_gear2
               GSL_ODEIV_HADJ_INC 
               GSL_ODEIV_HADJ_NIL 
               GSL_ODEIV_HADJ_DEC 
             /;
%EXPORT_TAGS = ( all => [ @EXPORT_OK ] );
%}
