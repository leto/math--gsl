%module Randist
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
                    gsl_ran_discrete_ gsl_ran_discrete_t gsl_ran_discrete_free(gsl_ran_discrete_t 
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

    use Math::GSL::Randist qw/put_functions_here/;

=head1 DESCRIPTION

Here is a list of all the functions included in this module :

    gsl_ran_bernoulli gsl_ran_bernoulli_pdf gsl_ran_beta 
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
    gsl_ran_discrete gsl_ran_discrete_pdf 

You have to add the functions you want to use inside the qw /put_funtion_here /. You can also write 

    use Math::GSL::Randist qw/:name_of_tag/ 
    
to use all avaible functions of the module. Other tags are also avaible, here is a complete list of all tags for this module :

logarithmic
choose
exponential
gumbel1
exppow
sample
logistic
gaussian
poisson
binomial
fdist
chisq
gamma
hypergeometric
dirichlet
negative
flat
geometric
discrete
tdist
ugaussian
rayleigh
dir
pascal
gumbel2
shuffle
landau
bernoulli
weibull
multinomial
beta
lognormal
laplace
erlang
cauchy
levy
bivariate
pareto

For example the beta tag contains theses functions : gsl_ran_beta, gsl_ran_beta_pdf.

For more informations on the functions, we refer you to the GSL offcial documentation: http://www.gnu.org/software/gsl/manual/html_node/
Tip : search on google: site:http://www.gnu.org/software/gsl/manual/html_node/ name_of_the_function_you_want

=head1 EXAMPLES



=head1 AUTHOR

Jonathan Leto <jaleto@gmail.com> and Thierry Moisan <thierry.moisan@gmail.com>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2008 Jonathan Leto and Thierry Moisan

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut
%}
