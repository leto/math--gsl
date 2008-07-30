%module "Math::GSL::Randist"
%include "typemaps.i"

void gsl_ran_dir_2d (const gsl_rng * r, double *OUTPUT, double *OUTPUT);
void gsl_ran_dir_2d_trig_method (const gsl_rng * r, double *OUTPUT, double *OUTPUT);
void gsl_ran_dir_3d (const gsl_rng * r, double *OUTPUT, double *OUTPUT, double *OUTPUT);
void gsl_ran_bivariate_gaussian (const gsl_rng * r, double sigma_x, double sigma_y, double rho, double *OUTPUT, double *OUTPUT);

%typemap(in) void * {
    AV *tempav;
    I32 len;
    int i,x;
    SV  **tv;

    if (!SvROK($input))
        croak("Argument $argnum is not a reference.");
    if (SvTYPE(SvRV($input)) != SVt_PVAV)
        croak("Argument $argnum is not an array.");

    tempav = (AV*)SvRV($input);
    len = av_len(tempav);
    $1 = (int **) malloc((len+2)*sizeof(int *));
    for (i = 0; i <= len; i++) {
        tv = av_fetch(tempav, i, 0);    
        x  = SvIV(*tv);
        memset((int*)($1+i), x , 1);
        //printf("curr = %d\n", (int)($1+i) );
    }
};
%typemap(freearg) void * {
    free($1);
}

%{
    #include "gsl/gsl_randist.h"
%}
%include "gsl/gsl_randist.h"

%perlcode %{

our @EXPORT_OK = qw/gsl_ran_bernoulli gsl_ran_bernoulli_pdf gsl_ran_beta 
                    gsl_ran_beta_pdf gsl_ran_binomial gsl_ran_binomial_knuth 
                    gsl_ran_binomial_tpe gsl_ran_binomial_pdf gsl_ran_exponential 
                    gsl_ran_exponential_pdf gsl_ran_exppow gsl_ran_exppow_pdf 
                    gsl_ran_cauchy gsl_ran_cauchy_pdf gsl_ran_chisq 
                    gsl_ran_chisq_pdf gsl_ran_dirichlet gsl_ran_dirichlet_pdf 
                    gsl_ran_dirichlet_lnpdf gsl_ran_erlang gsl_ran_erlang_pdf 
                    gsl_ran_fdist gsl_ran_fdist_pdf gsl_ran_flat 
                    gsl_ran_flat_pdf gsl_ran_gamma gsl_ran_gamma_int 
                    gsl_ran_gamma_pdf gsl_ran_gamma_mt gsl_ran_gamma_knuth 
                    gsl_ran_gaussian gsl_ran_gaussian_ratio_method gsl_ran_gaussian_ziggurat 
                    gsl_ran_gaussian_pdf gsl_ran_ugaussian gsl_ran_ugaussian_ratio_method 
                    gsl_ran_ugaussian_pdf gsl_ran_gaussian_tail gsl_ran_gaussian_tail_pdf 
                    gsl_ran_ugaussian_tail gsl_ran_ugaussian_tail_pdf gsl_ran_bivariate_gaussian 
                    gsl_ran_bivariate_gaussian_pdf gsl_ran_landau gsl_ran_landau_pdf 
                    gsl_ran_geometric gsl_ran_geometric_pdf gsl_ran_hypergeometric 
                    gsl_ran_hypergeometric_pdf gsl_ran_gumbel1 gsl_ran_gumbel1_pdf 
                    gsl_ran_gumbel2 gsl_ran_gumbel2_pdf gsl_ran_logistic 
                    gsl_ran_logistic_pdf gsl_ran_lognormal gsl_ran_lognormal_pdf 
                    gsl_ran_logarithmic gsl_ran_logarithmic_pdf gsl_ran_multinomial 
                    gsl_ran_multinomial_pdf gsl_ran_multinomial_lnpdf 
                    gsl_ran_negative_binomial gsl_ran_negative_binomial_pdf gsl_ran_pascal 
                    gsl_ran_pascal_pdf gsl_ran_pareto gsl_ran_pareto_pdf 
                    gsl_ran_poisson gsl_ran_poisson_array 
                    gsl_ran_poisson_pdf gsl_ran_rayleigh gsl_ran_rayleigh_pdf 
                    gsl_ran_rayleigh_tail gsl_ran_rayleigh_tail_pdf gsl_ran_tdist 
                    gsl_ran_tdist_pdf gsl_ran_laplace gsl_ran_laplace_pdf 
                    gsl_ran_levy gsl_ran_levy_skew gsl_ran_weibull 
                    gsl_ran_weibull_pdf gsl_ran_dir_2d gsl_ran_dir_2d_trig_method 
                    gsl_ran_dir_3d gsl_ran_dir_nd gsl_ran_shuffle 
                    gsl_ran_choose gsl_ran_sample 
                    gsl_ran_discrete_t gsl_ran_discrete_free gsl_ran_discrete_preproc
                    gsl_ran_discrete gsl_ran_discrete_pdf  
                /;

our %EXPORT_TAGS = (
        all                 => [  @EXPORT_OK ],
        logarithmic         => [ gsl_ran_logarithmic , gsl_ran_logarithmic_pdf ],
        choose              => [ gsl_ran_choose ],
        exponential         => [ gsl_ran_exponential , gsl_ran_exponential_pdf ],
        gumbel1             => [ gsl_ran_gumbel1 , gsl_ran_gumbel1_pdf ],
        exppow              => [ gsl_ran_exppow , gsl_ran_exppow_pdf ],
        sample              => [ gsl_ran_sample ],
        logistic            => [ gsl_ran_logistic , gsl_ran_logistic_pdf ],
        gaussian            => [  
                                 gsl_ran_gaussian , gsl_ran_gaussian_ratio_method , gsl_ran_gaussian_ziggurat,
                                 gsl_ran_gaussian_pdf , gsl_ran_gaussian_tail , gsl_ran_gaussian_tail_pdf 
                               ],
        poisson             => [ gsl_ran_poisson , gsl_ran_poisson_array , gsl_ran_poisson_pdf ], 
        binomial            => [ gsl_ran_binomial , gsl_ran_binomial_knuth , gsl_ran_binomial_tpe ,
                                 gsl_ran_binomial_pdf ],
        fdist               => [ gsl_ran_fdist , gsl_ran_fdist_pdf ],
        chisq               => [ gsl_ran_chisq , gsl_ran_chisq_pdf ],
        gamma               => [ gsl_ran_gamma , gsl_ran_gamma_int , gsl_ran_gamma_pdf , gsl_ran_gamma_mt , gsl_ran_gamma_knuth ],
        hypergeometric      => [ gsl_ran_hypergeometric , gsl_ran_hypergeometric_pdf ],
        dirichlet           => [ gsl_ran_dirichlet , gsl_ran_dirichlet_pdf , gsl_ran_dirichlet_lnpdf ],
        negative            => [ gsl_ran_negative_binomial , gsl_ran_negative_binomial_pdf ], 
        flat                => [ gsl_ran_flat , gsl_ran_flat_pdf ], 
        geometric           => [ gsl_ran_geometric , gsl_ran_geometric_pdf ], 
        discrete            => [ gsl_ran_discrete , gsl_ran_discrete_pdf], 
        tdist               => [ gsl_ran_tdist , gsl_ran_tdist_pdf ], 
        ugaussian           => [ gsl_ran_ugaussian , gsl_ran_ugaussian_ratio_method , gsl_ran_ugaussian_pdf ,
                                 gsl_ran_ugaussian_tail , gsl_ran_ugaussian_tail_pdf ], 
        rayleigh            => [ gsl_ran_rayleigh , gsl_ran_rayleigh_pdf , gsl_ran_rayleigh_tail ,
                                 gsl_ran_rayleigh_tail_pdf ], 
        dir                 => [ gsl_ran_dir_2d , gsl_ran_dir_2d_trig_method , gsl_ran_dir_3d , gsl_ran_dir_nd ], 
        pascal              => [ gsl_ran_pascal , gsl_ran_pascal_pdf ], 
        gumbel2             => [ gsl_ran_gumbel2 , gsl_ran_gumbel2_pdf ], 
        shuffle             => [ gsl_ran_shuffle ], 
        landau              => [ gsl_ran_landau , gsl_ran_landau_pdf ], 
        bernoulli           => [ gsl_ran_bernoulli , gsl_ran_bernoulli_pdf ], 
        weibull             => [ gsl_ran_weibull , gsl_ran_weibull_pdf ], 
        multinomial         => [ gsl_ran_multinomial , gsl_ran_multinomial_pdf , gsl_ran_multinomial_lnpdf ], 
        beta                => [ gsl_ran_beta , gsl_ran_beta_pdf ], 
        lognormal           => [ gsl_ran_lognormal , gsl_ran_lognormal_pdf ], 
        laplace             => [ gsl_ran_laplace , gsl_ran_laplace_pdf ], 
        erlang              => [ gsl_ran_erlang , gsl_ran_erlang_pdf ], 
        cauchy              => [ gsl_ran_cauchy , gsl_ran_cauchy_pdf ], 
        levy                => [ gsl_ran_levy , gsl_ran_levy_skew ], 
        bivariate           => [ gsl_ran_bivariate_gaussian , gsl_ran_bivariate_gaussian_pdf ], 
        pareto              => [ gsl_ran_pareto , gsl_ran_pareto_pdf ]
);

__END__

=head1 NAME

Math::GSL::Randist - Probability Distributions

=head1 SYNOPSIS

use Math::GSL::Randist qw/:all/;

=head1 DESCRIPTION

 Here is a list of all the functions included in this module :

=over

=item gsl_ran_bernoulli($r, $p) - This function returns either 0 or 1, the result of a Bernoulli trial with probability $p. The probability distribution for a Bernoulli trial is, p(0) = 1 - $p and  p(1) = $p. $r is a gsl_rng structure.

=item gsl_ran_bernoulli_pdf($k, $p) - This function computes the probability p($k) of obtaining $k from a Bernoulli distribution with probability parameter $p, using the formula given above.

=item gsl_ran_beta($r, $a, $b) - This function returns a random variate from the beta distribution. The distribution function is, p($x) dx = {Gamma($a+$b) \ Gamma($a) Gamma($b)} $x**{$a-1} (1-$x)**{$b-1} dx for 0 <= $x <= 1.$r is a gsl_rng structure.

=item gsl_ran_beta_pdf($x, $a, $b) - This function computes the probability density p($x) at $x for a beta distribution with parameters $a and $b, using the formula given above.

=item gsl_ran_binomial($k, $p, $n) - This function returns a random integer from the binomial distribution, the number of successes in n independent trials with probability $p. The probability distribution for binomial variates is p($k) = {$n! \ $k! ($n-$k)! } $p**$k (1-$p)^{$n-$k} for 0 <= $k <= $n. 

=item gsl_ran_binomial_knuth 

=item gsl_ran_binomial_tpe

=item gsl_ran_binomial_pdf($k, $p, $n) - This function computes the probability p($k) of obtaining $k from a binomial distribution with parameters $p and $n, using the formula given above.

=item gsl_ran_exponential($r, $mu) - This function returns a random variate from the exponential distribution with mean $mu. The distribution is, p($x) dx = {1 \ $mu} exp(-$x/$mu) dx for $x >= 0. $r is a gsl_rng structure. 

=item gsl_ran_exponential_pdf($x, $mu) - This function computes the probability density p($x) at $x for an exponential distribution with mean $mu, using the formula given above.

=item gsl_ran_exppow($r, $a, $b) - This function returns a random variate from the exponential power distribution with scale parameter $a and exponent $b. The distribution is, p(x) dx = {1 / 2 $a Gamma(1+1/$b)} exp(-|$x/$a|**$b) dx for $x >= 0. For $b = 1 this reduces to the Laplace distribution. For $b = 2 it has the same form as a gaussian distribution, but with $a = sqrt(2) sigma. $r is a gsl_rng structure.

=item gsl_ran_exppow_pdf($x, $a, $b) - This function computes the probability density p($x) at $x for an exponential power distribution with scale parameter $a and exponent $b, using the formula given above.  

=item gsl_ran_cauchy($r, $a) - This function returns a random variate from the Cauchy distribution with scale parameter $a. The probability distribution for Cauchy random variates is, p(x) dx = {1 / a pi (1 + (x/$a)**2) } dx for x in the range -infinity to +infinity. The Cauchy distribution is also known as the Lorentz distribution. $r is a gsl_rng structure.

=item gsl_ran_cauchy_pdf($x, $a) - This function computes the probability density p($x) at $x for a Cauchy distribution with scale parameter $a, using the formula given above.

=item gsl_ran_chisq($r, $nu) - This function returns a random variate from the chi-squared distribution with $nu degrees of freedom. The distribution function is, p(x) dx = {1 / 2 Gamma($nu/2) } (x/2)**{$nu/2 - 1} exp(-x/2) dx for $x >= 0. $r is a gsl_rng structure.  

=item gsl_ran_chisq_pdf($x, $nu) - This function computes the probability density p($x) at $x for a chi-squared distribution with $nu degrees of freedom, using the formula given above.

=item gsl_ran_dirichlet

=item gsl_ran_dirichlet_pdf 

=item gsl_ran_dirichlet_lnpdf

=item gsl_ran_erlang

=item gsl_ran_erlang_pdf 

=item gsl_ran_fdist($r, $nu1, $nu2) - This function returns a random variate from the F-distribution with degrees of freedom nu1 and nu2. The distribution function is, p(x) dx = { Gamma(($nu_1 + $nu_2)/2) / Gamma($nu_1/2) Gamma($nu_2/2) } $nu_1**{$nu_1/2} $nu_2**{$nu_2/2} x**{$nu_1/2 - 1} ($nu_2 + $nu_1 x)**{-$nu_1/2 -$nu_2/2} for $x >= 0. $r is a gsl_rng structure.

=item gsl_ran_fdist_pdf($x, $nu1, $nu2) - This function computes the probability density p(x) at x for an F-distribution with nu1 and nu2 degrees of freedom, using the formula given above.

=item gsl_ran_flat($r, $a, $b) - This function returns a random variate from the flat (uniform) distribution from a to b. The distribution is, p(x) dx = {1 / ($b-$a)} dx if $a <= x < $b and 0 otherwise. $r is a gsl_rng structure.

=item gsl_ran_flat_pdf($x, $a, $b) - This function computes the probability density p($x) at $x for a uniform distribution from $a to $b, using the formula given above.

=item gsl_ran_gamma($r, $a, $b) - This function returns a random variate from the flat (uniform) distribution from $a to $b. The distribution is, p(x) dx = {1 / ($b-$a)} dx if $a <= x < $b and 0 otherwise. $r is a gsl_rng structure.

=item gsl_ran_gamma_int 

=item gsl_ran_gamma_pdf($x, $a, $b) - This function computes the probability density p($x) at $x for a uniform distribution from $a to $b, using the formula given above. 

=item gsl_ran_gamma_mt

=item gsl_ran_gamma_knuth 

=item gsl_ran_gaussian($r, $sigma) - This function returns a Gaussian random variate, with mean zero and standard deviation $sigma. The probability distribution for Gaussian random variates is, p(x) dx = {1 / sqrt{2 pi $sigma**2}} exp(-x**2 / 2 $sigma**2) dx for x in the range -infinity to +infinity. $r is a gsl_rng structure.

=item gsl_ran_gaussian_ratio_method($r, $sigma) - This function computes a Gaussian random variate using the alternative Kinderman-Monahan-Leva ratio method.

=item gsl_ran_gaussian_ziggurat($r, $sigma) - This function computes a Gaussian random variate using the alternative Marsaglia-Tsang ziggurat ratio method. The Ziggurat algorithm is the fastest available algorithm in most cases. $r is a gsl_rng structure.

=item gsl_ran_gaussian_pdf($x, $sigma) - This function computes the probability density p($x) at $x for a Gaussian distribution with standard deviation sigma, using the formula given above.

=item gsl_ran_ugaussian($r) - This function computes results for the unit Gaussian distribution. It is equivalent to the gaussian functions above with a standard deviation of one, sigma = 1. $r is a gsl_rng structure.

=item gsl_ran_ugaussian_ratio_method($r) - This function computes results for the unit Gaussian distribution. It is equivalent to the gaussian functions above with a standard deviation of one, sigma = 1. $r is a gsl_rng structure.

=item gsl_ran_ugaussian_pdf($x) - This function computes results for the unit Gaussian distribution. It is equivalent to the gaussian functions above with a standard deviation of one, sigma = 1.

=item gsl_ran_gaussian_tail($r, $a, $sigma) - This function provides random variates from the upper tail of a Gaussian distribution with standard deviation sigma. The values returned are larger than the lower limit a, which must be positive. The probability distribution for Gaussian tail random variates is, p(x) dx = {1 / N($a; $sigma) sqrt{2 pi sigma**2}} exp(- x**2/(2 sigma**2)) dx for x > $a where N($a; $sigma) is the normalization constant, N($a; $sigma) = (1/2) erfc($a / sqrt(2 $sigma**2)). $r is a gsl_rng structure.

=item gsl_ran_gaussian_tail_pdf($x, $a, $gaussian) - This function computes the probability density p($x) at $x for a Gaussian tail distribution with standard deviation sigma and lower limit $a, using the formula given above. 

=item gsl_ran_ugaussian_tail($r, $a) - This functions compute results for the tail of a unit Gaussian distribution. It is equivalent to the functions above with a standard deviation of one, $sigma = 1. $r is a gsl_rng structure. 

=item gsl_ran_ugaussian_tail_pdf($x, $a) - This functions compute results for the tail of a unit Gaussian distribution. It is equivalent to the functions above with a standard deviation of one, $sigma = 1.  

=item gsl_ran_bivariate_gaussian($r, $sigma_x, $sigma_y, $rho) - This function generates a pair of correlated Gaussian variates, with mean zero, correlation coefficient rho and standard deviations $sigma_x and $sigma_y in the x and y directions. The first value returned is x and the second y. The probability distribution for bivariate Gaussian random variates is, p(x,y) dx dy = {1 / 2 pi $sigma_x $sigma_y sqrt{1-$rho**2}} exp (-(x**2/$sigma_x**2 + y**2/$sigma_y**2 - 2 $rho x y/($sigma_x $sigma_y))/2(1- $rho**2)) dx dy for x,y in the range -infinity to +infinity. The correlation coefficient $rho should lie between 1 and -1. $r is a gsl_rng structure.  

=item gsl_ran_bivariate_gaussian_pdf($x, $y, $sigma_x, $sigma_y, $rho) - This function computes the probability density p($x,$y) at ($x,$y) for a bivariate Gaussian distribution with standard deviations $sigma_x, $sigma_y and correlation coefficient $rho, using the formula given above.

=item gsl_ran_landau($r) - This function returns a random variate from the Landau distribution. The probability distribution for Landau random variates is defined analytically by the complex integral, p(x) = (1/(2 \pi i)) \int_{c-i\infty}^{c+i\infty} ds exp(s log(s) + x s) For numerical purposes it is more convenient to use the following equivalent form of the integral, p(x) = (1/\pi) \int_0^\infty dt \exp(-t \log(t) - x t) \sin(\pi t). $r is a gsl_rng structure.

=item gsl_ran_landau_pdf($x) - This function computes the probability density p($x) at $x for the Landau distribution using an approximation to the formula given above.  

=item gsl_ran_geometric($r, $p) - This function returns a random integer from the geometric distribution, the number of independent trials with probability $p until the first success. The probability distribution for geometric variates is, p(k) =  p (1-$p)^(k-1) for k >= 1. Note that the distribution begins with k=1 with this definition. There is another convention in which the exponent k-1 is replaced by k. $r is a gsl_rng structure. 

=item gsl_ran_geometric_pdf($k, $p) - This function computes the probability p($k) of obtaining $k from a geometric distribution with probability parameter p, using the formula given above.

=item gsl_ran_hypergeometric($r, $n1, $n2, $t) - This function returns a random integer from the hypergeometric distribution. The probability distribution for hypergeometric random variates is, p(k) =  C(n_1, k) C(n_2, t - k) / C(n_1 + n_2, t) where C(a,b) = a!/(b!(a-b)!) and t <= n_1 + n_2. The domain of k is max(0,t-n_2), ..., min(t,n_1). If a population contains n_1 elements of “type 1” and n_2 elements of “type 2” then the hypergeometric distribution gives the probability of obtaining k elements of “type 1” in t samples from the population without replacement. $r is a gsl_rng structure. 

=item gsl_ran_hypergeometric_pdf($k, $n1, $n2, $t) - This function computes the probability p(k) of obtaining k from a hypergeometric distribution with parameters $n1, $n2 $t, using the formula given above. 

=item gsl_ran_gumbel1($r, $a, $b) - This function returns a random variate from the Type-1 Gumbel distribution. The Type-1 Gumbel distribution function is, p(x) dx = a b \exp(-(b \exp(-ax) + ax)) dx for -\infty < x < \infty. $r is a gsl_rng structure.

=item gsl_ran_gumbel1_pdf($x, $a, $b) - This function computes the probability density p($x) at $x for a Type-1 Gumbel distribution with parameters $a and $b, using the formula given above. 

=item gsl_ran_gumbel2($r, $a, $b) - This function returns a random variate from the Type-2 Gumbel distribution. The Type-2 Gumbel distribution function is, p(x) dx = a b x^{-a-1} \exp(-b x^{-a}) dx for 0 < x < \infty. $r is a gsl_rng structure.

=item gsl_ran_gumbel2_pdf($x, $a, $b) - This function computes the probability density p($x) at $x for a Type-2 Gumbel distribution with parameters $a and $b, using the formula given above. 

=item gsl_ran_logistic($r, $a) - This function returns a random variate from the logistic distribution. The distribution function is, p(x) dx = { \exp(-x/a) \over a (1 + \exp(-x/a))^2 } dx for -\infty < x < +\infty. $r is a gsl_rng structure. 

=item gsl_ran_logistic_pdf($x, $a) - This function computes the probability density p($x) at $x for a logistic distribution with scale parameter $a, using the formula given above.

=item gsl_ran_lognormal($r, $zeta, $sigma) - This function returns a random variate from the lognormal distribution. The distribution function is, p(x) dx = {1 \over x \sqrt{2 \pi \sigma^2} } \exp(-(\ln(x) - \zeta)^2/2 \sigma^2) dx for x > 0. $r is a gsl_rng structure. 

=item gsl_ran_lognormal_pdf($x, $zeta, $sigma) - This function computes the probability density p($x) at $x for a lognormal distribution with parameters $zeta and $sigma, using the formula given above.

=item gsl_ran_logarithmic($r, $p) - This function returns a random integer from the logarithmic distribution. The probability distribution for logarithmic random variates is, p(k) = {-1 \over \log(1-p)} {(p^k \over k)} for k >= 1. $r is a gsl_rng structure.

=item gsl_ran_logarithmic_pdf($k, $p) - This function computes the probability p($k) of obtaining $k from a logarithmic distribution with probability parameter $p, using the formula given above. 

=item gsl_ran_multinomial 

=item gsl_ran_multinomial_pdf

=item gsl_ran_multinomial_lnpdf 

=item gsl_ran_negative_binomial($r, $p, $n) - This function returns a random integer from the negative binomial distribution, the number of failures occurring before n successes in independent trials with probability p of success. The probability distribution for negative binomial variates is, p(k) = {\Gamma(n + k) \over \Gamma(k+1) \Gamma(n) } p^n (1-p)^k Note that n is not required to be an integer. 

=item gsl_ran_negative_binomial_pdf($k, $p, $n) - This function computes the probability p($k) of obtaining $k from a negative binomial distribution with parameters $p and $n, using the formula given above.

=item gsl_ran_pascal($r, $p, $n) - This function returns a random integer from the Pascal distribution. The Pascal distribution is simply a negative binomial distribution with an integer value of $n. p($k) = {($n + $k - 1)! \ $k! ($n - 1)! } $p**$n (1-$p)**$k for $k >= 0. $r is gsl_rng structure  

=item gsl_ran_pascal_pdf($k, $p, $n) - This function computes the probability p($k) of obtaining $k from a Pascal distribution with parameters $p and $n, using the formula given above.

=item gsl_ran_pareto($r, $a, $b) - This function returns a random variate from the Pareto distribution of order $a. The distribution function is p($x) dx = ($a/$b) / ($x/$b)^{$a+1} dx for $x >= $b. $r is a gsl_rng structure

=item gsl_ran_pareto_pdf($x, $a, $b) - This function computes the probability density p(x) at x for a Pareto distribution with exponent a and scale b, using the formula given above. 

=item gsl_ran_poisson($r, $mu) -This function returns a random integer from the Poisson distribution with mean $mu. $r is a gsl_rng structure. The probability distribution for Poisson variates is, p(k) = {$mu**$k \ $k!} exp(-$mu) for $k >= 0. $r is a gsl_rng structure

=item gsl_ran_poisson_array

=item gsl_ran_poisson_pdf($k, $mu) - This function computes the probability p($k) of obtaining $k from a Poisson distribution with mean $mu, using the formula given above.

=item gsl_ran_rayleigh($r, $sigma) - This function returns a random variate from the Rayleigh distribution with scale parameter sigma. The distribution is, p(x) dx = {x \over \sigma^2} \exp(- x^2/(2 \sigma^2)) dx for x > 0. $r is a gsl_rng structure

=item gsl_ran_rayleigh_pdf($x, $sigma) - This function computes the probability density p($x) at $x for a Rayleigh distribution with scale parameter sigma, using the formula given above.

=item gsl_ran_rayleigh_tail($r, $a, $sigma) - This function returns a random variate from the tail of the Rayleigh distribution with scale parameter $sigma and a lower limit of $a. The distribution is, p(x) dx = {x \over \sigma^2} \exp ((a^2 - x^2) /(2 \sigma^2)) dx for x > a. $r is a gsl_rng structure

=item gsl_ran_rayleigh_tail_pdf($x, $a, $sigma) - This function computes the probability density p($x) at $x for a Rayleigh tail distribution with scale parameter $sigma and lower limit $a, using the formula given above. 

=item gsl_ran_tdist($r, $nu) - This function returns a random variate from the t-distribution. The distribution function is, p(x) dx = {\Gamma((\nu + 1)/2) \over \sqrt{\pi \nu} \Gamma(\nu/2)} (1 + x^2/\nu)^{-(\nu + 1)/2} dx for -\infty < x < +\infty.  

=item gsl_ran_tdist_pdf($x, $nu) - This function computes the probability density p($x) at $x for a t-distribution with nu degrees of freedom, using the formula given above.

=item gsl_ran_laplace($r, $a) - This function returns a random variate from the Laplace distribution with width $a. The distribution is, p(x) dx = {1 \over 2 a}  \exp(-|x/a|) dx for -\infty < x < \infty. 

=item gsl_ran_laplace_pdf($x, $a) - This function computes the probability density p($x) at $x for a Laplace distribution with width $a, using the formula given above. 

=item gsl_ran_levy($r, $c, $alpha) - This function returns a random variate from the Levy symmetric stable distribution with scale $c and exponent $alpha. The symmetric stable probability distribution is defined by a fourier transform, p(x) = {1 \over 2 \pi} \int_{-\infty}^{+\infty} dt \exp(-it x - |c t|^alpha) There is no explicit solution for the form of p(x) and the library does not define a corresponding pdf function. For \alpha = 1 the distribution reduces to the Cauchy distribution. For \alpha = 2 it is a Gaussian distribution with \sigma = \sqrt{2} c. For \alpha < 1 the tails of the distribution become extremely wide. The algorithm only works for 0 < alpha <= 2. $r is a gsl_rng structure

=item gsl_ran_levy_skew($r, $c, $alpha, $beta) - This function returns a random variate from the Levy skew stable distribution with scale $c, exponent $alpha and skewness parameter $beta. The skewness parameter must lie in the range [-1,1]. The Levy skew stable probability distribution is defined by a fourier transform, p(x) = {1 \over 2 \pi} \int_{-\infty}^{+\infty} dt \exp(-it x - |c t|^alpha (1-i beta sign(t) tan(pi alpha/2))) When \alpha = 1 the term \tan(\pi \alpha/2) is replaced by -(2/\pi)\log|t|. There is no explicit solution for the form of p(x) and the library does not define a corresponding pdf function. For $alpha = 2 the distribution reduces to a Gaussian distribution with $sigma = sqrt(2) $c and the skewness parameter has no effect. For $alpha < 1 the tails of the distribution become extremely wide. The symmetric distribution corresponds to $beta = 0. The algorithm only works for 0 < $alpha <= 2. The Levy alpha-stable distributions have the property that if N alpha-stable variates are drawn from the distribution p(c, \alpha, \beta) then the sum Y = X_1 + X_2 + \dots + X_N will also be distributed as an alpha-stable variate, p(N^(1/\alpha) c, \alpha, \beta). $r is a gsl_rng structure

=item gsl_ran_weibull($r, $a, $b) - This function returns a random variate from the Weibull distribution. The distribution function is, p(x) dx = {b \over a^b} x^{b-1}  \exp(-(x/a)^b) dx for x >= 0. $r is a gsl_rng structure

=item gsl_ran_weibull_pdf($x, $a, $b) - This function computes the probability density p($x) at $x for a Weibull distribution with scale $a and exponent $b, using the formula given above.

=item gsl_ran_dir_2d($r) - This function returns two values. The first is $x and the second is $y of a random direction vector v = ($x,$y) in two dimensions. The vector is normalized such that |v|^2 = $x^2 + $y^2 = 1. $r is a gsl_rng structure

=item gsl_ran_dir_2d_trig_method($r)  - This function returns two values. The first is $x and the second is $y of a random direction vector v = ($x,$y) in two dimensions. The vector is normalized such that |v|^2 = $x^2 + $y^2 = 1. $r is a gsl_rng structure

=item gsl_ran_dir_3d($r) - This function returns three values. The first is $x, the second $y and the third $z of a random direction vector v = ($x,$y,$z) in three dimensions. The vector is normalized such that |v|^2 = x^2 + y^2 + z^2 = 1. The method employed is due to Robert E. Knop (CACM 13, 326 (1970)), and explained in Knuth, v2, 3rd ed, p136. It uses the surprising fact that the distribution projected along any axis is actually uniform (this is only true for 3 dimensions). 

=item gsl_ran_dir_nd

=item gsl_ran_shuffle 

=item gsl_ran_choose

=item gsl_ran_sample 

=item gsl_ran_discrete_preproc

=item gsl_ran_discrete($r, $g) - After gsl_ran_discrete_preproc has been called, you use this function to get the discrete random numbers. $r is a gsl_rng structure and $g is a gsl_ran_discrete structure
=item gsl_ran_discrete_pdf($k, $g) - Returns the probability P[$k] of observing the variable $k. Since P[$k] is not stored as part of the lookup table, it must be recomputed; this computation takes O(K), so if K is large and you care about the original array P[$k] used to create the lookup table, then you should just keep this original array P[$k] around. $r is a gsl_rng structure and $g is a gsl_ran_discrete structure

=item gsl_ran_discrete_free($g) - De-allocates the gsl_ran_discrete pointed to by g. 

=back 

 You have to add the functions you want to use inside the qw /put_funtion_here /. 
 You can also write use Math::GSL::Randist qw/:name_of_tag/; to use all avaible functions of the module. 
 Other tags are also avaible, here is a complete list of all tags for this module :

=over

=item logarithmic

=item choose

=item exponential

=item gumbel1

=item exppow

=item sample

=item logistic

=item gaussian

=item poisson

=item binomial

=item fdist

=item chisq

=item gamma

=item hypergeometric

=item dirichlet

=item negative

=item flat

=item geometric

=item discrete

=item tdist

=item ugaussian

=item rayleigh

=item dir

=item pascal

=item gumbel2

=item shuffle

=item landau

=item bernoulli

=item weibull

=item multinomial

=item beta

=item lognormal

=item laplace

=item erlang

=item cauchy

=item levy

=item bivariate

=item pareto

=back

 For example the beta tag contains theses functions : gsl_ran_beta, gsl_ran_beta_pdf.

 For more informations on the functions, we refer you to the GSL offcial documentation: 
 L<http://www.gnu.org/software/gsl/manual/html_node/>
 Tip : search on google: site:http://www.gnu.org/software/gsl/manual/html_node/ name_of_the_function_you_want

 You might also want to write
 use Math::GSL::RNG qw/:all/;
 since a lot of the functions of Math::GSL::Randist take as argument a structure that is created by Math::GSL::RNG. 
 Refer to Math::GSL::RNG documentation to see how to create such a structure.

 Math::GSL::CDF also contains a structure named gsl_ran_discrete_t. An example is given in the EXAMPLES part on how to use the function related to this structure.


=head1 EXAMPLES

    use Math::GSL::Randist qw/:all/; 
    print gsl_ran_exponential_pdf(5,2) . "\n"; 

    use Math::GSL::Randist qw/:all/;
    $x= Math::GSL::gsl_ran_discrete_t::new;


=head1 AUTHORS

Jonathan Leto <jonathan@leto.net> and Thierry Moisan <thierry.moisan@gmail.com>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2008 Jonathan Leto and Thierry Moisan

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut
%}
