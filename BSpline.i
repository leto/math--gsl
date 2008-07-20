%module "Math::GSL::BSpline"
%{
    #include "gsl/gsl_bspline.h"
    #include "gsl/gsl_vector.h"
%}

%include "gsl/gsl_bspline.h"
%include "gsl/gsl_vector.h"


%perlcode %{
@EXPORT_OK = qw/
               gsl_bspline_alloc 
               gsl_bspline_free 
               gsl_bspline_ncoeffs 
               gsl_bspline_order 
               gsl_bspline_nbreak 
               gsl_bspline_breakpoint 
               gsl_bspline_knots 
               gsl_bspline_knots_uniform 
               gsl_bspline_eval 
             /;
%EXPORT_TAGS = ( all => [ @EXPORT_OK ] );
%}
