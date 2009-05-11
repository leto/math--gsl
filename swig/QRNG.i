%module "Math::GSL::QRNG"
%include "typemaps.i"
%include "gsl_typemaps.i"

%apply double *OUTPUT { double x[] };

%typemap(argout) double x[] {
    if (argvi >= items) {            
        EXTEND(sp,1);              
    }
    $result = sv_newmortal();
    sv_setnv($result,(NV) *($1));
    argvi++;

    $result = sv_newmortal();
    sv_setnv($result,(NV) *($1+1));
    argvi++;
}

%{
    #include "gsl/gsl_types.h"
    #include "gsl/gsl_qrng.h"
%}

%include "gsl/gsl_types.h"
%include "gsl/gsl_qrng.h"
%include "../pod/QRNG.pod"
