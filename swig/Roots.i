%module "Math::GSL::Roots"
%include "gsl_typemaps.i"
%include "typemaps.i"
%include "renames.i"

%typemap(freearg) gsl_function *;
%newobject gsl_root_fsolver_alloc;
%extend gsl_root_fsolver {
    ~gsl_root_fsolver() {
        struct gsl_function *gsl_f = (struct gsl_function *) $self->function;
        if (gsl_f != NULL) {
            struct gsl_function_perl *perl_f = (struct gsl_function_perl *) $self->function->params;
            gsl_function_perl_free(perl_f);
        }
        gsl_root_fsolver_free($self);
    }
 }

%{
    #include "gsl/gsl_types.h"
    #include "gsl/gsl_roots.h"
%}
%include "gsl/gsl_types.h"
%include "gsl/gsl_roots.h"
%include "../pod/Roots.pod"
