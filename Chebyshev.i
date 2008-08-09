%module "Math::GSL::Chebyshev"
%{
    #include "gsl/gsl_chebyshev.h"
%}

%include "gsl/gsl_chebyshev.h"


%perlcode %{
@EXPORT_OK = qw/
               gsl_cheb_alloc 
               gsl_cheb_free 
               gsl_cheb_init 
               gsl_cheb_eval 
               gsl_cheb_eval_err 
               gsl_cheb_eval_n 
               gsl_cheb_eval_n_err 
               gsl_cheb_eval_mode 
               gsl_cheb_eval_mode_e 
               gsl_cheb_calc_deriv 
               gsl_cheb_calc_integ 
             /;
%EXPORT_TAGS = ( all => [ @EXPORT_OK ] );

__END__

=head1 NAME

Math::GSL::Chebyshev - Routines for computing Chebyshev approximations to univariate functions 

=head1 SYNOPSIS

This module is not yet implemented. Patches Welcome!

use Math::GSL::Chebyshev qw /:all/;

=head1 DESCRIPTION

Here is a list of all the functions in this module :

=over

=item * C<gsl_cheb_alloc >

=item * C<gsl_cheb_free >

=item * C<gsl_cheb_init >

=item * C<gsl_cheb_eval >

=item * C<gsl_cheb_eval_err >

=item * C<gsl_cheb_eval_n >

=item * C<gsl_cheb_eval_n_err >

=item * C<gsl_cheb_eval_mode >

=item * C<gsl_cheb_eval_mode_e >

=item * C<gsl_cheb_calc_deriv >

=item * C<gsl_cheb_calc_integ >

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
