%module "Math::GSL::CDF"
%{
#include "gsl/gsl_cdf.h"
%}

%include "gsl/gsl_cdf.h"

%perlcode %{

our @EXPORT_OK = qw/ gsl_cdf_ugaussian_P gsl_cdf_ugaussian_Q gsl_cdf_ugaussian_Pinv 
gsl_cdf_ugaussian_Qinv gsl_cdf_gaussian_P gsl_cdf_gaussian_Q 
gsl_cdf_gaussian_Pinv gsl_cdf_gaussian_Qinv gsl_cdf_gamma_P 
gsl_cdf_gamma_Q gsl_cdf_gamma_Pinv gsl_cdf_gamma_Qinv 
gsl_cdf_cauchy_P gsl_cdf_cauchy_Q gsl_cdf_cauchy_Pinv 
gsl_cdf_cauchy_Qinv gsl_cdf_laplace_P gsl_cdf_laplace_Q 
gsl_cdf_laplace_Pinv gsl_cdf_laplace_Qinv gsl_cdf_rayleigh_P 
gsl_cdf_rayleigh_Q gsl_cdf_rayleigh_Pinv gsl_cdf_rayleigh_Qinv 
gsl_cdf_chisq_P gsl_cdf_chisq_Q gsl_cdf_chisq_Pinv 
gsl_cdf_chisq_Qinv gsl_cdf_exponential_P gsl_cdf_exponential_Q 
gsl_cdf_exponential_Pinv gsl_cdf_exponential_Qinv gsl_cdf_exppow_P 
gsl_cdf_exppow_Q gsl_cdf_tdist_P gsl_cdf_tdist_Q 
gsl_cdf_tdist_Pinv gsl_cdf_tdist_Qinv gsl_cdf_fdist_P 
gsl_cdf_fdist_Q gsl_cdf_fdist_Pinv gsl_cdf_fdist_Qinv 
gsl_cdf_beta_P gsl_cdf_beta_Q gsl_cdf_beta_Pinv 
gsl_cdf_beta_Qinv gsl_cdf_flat_P gsl_cdf_flat_Q 
gsl_cdf_flat_Pinv gsl_cdf_flat_Qinv gsl_cdf_lognormal_P 
gsl_cdf_lognormal_Q gsl_cdf_lognormal_Pinv gsl_cdf_lognormal_Qinv 
gsl_cdf_gumbel1_P gsl_cdf_gumbel1_Q gsl_cdf_gumbel1_Pinv 
gsl_cdf_gumbel1_Qinv gsl_cdf_gumbel2_P gsl_cdf_gumbel2_Q 
gsl_cdf_gumbel2_Pinv gsl_cdf_gumbel2_Qinv gsl_cdf_weibull_P 
gsl_cdf_weibull_Q gsl_cdf_weibull_Pinv gsl_cdf_weibull_Qinv 
gsl_cdf_pareto_P gsl_cdf_pareto_Q gsl_cdf_pareto_Pinv 
gsl_cdf_pareto_Qinv gsl_cdf_logistic_P gsl_cdf_logistic_Q 
gsl_cdf_logistic_Pinv gsl_cdf_logistic_Qinv gsl_cdf_binomial_P 
gsl_cdf_binomial_Q gsl_cdf_poisson_P gsl_cdf_poisson_Q 
gsl_cdf_geometric_P gsl_cdf_geometric_Q gsl_cdf_negative_binomial_P 
gsl_cdf_negative_binomial_Q gsl_cdf_pascal_P gsl_cdf_pascal_Q 
gsl_cdf_hypergeometric_P gsl_cdf_hypergeometric_Q
                /;
our %EXPORT_TAGS = ( all =>  [  @EXPORT_OK ], geometric => [ gsl_cdf_geometric_P , gsl_cdf_geometric_Q ], tdist => [ gsl_cdf_tdist_P , gsl_cdf_tdist_Q , gsl_cdf_tdist_Pinv , gsl_cdf_tdist_Qinv ], ugaussian => [ gsl_cdf_ugaussian_P , gsl_cdf_ugaussian_Q , gsl_cdf_ugaussian_Pinv , gsl_cdf_ugaussian_Qinv ], rayleigh => [ gsl_cdf_rayleigh_P , gsl_cdf_rayleigh_Q , gsl_cdf_rayleigh_Pinv , gsl_cdf_rayleigh_Qinv ], pascal => [ gsl_cdf_pascal_P , gsl_cdf_pascal_Q ], exponential => [ gsl_cdf_exponential_P , gsl_cdf_exponential_Q , gsl_cdf_exponential_Pinv , gsl_cdf_exponential_Qinv ], gumbel2 => [ gsl_cdf_gumbel2_P , gsl_cdf_gumbel2_Q , gsl_cdf_gumbel2_Pinv , gsl_cdf_gumbel2_Qinv ], gumbel1 => [ gsl_cdf_gumbel1_P , gsl_cdf_gumbel1_Q , gsl_cdf_gumbel1_Pinv , gsl_cdf_gumbel1_Qinv ], exppow => [ gsl_cdf_exppow_P , gsl_cdf_exppow_Q ], logistic => [ gsl_cdf_logistic_P , gsl_cdf_logistic_Q , gsl_cdf_logistic_Pinv , gsl_cdf_logistic_Qinv ], weibull => [ gsl_cdf_weibull_P , gsl_cdf_weibull_Q , gsl_cdf_weibull_Pinv , gsl_cdf_weibull_Qinv ], gaussian => [ gsl_cdf_gaussian_P , gsl_cdf_gaussian_Q , gsl_cdf_gaussian_Pinv , gsl_cdf_gaussian_Qinv ], poisson => [ gsl_cdf_poisson_P , gsl_cdf_poisson_Q ], beta => [ gsl_cdf_beta_P , gsl_cdf_beta_Q , gsl_cdf_beta_Pinv , gsl_cdf_beta_Qinv ], binomial => [ gsl_cdf_binomial_P , gsl_cdf_binomial_Q ], laplace => [ gsl_cdf_laplace_P , gsl_cdf_laplace_Q , gsl_cdf_laplace_Pinv , gsl_cdf_laplace_Qinv ], lognormal => [ gsl_cdf_lognormal_P , gsl_cdf_lognormal_Q , gsl_cdf_lognormal_Pinv , gsl_cdf_lognormal_Qinv ], cauchy => [ gsl_cdf_cauchy_P , gsl_cdf_cauchy_Q , gsl_cdf_cauchy_Pinv , gsl_cdf_cauchy_Qinv ], fdist => [ gsl_cdf_fdist_P , gsl_cdf_fdist_Q , gsl_cdf_fdist_Pinv , gsl_cdf_fdist_Qinv ], chisq => [ gsl_cdf_chisq_P , gsl_cdf_chisq_Q , gsl_cdf_chisq_Pinv , gsl_cdf_chisq_Qinv ], gamma => [ gsl_cdf_gamma_P , gsl_cdf_gamma_Q , gsl_cdf_gamma_Pinv , gsl_cdf_gamma_Qinv ], hypergeometric => [ gsl_cdf_hypergeometric_P , gsl_cdf_hypergeometric_Q ], negative => [ gsl_cdf_negative_binomial_P , gsl_cdf_negative_binomial_Q ], pareto => [ gsl_cdf_pareto_P , gsl_cdf_pareto_Q , gsl_cdf_pareto_Pinv , gsl_cdf_pareto_Qinv ], flat => [ gsl_cdf_flat_P , gsl_cdf_flat_Q , gsl_cdf_flat_Pinv , gsl_cdf_flat_Qinv ]);

__END__

=head1 NAME

Math::GSL::CDF - Cumulative Distribution Functions

=head1 SYNOPSIS

    use Math::GSL::CDF qw /:all/;
    my $x = gsl_cdf_gaussian_Pinv($P, $sigma);

These functions compute the cumulative distribution functions P(x), Q(x) and
their inverses for the named distributions.

=head1 DESCRIPTION

 Here is a list of all the functions included in this module :

 gsl_cdf_ugaussian_P($x)
 gsl_cdf_ugaussian_Q($x)
 gsl_cdf_ugaussian_Pinv($P) 
 gsl_cdf_ugaussian_Qinv($Q)
 - These functions compute the cumulative distribution functions P(x), Q(x) and their inverses for the unit Gaussian distribution. 

 gsl_cdf_gaussian_P($x, $sigma)
 gsl_cdf_gaussian_Q($x, $sigma) 
 gsl_cdf_gaussian_Pinv($P, $sigma)
 gsl_cdf_gaussian_Qinv($Q, $sigma)
 - These functions compute the cumulative distribution functions P(x), Q(x) and their inverses for the Gaussian distribution with standard deviation $sigma. 

 gsl_cdf_gamma_P($x, $a, $b) 
 gsl_cdf_gamma_Q($x, $a, $b)
 gsl_cdf_gamma_Pinv($P, $a, $b)
 gsl_cdf_gamma_Qinv($Q, $a, $b)
 - These functions compute the cumulative distribution functions P(x), Q(x) and their inverses for the gamma distribution with parameters $a and $b. 

 gsl_cdf_cauchy_P($x, $a)
 gsl_cdf_cauchy_Q($x, $a)
 gsl_cdf_cauchy_Pinv($P, $a)
 gsl_cdf_cauchy_Qinv($Q, $a)
 - These functions compute the cumulative distribution functions P(x), Q(x) and their inverses for the Cauchy distribution with scale parameter $a. 

 gsl_cdf_laplace_P($x, $a)
 gsl_cdf_laplace_Q($x, $a) 
 gsl_cdf_laplace_Pinv($P, $a)
 gsl_cdf_laplace_Qinv($Q, $a)
 - These functions compute the cumulative distribution functions P(x), Q(x) and their inverses for the Laplace distribution with width $a. 

 gsl_cdf_rayleigh_P($x, $sigma) 
 gsl_cdf_rayleigh_Q($x, $sigma)
 gsl_cdf_rayleigh_Pinv($P, $sigma)
 gsl_cdf_rayleigh_Qinv($Q, $sigma) 
 - These functions compute the cumulative distribution functions P(x), Q(x) and their inverses for the Rayleigh distribution with scale parameter $sigma.  

 gsl_cdf_chisq_P($x, $nu)
 gsl_cdf_chisq_Q($x, $nu)
 gsl_cdf_chisq_Pinv($P, $nu) 
 gsl_cdf_chisq_Qinv($Q, $nu)
 - These functions compute the cumulative distribution functions P(x), Q(x) and their inverses for the chi-squared distribution with $nu degrees of freedom. 

 gsl_cdf_exponential_P($x, $mu)
 gsl_cdf_exponential_Q($x, $mu) 
 gsl_cdf_exponential_Pinv($P, $mu)
 gsl_cdf_exponential_Qinv($Q, $mu)
 - These functions compute the cumulative distribution functions P(x), Q(x) and their inverses for the Laplace distribution with width $a. 

 gsl_cdf_exppow_P($x, $a, $b) 
 gsl_cdf_exppow_Q($x, $a, $b)
 - These functions compute the cumulative distribution functions P(x), Q(x) for the exponential power distribution with parameters $a and $b. 

 gsl_cdf_tdist_P($x, $nu)
 gsl_cdf_tdist_Q($x, $nu) 
 gsl_cdf_tdist_Pinv($P, $nu)
 gsl_cdf_tdist_Qinv($Q, $nu)
 - These functions compute the cumulative distribution functions P(x), Q(x) and their inverses for the t-distribution with $nu degrees of freedom.

 gsl_cdf_fdist_P($x, $nu1, $nu2) 
 gsl_cdf_fdist_Q($x, $nu1, $nu2)
 gsl_cdf_fdist_Pinv($P, $nu1, $nu2)
 gsl_cdf_fdist_Qinv($Q, $nu1, $nu2) 
 - These functions compute the cumulative distribution functions P(x), Q(x) and their inverses for the F-distribution with $nu1 and $nu2 degrees of freedom. 

 gsl_cdf_beta_P($x, $a, $b)
 gsl_cdf_beta_Q($x, $a, $b)
 gsl_cdf_beta_Pinv($P, $a, $b) 
 gsl_cdf_beta_Qinv($Q, $a, $b)
 - These functions compute the cumulative distribution functions P(x), Q(x) and their inverses for the beta distribution with parameters $a and $b. 

 gsl_cdf_flat_P($x, $a, $b)
 gsl_cdf_flat_Q($x, $a, $b) 
 gsl_cdf_flat_Pinv($P, $a, $b)
 gsl_cdf_flat_Qinv($Q, $a, $b)
 - These functions compute the cumulative distribution functions P(x), Q(x) and their inverses for a uniform distribution from $a to $b. 

 gsl_cdf_lognormal_P($x, $zeta, $sigma)
 gsl_cdf_lognormal_Q($x, $zeta, $sigma)
 gsl_cdf_lognormal_Pinv($P, $zeta, $sigma)
 gsl_cdf_lognormal_Qinv($Q, $zeta, $sigma) 
 - These functions compute the cumulative distribution functions P(x), Q(x) and their inverses for the lognormal distribution with parameters $zeta and $sigma. 

 gsl_cdf_gumbel1_P($x, $a, $b)
 gsl_cdf_gumbel1_Q($x, $a, $b)
 gsl_cdf_gumbel1_Pinv($P, $a, $b) 
 gsl_cdf_gumbel1_Qinv($Q, $a, $b)
 - These functions compute the cumulative distribution functions P(x), Q(x) and their inverses for the Type-1 Gumbel distribution with parameters $a and $b. 

 gsl_cdf_gumbel2_P($x, $a, $b)
 gsl_cdf_gumbel2_Q($x, $a, $b) 
 gsl_cdf_gumbel2_Pinv($P, $a, $b)
 gsl_cdf_gumbel2_Qinv($Q, $a, $b)
 - These functions compute the cumulative distribution functions P(x), Q(x) and their inverses for the Type-2 Gumbel distribution with parameters $a and $b. 

 gsl_cdf_weibull_P($x, $a, $b) 
 gsl_cdf_weibull_Q($x, $a, $b)
 gsl_cdf_weibull_Pinv($P, $a, $b)
 gsl_cdf_weibull_Qinv($Q, $a, $b) 
 - These functions compute the cumulative distribution functions P(x), Q(x) and their inverses for the Type-1 Gumbel distribution with parameters $a and $b. 

 gsl_cdf_pareto_P($x, $a, $b)
 gsl_cdf_pareto_Q($x, $a, $b)
 gsl_cdf_pareto_Pinv($P, $a, $b) 
 gsl_cdf_pareto_Qinv($Q, $a, $b)
 - These functions compute the cumulative distribution functions P(x), Q(x) and their inverses for the Pareto distribution with exponent $a and scale $b.

 gsl_cdf_logistic_P($x, $a)
 gsl_cdf_logistic_Q($x, $a) 
 gsl_cdf_logistic_Pinv($P, $a)
 gsl_cdf_logistic_Qinv($Q, $a)
 - These functions compute the cumulative distribution functions P(x), Q(x) and their inverses for the logistic distribution with scale parameter a. 

 gsl_cdf_binomial_P($k, $p, $n) 
 gsl_cdf_binomial_Q($k, $p, $n)
 - These functions compute the cumulative distribution functions P(k), Q(k) for the binomial distribution with parameters $p and $n. 

 gsl_cdf_poisson_P($k, $mu)
 gsl_cdf_poisson_Q($k, $mu)
 - These functions compute the cumulative distribution functions P(k), Q(k) for the Poisson distribution with parameter $mu.  

 gsl_cdf_geometric_P($k, $p)
 gsl_cdf_geometric_Q($k, $p)
 - These functions compute the cumulative distribution functions P(k), Q(k) for the geometric distribution with parameter $p.

 gsl_cdf_negative_binomial_P($k, $p, $n) 
 gsl_cdf_negative_binomial_Q($k, $p, $n)
 - These functions compute the cumulative distribution functions P(k), Q(k) for the negative binomial distribution with parameters $p and $n. 

 gsl_cdf_pascal_P($k, $p, $n)
 gsl_cdf_pascal_Q($k, $p, $n)
 - These functions compute the cumulative distribution functions P(k), Q(k) for the Pascal distribution with parameters $p and $n.  

 gsl_cdf_hypergeometric_P($k, $n1, $n2, $t)
 gsl_cdf_hypergeometric_Q($k, $n1, $n2, $t)
 - These functions compute the cumulative distribution functions P(k), Q(k) for the hypergeometric distribution with parameters $n1, $n2 and $t. 


 To import specific functions, list them in the use line. To import
 all function exportable by Math::GSL::CDF do

    use Math::GSL::CDF qw/:all/
    
 This is the list of available import tags:

=over

=item geometric

=item tdist

=item ugaussian

=item rayleigh

=item pascal

=item exponential

=item gumbel2

=item gumbel1

=item exppow

=item logistic

=item weibull

=item gaussian

=item poisson

=item beta

=item binomial

=item laplace

=item lognormal

=item cauchy

=item fdist

=item chisq

=item gamma

=item hypergeometric

=item negative

=item pareto

=item flat

 For example the beta tag contains theses functions : gsl_cdf_beta_P,
 gsl_cdf_beta_Q, gsl_cdf_beta_Pinv, gsl_cdf_beta_Qinv. 

For more informations on the functions, we refer you to the GSL offcial documentation: 
L<http://www.gnu.org/software/gsl/manual/html_node/>

 Tip : search on google: site:http://www.gnu.org/software/gsl/manual/html_node/ name_of_the_function_you_want

=back

=head1 EXAMPLES

Example using import tags:

 use Math::GSL::CDF qw /:beta/;
 print gsl_cdf_beta_P(1,2,3) . "\n";

=head1 AUTHORS

Jonathan Leto <jonathan@leto.net> and Thierry Moisan <thierry.moisan@gmail.com>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2008 Jonathan Leto and Thierry Moisan

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut
%}



