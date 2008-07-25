%module "Math::GSL::Fit"

%include "typemaps.i"
%include "gsl_typemaps.i"

%apply double *OUTPUT { double * c0, double * c1, double * cov00, double * cov01, double * cov11, double * sumsq, double * chisq };

%{
#include "gsl/gsl_fit.h"
%}

%include "gsl/gsl_fit.h"


%perlcode %{
@EXPORT_OK = qw/
               gsl_fit_linear 
               gsl_fit_wlinear 
               gsl_fit_linear_est 
               gsl_fit_mul 
               gsl_fit_wmul 
               gsl_fit_mul_est 
             /;
%EXPORT_TAGS = ( all => [ @EXPORT_OK ] );

__END__

=head1 NAME

Math::GSL::Fit - Least-squares functions for a general linear model with one- or two-parameter regression

=head1 SYNOPSIS

use Math::GSL::Fit qw /:all/;

=head1 DESCRIPTION

The functions in this module perform least-squares fits to a general linear model, y = X c where y is a vector of n observations, X is an n by p matrix of predictor variables, and the elements of the vector c are the p unknown best-fit parameters which are to be estimated.

Here is a list of all the functions in this module :

=over 

=item C<gsl_fit_linear($x, $xstride, $y, $ystride, $n)> - This function computes the best-fit linear regression coefficients (c0,c1) of the model Y = c_0 + c_1 X for the dataset ($x, $y), two vectors (in form of arrays) of length $n with strides $xstride and $ystride. The errors on y are assumed unknown so the variance-covariance matrix for the parameters (c0, c1) is estimated from the scatter of the points around the best-fit line and returned via the parameters (cov00, cov01, cov11). The sum of squares of the residuals from the best-fit line is returned in sumsq. Note: the correlation coefficient of the data can be computed using gsl_stats_correlation (see Correlation), it does not depend on the fit. The function returns the following values in this order : 0 if the operation succeeded, 1 otherwise, c0, c1, cov00, cov01, cov11 and sumsq.

=item C<gsl_fit_wlinear($x, $xstride, $w, $wstride, $y, $ystride, $n)> - This function computes the best-fit linear regression coefficients (c0,c1) of the model Y = c_0 + c_1 X for the weighted dataset ($x, $y), two vectors (in form of arrays) of length $n with strides $xstride and $ystride. The vector (also in the form of an array) $w, of length $n and stride $wstride, specifies the weight of each datapoint. The weight is the reciprocal of the variance for each datapoint in y. The covariance matrix for the parameters (c0, c1) is computed using the weights and returned via the parameters (cov00, cov01, cov11). The weighted sum of squares of the residuals from the best-fit line, \chi^2, is returned in chisq. The function returns the following values in this order : 0 if the operation succeeded, 1 otherwise, c0, c1, cov00, cov01, cov11 and sumsq.

=item C<gsl_fit_linear_est($x, $c0, $c1, $cov00, $cov01, $cov11)> - This function uses the best-fit linear regression coefficients $c0, $c1 and their covariance $cov00, $cov01, $cov11 to compute the fitted function y and its standard deviation y_err for the model Y = c_0 + c_1 X at the point $x. The function returns the following values in this order : 0 if the operation succeeded, 1 otherwise, y and y_err.

=item C<gsl_fit_mul($x, $xstride, $y, $ystride, $n)> - This function computes the best-fit linear regression coefficient c1 of the model Y = c_1 X for the datasets ($x, $y), two vectors (in form of arrays) of length $n with strides $xstride and $ystride. The errors on y are assumed unknown so the variance of the parameter c1 is estimated from the scatter of the points around the best-fit line and returned via the parameter cov11. The sum of squares of the residuals from the best-fit line is returned in sumsq. The function returns the following values in this order : 0 if the operation succeeded, 1 otherwise, c1, cov11 and sumsq.

=item C<gsl_fit_wmul($x, $xstride, $w, $wstride, $y, $ystride, $n)> - This function computes the best-fit linear regression coefficient c1 of the model Y = c_1 X for the weighted datasets ($x, $y), two vectors (in form of arrays) of length $n with strides $xstride and $ystride. The vector (also in the form of an array) $w, of length $n and stride $wstride, specifies the weight of each datapoint. The weight is the reciprocal of the variance for each datapoint in y. The variance of the parameter c1 is computed using the weights and returned via the parameter cov11. The weighted sum of squares of the residuals from the best-fit line, \chi^2, is returned in chisq. The function returns the following values in this order : 0 if the operation succeeded, 1 otherwise, c1, cov11 and sumsq.

=item C<gsl_fit_mul_est($x, $c1, $cov11)> - This function uses the best-fit linear regression coefficient $c1 and its covariance $cov11 to compute the fitted function y and its standard deviation y_err for the model Y = c_1 X at the point $x. The function returns the following values in this order : 0 if the operation succeeded, 1 otherwise, y and y_err.

=back

 For more informations on the functions, we refer you to the GSL offcial
 documentation: http://www.gnu.org/software/gsl/manual/html_node/

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
