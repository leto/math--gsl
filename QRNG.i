%module QRNG
%{
    #include "/usr/local/include/gsl/gsl_types.h"
    #include "/usr/local/include/gsl/gsl_qrng.h"
%}

%include "/usr/local/include/gsl/gsl_types.h"
%include "/usr/local/include/gsl/gsl_qrng.h"

%perlcode %{

@EXPORT_OK = qw($gsl_qrng_niederreiter_2 $gsl_qrng_sobol $gsl_qrng_halton $gsl_qrng_reversehalton
                gsl_qrng_alloc gsl_qrng_memcpy gsl_qrng_clone
                gsl_qrng_free  gsl_qrng_init gsl_qrng_name 
                gsl_qrng_size gsl_qrng_state gsl_qrng_get
            );
%EXPORT_TAGS = ( all => [ @EXPORT_OK ] );


__END__

=head1 NAME

Math::GSL::QRNG

=head1 SYPNOPSIS

use Math::GSL::QRNG qw/:all/;

=head1 DESCRIPTION
Here is a list of all the functions included in this module :

gsl_qrng_alloc gsl_qrng_memcpy gsl_qrng_clone
gsl_qrng_free  gsl_qrng_init gsl_qrng_name 
gsl_qrng_size gsl_qrng_state gsl_qrng_get

This module also contains the following constants : 
$gsl_qrng_niederreiter_2 
$gsl_qrng_sobol 
$gsl_qrng_halton 
$gsl_qrng_reversehalton

For more informations on the functions, we refer you to the GSL offcial documentation: http://www.gnu.org/software/gsl/manual/html_node/
Tip : search on google: site:http://www.gnu.org/software/gsl/manual/html_node/ name_of_the_function_you_want

=head1 EXAMPLES

=head1 AUTHOR

Jonathan Leto <jonathan@leto.net> and Thierry Moisan <thierry.moisan@gmail.com>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2008 Jonathan Leto and Thierry Moisan

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut
%}
