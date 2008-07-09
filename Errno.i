%module "Math::GSL::Errno"
%{
    #include "gsl/gsl_errno.h"
%}

%include "gsl/gsl_errno.h"

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

=head1 NAME

Math::GSL::Errno - Error Handling

=cut

=head1 SYNOPSIS

    use Math::GSL::Errno qw/:all/;
    gsl_set_error_handler_off();

    print gsl_strerror($GSL_EDOM) . "\n";

=head1 STATUS CODES

=over 4

=item * $GSL_SUCCESS

=item * $GSL_FAILURE

=item * $GSL_CONTINUE

=item * $GSL_EDOM

=item * $GSL_ERANGE

=item * $GSL_EFAULT

=item * $GSL_EINVAL

=item * $GSL_EFAILED

=item * $GSL_EFACTOR

=item * $GSL_ESANITY

=item * $GSL_ENOMEM

=item * $GSL_EBADFUNC

=item * $GSL_ERUNAWAY

=item * $GSL_EMAXITER

=item * $GSL_EZERODIV

=item * $GSL_EBADTOL

=item * $GSL_ETOL

=item * $GSL_EUNDRFLW

=item * $GSL_EOVRFLW

=item * $GSL_ELOSS

=item * $GSL_EROUND

=item * $GSL_EBADLEN

=item * $GSL_ENOTSQR

=item * $GSL_ESING

=item * $GSL_EDIVERGE

=item * $GSL_EUNSUP

=item * $GSL_EUNIMPL

=item * $GSL_ECACHE

=item * $GSL_ETABLE

=item * $GSL_ENOPROG

=item * $GSL_ENOPROGJ

=item * $GSL_ETOLF

=item * $GSL_ETOLX 

=item * $GSL_ETOLG

=item * $GSL_EOF 

=back

=cut

%}
