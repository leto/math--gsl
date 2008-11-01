%module "Math::GSL::Diff"
%{
    #include "gsl/gsl_diff.h"
%}

%include "gsl/gsl_diff.h"


%perlcode %{
@EXPORT_OK = qw/
               gsl_diff_central 
               gsl_diff_backward 
               gsl_diff_forward 
             /;
%EXPORT_TAGS = ( all => [ @EXPORT_OK ] );
%}
