%module ODEIV
%{
#include "/usr/local/include/gsl/gsl_odeiv.h"
%}

%import "/usr/local/include/gsl/gsl_types.h"
%include "/usr/local/include/gsl/gsl_odeiv.h"

%perlcode %{

@EXPORT_OK = qw/ 
                gsl_odeiv_step_alloc gsl_odeiv_step_reset gsl_odeiv_step_free
                gsl_odeiv_step_name gsl_odeiv_step_order gsl_odeiv_step_apply 
                gsl_odeiv_control_alloc gsl_odeiv_control_init gsl_odeiv_control_free 
                gsl_odeiv_control_hadjust gsl_odeiv_control_name gsl_odeiv_control_standard_new 
                gsl_odeiv_control_y_new gsl_odeiv_control_yp_new gsl_odeiv_control_scaled_new 
                gsl_odeiv_evolve_alloc gsl_odeiv_evolve_apply gsl_odeiv_evolve_reset 
                gsl_odeiv_evolve_free 
             /;

%EXPORT_TAGS = ( all => [ @EXPORT_OK ] );

%}
