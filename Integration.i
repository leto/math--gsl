%module "Math::GSL::Integration"
%include "typemaps.i"
%include "gsl_typemaps.i"

%{
    #include "gsl/gsl_integration.h"
    #include "gsl/gsl_math.h"
%}
%include "gsl/gsl_integration.h"
%include "gsl/gsl_math.h"

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

    use Math::GSL::Integration qw /:all/;

    my $function = sub { $_[0]**2 } ;
    my ($lower, $upper ) = (0,1);
    my ($relerr,$abserr) = (0,1e-7);

    my ($status, $result, $abserr, $num_evals) = gsl_integration_qng ( $function,
                                                    $lower, $upper, $relerr, $abserr
                                                 );

=head1 DESCRIPTION

This module allows you to numerically integrate a Perl subroutine. Depending
on the properties of your function (singularities, smoothness) and the type
of integration range (finite, infinite, semi-infinite), you will need to 
choose a quadrature routine that fits your needs.


=over 

=item * C<gsl_integration_workspace_alloc($n)> 

This function allocates a workspace sufficient to hold $n double precision
intervals, their integration results and error estimates.

=item * C<gsl_integration_workspace_free($w)> 

 This function frees the memory associated with the workspace $w.

=item * C<gsl_integration_qaws_table_alloc($alpha, $beta, $mu, $nu)> 

 This function allocates space for a gsl_integration_qaws_table struct
 describing a singular weight function W(x) with the parameters ($alpha, $beta,
 $mu, $nu), W(x) = (x-a)^alpha (b-x)^beta log^mu (x-a) log^nu (b-x) where
 $alpha > -1, $beta > -1, and $mu = 0, 1, $nu = 0, 1. The weight function can
 take four different forms depending on the values of $mu and $nu,

              W(x) = (x-a)^alpha (b-x)^beta                   (mu = 0, nu = 0)
              W(x) = (x-a)^alpha (b-x)^beta log(x-a)          (mu = 1, nu = 0)
              W(x) = (x-a)^alpha (b-x)^beta log(b-x)          (mu = 0, nu = 1)
              W(x) = (x-a)^alpha (b-x)^beta log(x-a) log(b-x) (mu = 1, nu = 1)

The singular points (a,b) do not have to be specified until the integral is
computed, where they are the endpoints of the integration range.  The function
returns a pointer to the newly allocated table gsl_integration_qaws_table if no
errors were detected, and 0 in the case of error. 

=item * C<gsl_integration_qaws_table_set($t, $alpha, $beta, $mu, $nu)> 

 This function modifies the parameters ($alpha, $beta, $mu, $nu) of an existing
 gsl_integration_qaws_table struct $t.

=item * C<gsl_integration_qaws_table_free($t)> 

 This function frees all the memory associated with the
 gsl_integration_qaws_table struct $t.

=item * C<gsl_integration_qawo_table_alloc($omega, $L, $sine, $n)>

=item * C<gsl_integration_qawo_table_set($t, $omega, $L, $sine, $n)> 

 This function changes the parameters omega, L and sine of the existing
 workspace $t.

=item * C<gsl_integration_qawo_table_set_length($t, $L)> 

 This function allows the length parameter $L of the workspace $t to be
 changed.

=item * C<gsl_integration_qawo_table_free($t)> 

 This function frees all the memory associated with the workspace $t.

=item * C<gsl_integration_qk15($function,$a,$b,$resabs,$resasc) >

=item * C<gsl_integration_qk21($function,$a,$b,$resabs,$resasc) >

=item * C<gsl_integration_qk31($function,$a,$b,$resabs,$resasc) >

=item * C<gsl_integration_qk41($function,$a,$b,$resabs,$resasc) >

=item * C<gsl_integration_qk51($function,$a,$b,$resabs,$resasc) >

=item * C<gsl_integration_qk61($function,$a,$b,$resabs,$resasc) >

=item * C<gsl_integration_qcheb($function, $a, $b, $cheb12, $cheb24) >

=item * C<gsl_integration_qk >

=item * C<gsl_integration_qng($function,$a,$b,$epsabs,$epsrel,$num_evals) >

This routine QNG (Quadrature Non-Adaptive Gaussian) is inexpensive is the sense
that it will evaluate the function much fewer times than the adaptive routines.
Because of this it does not need any workspaces, so it is also more memory
efficient. It should be perfectly fine for well-behaved functions (smooth and
nonsingular), but will not be able to get the required accuracy or may not
converge for more complicated functions.

=item * C<gsl_integration_qag($function,$a,$b,$epsabs,$epsrel,$limit,$key,$workspace) >

This routine QAG (Quadrature Adaptive Gaussian) ...

=item * C<gsl_integration_qagi($function,$epsabs,$epsrel,$limit,$workspace) >

=item * C<gsl_integration_qagiu($function,$a,$epsabs,$epsrel,$limit,$workspace) >

=item * C<gsl_integration_qagil($function,$b,$epsabs,$epsrel,$limit,$workspace) >

=item * C<gsl_integration_qags($func,$a,$b,$epsabs,$epsrel,$limit,$workspace)>

    ($status, $result, $abserr) = gsl_integration_qags (
                            sub { 1/$_[0]} , 
                            1, 10, 0, 1e-7, 1000,
                            $workspace,
                        );

 This function applies the Gauss-Kronrod 21-point integration rule
 adaptively until an estimate of the integral of $func over ($a,$b) is
 achieved within the desired absolute and relative error limits,
 $epsabs and $epsrel. 


=item * C<gsl_integration_qagp($function, $pts, $npts, $epsbs, $epsrel, $limit, $workspace) >

=item * C<gsl_integration_qawc($function, $a, $b, $c, $epsabs, $epsrel, $limit, $workspace) >

=item * C<gsl_integration_qaws($function, $a, $b, $qaws_table, $epsabs, $epsrel, $limit, $workspace) >

=item * C<gsl_integration_qawo($function, $a, $epsabs, $epsrel, $limit, $workspace, $qawo_table) >

=item * C<gsl_integration_qawf($function, $a, $epsabs, $limit, $workspace, $cycle_workspace, $qawo_table) >

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

The following error constants are part of the Math::GSL::Errno module and can
be returned by the gsl_integration_* functions :

=over

=item * $GSL_EMAXITER 

Maximum number of subdivisions was exceeded.

=item * $GSL_EROUND 

Cannot reach tolerance because of roundoff error, or roundoff error was detected in the extrapolation table. 

=item * GSL_ESING 

A non-integrable singularity or other bad integrand behavior was found in the integration interval.

=item * GSL_EDIVERGE 

The integral is divergent, or too slowly convergent to be integrated numerically. 

=back 
 
=head1 MORE INFO

For more informations on the functions, we refer you to the GSL offcial
documentation: L<http://www.gnu.org/software/gsl/manual/html_node/>

=head1 AUTHORS

Jonathan Leto <jonathan@leto.net> and Thierry Moisan <thierry.moisan@gmail.com>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2008 Jonathan Leto and Thierry Moisan

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

%}
