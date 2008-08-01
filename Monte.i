%module "Math::GSL::Monte"
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


%perlcode %{
@EXPORT_OK = qw/
               gsl_monte_miser_integrate 
               gsl_monte_miser_alloc 
               gsl_monte_miser_init 
               gsl_monte_miser_free 
               gsl_monte_plain_integrate 
               gsl_monte_plain_alloc 
               gsl_monte_plain_init 
               gsl_monte_plain_free 
               gsl_monte_vegas_integrate 
               gsl_monte_vegas_alloc 
               gsl_monte_vegas_init 
               gsl_monte_vegas_free 
               $GSL_VEGAS_MODE_IMPORTANCE 
               $GSL_VEGAS_MODE_IMPORTANCE_ONLY 
               $GSL_VEGAS_MODE_STRATIFIED 
             /;
%EXPORT_TAGS = ( all => [ @EXPORT_OK ] );

__END__

=head1 NAME

Math::GSL::Monte - Routines for multidimensional Monte Carlo integration

=head1 SYNOPSIS

This module is not yet implemented. Patches Welcome!

use Math::GSL::Monte qw /:all/;

=head1 DESCRIPTION

Here is a list of all the functions in this module :

=over 

=item * C<gsl_monte_miser_integrate >

=item * C<gsl_monte_miser_alloc >

=item * C<gsl_monte_miser_init >

=item * C<gsl_monte_miser_free >

=item * C<gsl_monte_plain_integrate >

=item * C<gsl_monte_plain_alloc >

=item * C<gsl_monte_plain_init >

=item * C<gsl_monte_plain_free >

=item * C<gsl_monte_vegas_integrate >

=item * C<gsl_monte_vegas_alloc >

=item * C<gsl_monte_vegas_init >

=item * C<gsl_monte_vegas_free >

=back

This module also includes the following constants :

=over

=item * $GSL_VEGAS_MODE_IMPORTANCE 

=item * $GSL_VEGAS_MODE_IMPORTANCE_ONLY 

=item * $GSL_VEGAS_MODE_STRATIFIED 

=back

For more informations on the functions, we refer you to the GSL offcial
documentation: L<http://www.gnu.org/software/gsl/manual/html_node/>

Tip : search on google: site:http://www.gnu.org/software/gsl/manual/html_node/ name_of_the_function_you_want


=head1 AUTHORS

Jonathan Leto <jonathan@leto.net> and Thierry Moisan <thierry.moisan@gmail.com>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2008 Jonathan Leto and Thierry Moisan

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut


%}
