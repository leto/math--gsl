%module "Math::GSL::Statistics"

%include "typemaps.i"
%include "gsl_typemaps.i"

%{
    #include "gsl/gsl_statistics_double.h"
    #include "gsl/gsl_statistics_int.h"
    #include "gsl/gsl_statistics_char.h"
%}

#warning min/max/min_index/max_index to handle at least

%include "gsl/gsl_statistics_double.h"
%include "gsl/gsl_statistics_int.h"
%include "gsl/gsl_statistics_char.h"

%include "../pod/Statistics.pod"
