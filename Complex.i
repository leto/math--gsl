%module Complex
%{
#include "/usr/local/include/gsl/gsl_complex.h"
#include "/usr/local/include/gsl/gsl_complex_math.h"
%}

%include "/usr/local/include/gsl/gsl_complex.h"
%include "/usr/local/include/gsl/gsl_complex_math.h"


%include "carrays.i"
%array_functions(double, doubleArray);

double gsl_poly_eval(double c[], int len, double x);

/* r= real+i*imag */
gsl_complex gsl_complex_rect (double x, double y); 

/* r= r e^(i theta) */
gsl_complex gsl_complex_polar (double r, double theta); 

