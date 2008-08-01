%module "Math::GSL::Integration"
%{
    #include "gsl/gsl_integration.h"
%}

%include "gsl/gsl_integration.h"

%perlcode %{
@EXPORT_OK = qw/
               gsl_integration_workspace_alloc 
               gsl_integration_workspace_free 
               gsl_integration_qaws_table_alloc 
               gsl_integration_qaws_table_set 
               gsl_integration_qaws_table_free 
               gsl_integration_qawo_table_alloc 
               gsl_integration_qawo_table_set 
               gsl_integration_qawo_table_set_length 
               gsl_integration_qawo_table_free 
               gsl_integration_qk15 
               gsl_integration_qk21 
               gsl_integration_qk31 
               gsl_integration_qk41 
               gsl_integration_qk51 
               gsl_integration_qk61 
               gsl_integration_qcheb 
               gsl_integration_qk 
               gsl_integration_qng 
               gsl_integration_qag 
               gsl_integration_qagi 
               gsl_integration_qagiu 
               gsl_integration_qagil 
               gsl_integration_qags 
               gsl_integration_qagp 
               gsl_integration_qawc 
               gsl_integration_qaws 
               gsl_integration_qawo 
               gsl_integration_qawf 
               $GSL_INTEG_COSINE 
               $GSL_INTEG_SINE 
               $GSL_INTEG_GAUSS15 
               $GSL_INTEG_GAUSS21 
               $GSL_INTEG_GAUSS31 
               $GSL_INTEG_GAUSS41 
               $GSL_INTEG_GAUSS51 
               $GSL_INTEG_GAUSS61 
             /;
%EXPORT_TAGS = ( all => [ @EXPORT_OK ] );

__END__

=head1 NAME

Math::GSL::Integration - Routines for performing numerical integration (quadrature) of a function in one dimension

=head1 SYNOPSIS

This module is not yet implemented. Patches Welcome!

use Math::GSL::Integration qw /:all/;

=head1 DESCRIPTION

Here is a list of all the functions in this module :

=over 

=item * C<gsl_integration_workspace_alloc >

=item * C<gsl_integration_workspace_free >

=item * C<gsl_integration_qaws_table_alloc >

=item * C<gsl_integration_qaws_table_set >

=item * C<gsl_integration_qaws_table_free >

=item * C<gsl_integration_qawo_table_alloc >

=item * C<gsl_integration_qawo_table_set >

=item * C<gsl_integration_qawo_table_set_length >

=item * C<gsl_integration_qawo_table_free >

=item * C<gsl_integration_qk15 >

=item * C<gsl_integration_qk21 >

=item * C<gsl_integration_qk31 >

=item * C<gsl_integration_qk41 >

=item * C<gsl_integration_qk51 >

=item * C<gsl_integration_qk61 >

=item * C<gsl_integration_qcheb >

=item * C<gsl_integration_qk >

=item * C<gsl_integration_qng >

=item * C<gsl_integration_qag >

=item * C<gsl_integration_qagi >

=item * C<gsl_integration_qagiu >

=item * C<gsl_integration_qagil >

=item * C<gsl_integration_qags >

=item * C<gsl_integration_qagp >

=item * C<gsl_integration_qawc >

=item * C<gsl_integration_qaws >

=item * C<gsl_integration_qawo >

=item * C<gsl_integration_qawf >

=back

This module also includes the following constants :

=over

=item * $GSL_INTEG_COSINE 

=item * $GSL_INTEG_SINE 

=item * $GSL_INTEG_GAUSS15 

=item * $GSL_INTEG_GAUSS21 

=item * $GSL_INTEG_GAUSS31 

=item * $GSL_INTEG_GAUSS41 

=item * $GSL_INTEG_GAUSS51 

=item * $GSL_INTEG_GAUSS61 

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
