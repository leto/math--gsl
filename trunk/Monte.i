%module gsl_monte
%{
#include "gsl/gsl_monte.h"
#include "gsl/gsl_monte_miser.h"
#include "gsl/gsl_monte_plain.h"
#include "gsl/gsl_monte_vegas.h"
%}

%include "gsl/gsl_monte.h"
%include "gsl/gsl_monte_miser.h"
%include "gsl/gsl_monte_plain.h"
%include "gsl/gsl_monte_vegas.h"

