%module "Math::GSL::Integration"
%{
    #include "gsl/gsl_integration.h"
%}

%include "gsl/gsl_integration.h"

%perlcode %{
@EXPORT_OK = qw/
               gsl_integration_workspace_alloc 
               gsl_integration_workspace_free 
               gsl_integration_qaws_table_alloc 
               gsl_integration_qaws_table_set 
               gsl_integration_qaws_table_free 
               gsl_integration_qawo_table_alloc 
               gsl_integration_qawo_table_set 
               gsl_integration_qawo_table_set_length 
               gsl_integration_qawo_table_free 
               gsl_integration_qk15 
               gsl_integration_qk21 
               gsl_integration_qk31 
               gsl_integration_qk41 
               gsl_integration_qk51 
               gsl_integration_qk61 
               gsl_integration_qcheb 
               gsl_integration_qk 
               gsl_integration_qng 
               gsl_integration_qag 
               gsl_integration_qagi 
               gsl_integration_qagiu 
               gsl_integration_qagil 
               gsl_integration_qags 
               gsl_integration_qagp 
               gsl_integration_qawc 
               gsl_integration_qaws 
               gsl_integration_qawo 
               gsl_integration_qawf 
               $GSL_INTEG_COSINE 
               $GSL_INTEG_SINE 
               $GSL_INTEG_GAUSS15 
               $GSL_INTEG_GAUSS21 
               $GSL_INTEG_GAUSS31 
               $GSL_INTEG_GAUSS41 
               $GSL_INTEG_GAUSS51 
               $GSL_INTEG_GAUSS61 
             /;
%EXPORT_TAGS = ( all => [ @EXPORT_OK ] );
%}
