%module "Math::GSL::ODEIV"
%include "gsl_typemaps.i"
%include "typemaps.i"
%include "renames.i"

%newobject gsl_odeiv_step_alloc;
%newobject gsl_odeiv_driver_alloc_y_new;
%newobject gsl_odeiv_evolve_alloc;

%{
    #include "gsl/gsl_types.h"
    #include "gsl/gsl_odeiv.h"
%}

%include "gsl/gsl_types.h"
%include "gsl/gsl_odeiv.h"
%include "../pod/ODEIV.pod"
