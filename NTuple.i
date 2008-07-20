%module "Math::GSL::NTuple"
%{
    #include "gsl/gsl_ntuple.h"
%}

%include "gsl/gsl_ntuple.h"


%perlcode %{
@EXPORT_OK = qw/
               gsl_ntuple_open 
               gsl_ntuple_create 
               gsl_ntuple_write 
               gsl_ntuple_read 
               gsl_ntuple_bookdata 
               gsl_ntuple_project 
               gsl_ntuple_close 
             /;
%EXPORT_TAGS = ( all => [ @EXPORT_OK ] );
%}
