%module "Math::GSL::Multimin"

%{
    #include "gsl/gsl_types.h"
    #include "gsl/gsl_multimin.h"
%}

%include "gsl/gsl_types.h"
%include "gsl/gsl_multimin.h"

%perlcode %{

@EXPORT_OK = qw/
	gsl_multimin_fdfminimizer_alloc
	gsl_multimin_fminimizer_alloc
	gsl_multimin_fdfminimizer_set
	gsl_multimin_fdfminimizer_free
	gsl_multimin_fminimizer_free
	gsl_multimin_fdfminimizer_name
	gsl_multimin_fminimizer_name
	gsl_multimin_fdfminimizer_iterate
	gsl_multimin_fminimizer_iterate
	gsl_multimin_fdfminimizer_x
	gsl_multimin_fminimizer_x
	gsl_multimin_fdfminimizer_minimum
	gsl_multimin_fminimizer_minimum
	gsl_multimin_fdfminimizer_gradient
	gsl_multimin_fminimizer_size
	gsl_multimin_fdfminimizer_restart
	gsl_multimin_test_gradient
	gsl_multimin_test_size
	$gsl_multimin_fdfminimizer_conjugate_fr
	$gsl_multimin_fdfminimizer_conjugate_pr
	$gsl_multimin_fdfminimizer_vector_bfgs2
	$gsl_multimin_fdfminimizer_vector_bfgs
	$gsl_multimin_fdfminimizer_steepest_descent
	$gsl_multimin_fminimizer_nmsimplex
/;

%EXPORT_TAGS = ( all => [ @EXPORT_OK ] );

__END__

=head1 NAME

Math::GSL::Multimin - Routines for finding minima of arbitrary multidimensional functions

=head1 SYNOPSIS

This module is not yet implemented. Patches Welcome!

use Math::GSL::Multimin qw /:all/;

=head1 DESCRIPTION

Here is a list of all the functions in this module :

=over

=item * C<gsl_multimin_fdfminimizer_alloc>

=item * C<gsl_multimin_fminimizer_alloc>

=item * C<gsl_multimin_fdfminimizer_set>

=item * C<gsl_multimin_fdfminimizer_free>

=item * C<gsl_multimin_fminimizer_free>

=item * C<gsl_multimin_fdfminimizer_name>

=item * C<gsl_multimin_fminimizer_name>

=item * C<gsl_multimin_fdfminimizer_iterate>

=item * C<gsl_multimin_fminimizer_iterate>

=item * C<gsl_multimin_fdfminimizer_x>

=item * C<gsl_multimin_fminimizer_x>

=item * C<gsl_multimin_fdfminimizer_minimum>

=item * C<gsl_multimin_fminimizer_minimum>

=item * C<gsl_multimin_fdfminimizer_gradient>

=item * C<gsl_multimin_fminimizer_size>

=item * C<gsl_multimin_fdfminimizer_restart>

=item * C<gsl_multimin_test_gradient>

=item * C<gsl_multimin_test_size>

=back

This module also includes the following constants :

=over

=item * C<$gsl_multimin_fdfminimizer_conjugate_fr>

=item * C<$gsl_multimin_fdfminimizer_conjugate_pr>

=item * C<$gsl_multimin_fdfminimizer_vector_bfgs2>

=item * C<$gsl_multimin_fdfminimizer_vector_bfgs>

=item * C<$gsl_multimin_fdfminimizer_steepest_descent>

=item * C<$gsl_multimin_fminimizer_nmsimplex>

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
