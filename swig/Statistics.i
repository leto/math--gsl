%module "Math::GSL::Statistics"

%include "typemaps.i"
%include "gsl_typemaps.i"

%apply double *OUTPUT { double * min, double * max };

%apply int *OUTPUT { size_t * min_index, size_t * max_index };

%{
    #include "gsl/gsl_statistics_double.h"
    #include "gsl/gsl_statistics_int.h"
    #include "gsl/gsl_statistics_char.h"
%}

%include "gsl/gsl_statistics_double.h"
%include "gsl/gsl_statistics_int.h"
%include "gsl/gsl_statistics_char.h"

%include "../pod/Statistics.pod"
