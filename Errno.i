%module Errno
%{
    #include "/usr/local/include/gsl/gsl_errno.h"
%}

%include "/usr/local/include/gsl/gsl_errno.h"

%perlcode %{ 
@EXPORT_OK = qw/
                gsl_error gsl_stream_printf gsl_strerror gsl_set_error_handler 
                gsl_set_error_handler_off gsl_set_stream_handler gsl_set_stream 
                $GSL_SUCCESS $GSL_FAILURE $GSL_CONTINUE $GSL_EDOM 
                $GSL_ERANGE $GSL_EFAULT $GSL_EINVAL $GSL_EFAILED 
                $GSL_EFACTOR $GSL_ESANITY $GSL_ENOMEM $GSL_EBADFUNC 
                $GSL_ERUNAWAY $GSL_EMAXITER $GSL_EZERODIV $GSL_EBADTOL 
                $GSL_ETOL $GSL_EUNDRFLW $GSL_EOVRFLW $GSL_ELOSS 
                $GSL_EROUND $GSL_EBADLEN $GSL_ENOTSQR $GSL_ESING 
                $GSL_EDIVERGE $GSL_EUNSUP $GSL_EUNIMPL $GSL_ECACHE 
                $GSL_ETABLE $GSL_ENOPROG $GSL_ENOPROGJ $GSL_ETOLF 
                $GSL_ETOLX $GSL_ETOLG $GSL_EOF 
            /;
%EXPORT_TAGS = ( all => [ @EXPORT_OK ] );
%}
