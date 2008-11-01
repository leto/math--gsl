%module "Math::GSL::Multifit"

%include "typemaps.i"
%apply double *OUTPUT { double * y, double * y_err, double * chisq,  size_t * rank};

%{
    #include "gsl/gsl_types.h"
    #include "gsl/gsl_multifit.h"
    #include "gsl/gsl_multifit_nlin.h"
%}

%include "gsl/gsl_types.h"
%include "gsl/gsl_multifit.h"
%include "gsl/gsl_multifit_nlin.h"

%perlcode %{
@EXPORT_OK = qw/
               gsl_multifit_linear_alloc 
               gsl_multifit_linear_free 
               gsl_multifit_linear 
               gsl_multifit_linear_svd 
               gsl_multifit_wlinear 
               gsl_multifit_wlinear_svd 
               gsl_multifit_linear_est 
               gsl_multifit_linear_residuals 
               gsl_multifit_gradient 
               gsl_multifit_covar 
               gsl_multifit_fsolver_alloc 
               gsl_multifit_fsolver_free 
               gsl_multifit_fsolver_set 
               gsl_multifit_fsolver_iterate 
               gsl_multifit_fsolver_name 
               gsl_multifit_fsolver_position 
               gsl_multifit_fdfsolver_alloc 
               gsl_multifit_fdfsolver_set 
               gsl_multifit_fdfsolver_iterate 
               gsl_multifit_fdfsolver_free 
               gsl_multifit_fdfsolver_name 
               gsl_multifit_fdfsolver_position 
               gsl_multifit_test_delta 
               gsl_multifit_test_gradient
               $gsl_multifit_fdfsolver_lmder
               $gsl_multifit_fdfsolver_lmsder; 
             /;
%EXPORT_TAGS = ( all => [ @EXPORT_OK ] );

__END__

=head1 NAME

Math::GSL::Multifit - Least-squares functions for a general linear model with multiple parameters

=head1 SYNOPSIS

use Math::GSL::Multifit qw /:all/;

=head1 DESCRIPTION

The functions in this module perform least-squares fits to a general linear model, y = X c where y is a vector of n observations, X is an n by p matrix of predictor variables, and the elements of the vector c are the p unknown best-fit parameters which are to be estimated.

Here is a list of all the functions in this module :

=over 

=item C<gsl_multifit_linear_alloc($n, $p)> - This function allocates a workspace for fitting a model to $n observations using $p parameters. 

=item C<gsl_multifit_linear_free($work)> - This function frees the memory associated with the workspace w. 

=item C<gsl_multifit_linear($X, $y, $c, $cov, $work)> - This function computes the best-fit parameters vector $c of the model y = X c for the observations vector $y and the matrix of predictor variables $X. The variance-covariance matrix of the model parameters vector $cov is estimated from the scatter of the observations about the best-fit. The sum of squares of the residuals from the best-fit, \chi^2, is returned after 0 if the operation succeeded, 1 otherwise. If the coefficient of determination is desired, it can be computed from the expression R^2 = 1 - \chi^2 / TSS, where the total sum of squares (TSS) of the observations y may be computed from gsl_stats_tss. The best-fit is found by singular value decomposition of the matrix $X using the preallocated workspace provided in $work. The modified Golub-Reinsch SVD algorithm is used, with column scaling to improve the accuracy of the singular values. Any components which have zero singular value (to machine precision) are discarded from the fit.

=item C<gsl_multifit_linear_svd($X, $y, $tol, $c, $cov, $work)> - This function computes the best-fit parameters c of the model y = X c for the observations vector $y and the matrix of predictor variables $X. The variance-covariance matrix of the model parameters vector $cov is estimated from the scatter of the observations about the best-fit. The sum of squares of the residuals from the best-fit, \chi^2, is returned after 0 if the operation succeeded, 1 otherwise. If the coefficient of determination is desired, it can be computed from the expression R^2 = 1 - \chi^2 / TSS, where the total sum of squares (TSS) of the observations y may be computed from gsl_stats_tss. In this second form of the function the components are discarded if the ratio of singular values s_i/s_0 falls below the user-specified tolerance $tol, and the effective rank is returned after the sum of squares of the residuals from the best-fit.

=item C<gsl_multifit_wlinear($X, $w, $y, $c, $cov, $work> - This function computes the best-fit parameters vector $c of the weighted model y = X c for the observations y with weights $w and the matrix of predictor variables $X. The covariance matrix of the model parameters $cov is computed with the given weights. The weighted sum of squares of the residuals from the best-fit, \chi^2, is returned after 0 if the operation succeeded, 1 otherwise. If the coefficient of determination is desired, it can be computed from the expression R^2 = 1 - \chi^2 / WTSS, where the weighted total sum of squares (WTSS) of the observations y may be computed from gsl_stats_wtss. The best-fit is found by singular value decomposition of the matrix $X using the preallocated workspace provided in $work. Any components which have zero singular value (to machine precision) are discarded from the fit.

=item C<gsl_multifit_wlinear_svd($X, $w, $y, $tol, $rank, $c, $cov, $work) > This function computes the best-fit parameters vector $c of the weighted model y = X c for the observations y with weights $w and the matrix of predictor variables $X. The covariance matrix of the model parameters $cov is computed with the given weights. The weighted sum of squares of the residuals from the best-fit, \chi^2, is returned after 0 if the operation succeeded, 1 otherwise. If the coefficient of determination is desired, it can be computed from the expression R^2 = 1 - \chi^2 / WTSS, where the weighted total sum of squares (WTSS) of the observations y may be computed from gsl_stats_wtss. The best-fit is found by singular value decomposition of the matrix $X using the preallocated workspace provided in $work. In this second form of the function the components are discarded if the ratio of singular values s_i/s_0 falls below the user-specified tolerance $tol, and the effective rank is returned after the sum of squares of the residuals from the best-fit.. 

=item C<gsl_multifit_linear_est($x, $c, $cov)> - This function uses the best-fit multilinear regression coefficients vector $c and their covariance matrix $cov to compute the fitted function value $y and its standard deviation $y_err for the model y = x.c at the point $x, in the form of a vector. The functions returns 3 values in this order : 0 if the operation succeeded, 1 otherwise, the fittes function value and its standard deviation. 

=item C<gsl_multifit_linear_residuals($X, $y, $c, $r)> - This function computes the vector of residuals r = y - X c for the observations vector $y, coefficients vector $c and matrix of predictor variables $X. $r is also a vector.

=item C<gsl_multifit_gradient($J, $f, $g)> - This function computes the gradient $g of \Phi(x) = (1/2) ||F(x)||^2 from the Jacobian matrix $J and the function values $f, using the formula $g = $J^T $f. $g and $f are vectors.

=item C<gsl_multifit_test_gradient($g, $epsabas)> - This function tests the residual gradient vector $g against the absolute error bound $epsabs. Mathematically, the gradient should be exactly zero at the minimum. The test returns $GSL_SUCCESS if the following condition is achieved, \sum_i |g_i| < $epsabs and returns $GSL_CONTINUE otherwise. This criterion is suitable for situations where the precise location of the minimum, x, is unimportant provided a value can be found where the gradient is small enough. 

=item C<gsl_multifit_test_delta($dx, $x, $epsabs, $epsrel)> - This function tests for the convergence of the sequence by comparing the last step vector $dx with the absolute error $epsabs and relative error $epsrel to the current position x. The test returns $GSL_SUCCESS if the following condition is achieved, |dx_i| < epsabs + epsrel |x_i| for each component of x and returns $GSL_CONTINUE otherwise. 

=back

The following functions are not yet implemented. Patches Welcome! 

=over

=item C<gsl_multifit_covar >

=item C<gsl_multifit_fsolver_alloc($T, $n, $p)>

=item C<gsl_multifit_fsolver_free >

=item C<gsl_multifit_fsolver_set >

=item C<gsl_multifit_fsolver_iterate >

=item C<gsl_multifit_fsolver_name >

=item C<gsl_multifit_fsolver_position >

=item C<gsl_multifit_fdfsolver_alloc >

=item C<gsl_multifit_fdfsolver_set >

=item C<gsl_multifit_fdfsolver_iterate >

=item C<gsl_multifit_fdfsolver_free >

=item C<gsl_multifit_fdfsolver_name >

=item C<gsl_multifit_fdfsolver_position >


=back

For more informations on the functions, we refer you to the GSL offcial
documentation: L<http://www.gnu.org/software/gsl/manual/html_node/>

 Tip : search on google: site:http://www.gnu.org/software/gsl/manual/html_node/ name_of_the_function_you_want

=head1 EXAMPLES



=head1 AUTHORS

Jonathan Leto <jonathan@leto.net> and Thierry Moisan <thierry.moisan@gmail.com>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2008 Jonathan Leto and Thierry Moisan

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

%}
