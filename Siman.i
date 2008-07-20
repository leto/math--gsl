%module "Math::GSL::Siman"
%{
    #include "gsl/gsl_siman.h"
%}

%include "gsl/gsl_siman.h"


%perlcode %{
@EXPORT_OK = qw/
               gsl_siman_solve 
               gsl_siman_solve_many 
             /;
%EXPORT_TAGS = ( all => [ @EXPORT_OK ] );
%}
