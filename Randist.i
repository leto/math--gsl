%module Randist
%include "typemaps.i"

void gsl_ran_dir_2d (const gsl_rng * r, double *OUTPUT, double *OUTPUT);
void gsl_ran_dir_2d_trig_method (const gsl_rng * r, double *OUTPUT, double *OUTPUT);
void gsl_ran_dir_3d (const gsl_rng * r, double *OUTPUT, double *OUTPUT, double *OUTPUT);

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
    #include "/usr/local/include/gsl/gsl_randist.h"
%}
%include "/usr/local/include/gsl/gsl_randist.h"

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

=head1 SYPNOPSIS

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

=item gsl_ran_cauchy

=item gsl_ran_cauchy_pdf

=item gsl_ran_chisq 

=item gsl_ran_chisq_pdf

=item gsl_ran_dirichlet

=item gsl_ran_dirichlet_pdf 

=item gsl_ran_dirichlet_lnpdf

=item gsl_ran_erlang

=item gsl_ran_erlang_pdf 

=item gsl_ran_fdist

=item gsl_ran_fdist_pdf

=item gsl_ran_flat 

=item gsl_ran_flat_pdf

=item gsl_ran_gamma

=item gsl_ran_gamma_int 

=item gsl_ran_gamma_pdf

=item gsl_ran_gamma_mt

=item gsl_ran_gamma_knuth 

=item gsl_ran_gaussian

=item gsl_ran_gaussian_ratio_method

=item gsl_ran_gaussian_ziggurat 

=item gsl_ran_gaussian_pdf

=item gsl_ran_ugaussian

=item gsl_ran_ugaussian_ratio_method 

=item gsl_ran_ugaussian_pdf

=item gsl_ran_gaussian_tail

=item gsl_ran_gaussian_tail_pdf 

=item gsl_ran_ugaussian_tail

=item gsl_ran_ugaussian_tail_pdf

=item gsl_ran_bivariate_gaussian 

=item gsl_ran_bivariate_gaussian_pdf

=item gsl_ran_landau

=item gsl_ran_landau_pdf 

=item gsl_ran_geometric

=item gsl_ran_geometric_pdf

=item gsl_ran_hypergeometric 

=item gsl_ran_hypergeometric_pdf

=item gsl_ran_gumbel1

=item gsl_ran_gumbel1_pdf 

=item gsl_ran_gumbel2

=item gsl_ran_gumbel2_pdf

=item gsl_ran_logistic 

=item gsl_ran_logistic_pdf

=item gsl_ran_lognormal

=item gsl_ran_lognormal_pdf 

=item gsl_ran_logarithmic

=item gsl_ran_logarithmic_pdf

=item gsl_ran_multinomial 

=item gsl_ran_multinomial_pdf

=item gsl_ran_multinomial_lnpdf 

=item gsl_ran_negative_binomial

=item gsl_ran_negative_binomial_pdf

=item gsl_ran_pascal($r, $p, $n) - This function returns a random integer from the Pascal distribution. The Pascal distribution is simply a negative binomial distribution with an integer value of $n. p($k) = {($n + $k - 1)! \ $k! ($n - 1)! } $p**$n (1-$p)**$k for $k >= 0. $r is gsl_rng structure  

=item gsl_ran_pascal_pdf($k, $p, $n) - This function computes the probability p($k) of obtaining $k from a Pascal distribution with parameters $p and $n, using the formula given above.

=item gsl_ran_pareto($r, $a, $b) - This function returns a random variate from the Pareto distribution of order $a. The distribution function is p($x) dx = ($a/$b) / ($x/$b)^{$a+1} dx for $x >= $b. $r is a gsl_rng structure

=item gsl_ran_pareto_pdf($x, $a, $b) - This function computes the probability density p(x) at x for a Pareto distribution with exponent a and scale b, using the formula given above. 

=item gsl_ran_poisson($r, $mu) -This function returns a random integer from the Poisson distribution with mean $mu. $r is a gsl_rng structure. The probability distribution for Poisson variates is, p(k) = {$mu**$k \ $k!} exp(-$mu) for $k >= 0.

=item gsl_ran_poisson_array

=item gsl_ran_poisson_pdf($k, $mu)- This function computes the probability p($k) of obtaining $k from a Poisson distribution with mean $mu, using the formula given above.

=item gsl_ran_rayleigh

=item gsl_ran_rayleigh_pdf 

=item gsl_ran_rayleigh_tail

=item gsl_ran_rayleigh_tail_pdf

=item gsl_ran_tdist 

=item gsl_ran_tdist_pdf

=item gsl_ran_laplace

=item gsl_ran_laplace_pdf 

=item gsl_ran_levy

=item gsl_ran_levy_skew

=item gsl_ran_weibull 

=item gsl_ran_weibull_pdf

=item gsl_ran_dir_2d($r) - This function returns two values. The first is $x and the second is $y of a random direction vector v = ($x,$y) in two dimensions. The vector is normalized such that |v|^2 = $x^2 + $y^2 = 1.

=item gsl_ran_dir_2d_trig_method($r)  - This function returns two values. The first is $x and the second is $y of a random direction vector v = ($x,$y) in two dimensions. The vector is normalized such that |v|^2 = $x^2 + $y^2 = 1.

=item gsl_ran_dir_3d

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

 For more informations on the functions, we refer you to the GSL offcial documentation: http://www.gnu.org/software/gsl/manual/html_node/
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


=head1 AUTHOR

Jonathan Leto <jonathan@leto.net> and Thierry Moisan <thierry.moisan@gmail.com>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2008 Jonathan Leto and Thierry Moisan

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut
%}
