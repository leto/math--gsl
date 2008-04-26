%module Multifit
%{
#include "gsl/gsl_multifit.h"
#include "gsl/gsl_multifit_nlin.h"
%}
%import "gsl/gsl_types.h"
%include "gsl/gsl_multifit.h"
%include "gsl/gsl_multifit_nlin.h"

