%module "Math::GSL::Const"
%include "gsl_typemaps.i"

%{
    #include "gsl/gsl_math.h"
    #include "gsl/gsl_const.h"
    #include "gsl/gsl_const_cgs.h"
    #include "gsl/gsl_const_cgsm.h"
    #include "gsl/gsl_const_mks.h"
    #include "gsl/gsl_const_mksa.h"
    #include "gsl/gsl_const_num.h"
%}

%include "gsl/gsl_math.h"
%include "gsl/gsl_const.h"
%include "gsl/gsl_const_cgs.h"
%include "gsl/gsl_const_cgsm.h"
%include "gsl/gsl_const_mks.h"
%include "gsl/gsl_const_mksa.h"
%include "gsl/gsl_const_num.h"
%include "../pod/Const.pod"
