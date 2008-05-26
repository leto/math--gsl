%module CDF
%{
#include "/usr/local/include/gsl/gsl_cdf.h"
%}

%include "/usr/local/include/gsl/gsl_cdf.h"

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

Math::GSL::CDF 
These functions compute the cumulative distribution functions P(x), Q(x) and their inverses for the named distributions.

=head1 SYPNOPSIS

use Math::GSL::CDF qw / put_functions_here/;

=head1 DESCRIPTION

Here is a list of all the functions included in this module :
gsl_cdf_ugaussian_P gsl_cdf_ugaussian_Q gsl_cdf_ugaussian_Pinv 
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

You have to add the functions you want to use inside the qw /put_funtion_here / with spaces between each function. You can also write use Math::GSL::PowInt qw/:all/ to use all avaible functions of the module. Other tags are also avaible, here is a complete list of all tags for this module :

geometric
tdist
ugaussian
rayleigh
pascal
exponential
gumbel2
gumbel1
exppow
logistic
weibull
gaussian
poisson
beta
binomial
laplace
lognormal
cauchy
fdist
chisq
gamma
hypergeometric
negative
pareto
flat

For example the beta tag contains theses functions : gsl_cdf_beta_P, gsl_cdf_beta_Q, gsl_cdf_beta_Pinv, gsl_cdf_beta_Qinv. 

For more informations on the functions, we refer you to the GSL offcial documentation: http://www.gnu.org/software/gsl/manual/html_node/
Tip : search on google: site:http://www.gnu.org/software/gsl/manual/html_node/ name_of_the_function_you_want

=head1 EXAMPLES

example using tag:

use Math::GSL::CDF qw /:beta/;
print gsl_cdf_beta_P(1,2,3) . "\n";


example using functions:

use Math::GSL::CDF qw /gsl_cdf_laplace_P gsl_cdf_laplace_Q/;

print gsl_cdf_laplace_P(2,3). "\n";
print gsl_cdf_laplace_Q(2,3). "\n";

=head1 AUTHOR

Jonathan Leto <jaleto@gmail.com> and Thierry Moisan <thierry.moisan@gmail.com>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2008 Jonathan Leto and Thierry Moisan

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut
%}



