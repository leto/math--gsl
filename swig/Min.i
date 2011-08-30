%module "Math::GSL::Min"
%include "typemaps.i"
%include "gsl_typemaps.i"
%include "renames.i"

%typemap(freearg) gsl_function *;
%newobject gsl_min_fminimizer_alloc;
%extend gsl_min_fminimizer {
    ~gsl_min_fminimizer() {
        struct gsl_function *gsl_f = (struct gsl_function *) $self->function;
        if (gsl_f != NULL) {
            struct gsl_function_perl *perl_f = (struct gsl_function_perl *) $self->function->params;
            gsl_function_perl_free(perl_f);
        }
        gsl_min_fminimizer_free($self);
    }
}


%{
    #include "gsl/gsl_types.h"
    #include "gsl/gsl_min.h"
    #include "gsl/gsl_math.h"
%}
%include "gsl/gsl_types.h"
%include "gsl/gsl_min.h"
%include "gsl/gsl_math.h"
%include "../pod/Min.pod"
