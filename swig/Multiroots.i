%module "Math::GSL::Multiroots"
%include "gsl_typemaps.i"

%typemap(in) gsl_multiroot_function * {
    gsl_multiroot_function *f;
    /* stub */
    $1 = &f;
}

%{
    #include "gsl/gsl_types.h"
    #include "gsl/gsl_multiroots.h"
%}

%include "gsl/gsl_types.h"
%include "gsl/gsl_multiroots.h"

%include "../pod/Multiroots.pod"
