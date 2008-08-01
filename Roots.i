%module "Math::GSL::Roots"
%{
    #include "gsl/gsl_types.h"
    #include "gsl/gsl_roots.h"
%}
%include "gsl/gsl_types.h"
%include "gsl/gsl_roots.h"


%perlcode %{
@EXPORT_OK = qw/
               gsl_root_fsolver_alloc 
               gsl_root_fsolver_free 
               gsl_root_fsolver_set 
               gsl_root_fsolver_iterate 
               gsl_root_fsolver_name 
               gsl_root_fsolver_root 
               gsl_root_fsolver_x_lower 
               gsl_root_fsolver_x_upper 
               gsl_root_fdfsolver_alloc 
               gsl_root_fdfsolver_set 
               gsl_root_fdfsolver_iterate 
               gsl_root_fdfsolver_free 
               gsl_root_fdfsolver_name 
               gsl_root_fdfsolver_root 
               gsl_root_test_interval 
               gsl_root_test_residual 
               gsl_root_test_delta 
               $gsl_root_fsolver_bisection    
               $gsl_root_fsolver_brent   
               $gsl_root_fsolver_falsepos     
               $gsl_root_fdfsolver_newton     
               $gsl_root_fdfsolver_secant     
               $gsl_root_fdfsolver_steffenson 
             /;
%EXPORT_TAGS = ( all => [ @EXPORT_OK ] );

__END__

=head1 NAME

Math::GSL::Roots - Routines for finding roots of arbitrary one-dimensional functions.

=head1 SYNOPSIS

This module is not yet implemented. Patches Welcome!

use Math::GSL::Roots qw /:all/;

=head1 DESCRIPTION

Here is a list of all the functions in this module :

=over 

=item * C<gsl_root_fsolver_alloc >

=item * C<gsl_root_fsolver_free >

=item * C<gsl_root_fsolver_set >

=item * C<gsl_root_fsolver_iterate >

=item * C<gsl_root_fsolver_name >

=item * C<gsl_root_fsolver_root >

=item * C<gsl_root_fsolver_x_lower >

=item * C<gsl_root_fsolver_x_upper >

=item * C<gsl_root_fdfsolver_alloc >

=item * C<gsl_root_fdfsolver_set >

=item * C<gsl_root_fdfsolver_iterate >

=item * C<gsl_root_fdfsolver_free >

=item * C<gsl_root_fdfsolver_name >

=item * C<gsl_root_fdfsolver_root >

=item * C<gsl_root_test_interval >

=item * C<gsl_root_test_residual >

=item * C<gsl_root_test_delta >

=back

This module also includes the following constants :

=over

=item * C<$gsl_root_fsolver_bisection>

=item * C<$gsl_root_fsolver_brent>

=item * C<$gsl_root_fsolver_falsepos>

=item * C<$gsl_root_fdfsolver_newton>

=item * C<$gsl_root_fdfsolver_secant>

=item * C<$gsl_root_fdfsolver_steffenson>

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
