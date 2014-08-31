package Math::GSL::Randist::Test;
use base q{Test::Class};
use Test::Most tests => 449;
use Math::GSL::Test    qw/:all/;
use Math::GSL::RNG     qw/:all/;
use Math::GSL::Errno   qw/:all/;
use Math::GSL::Randist qw/:all/;
use Math::GSL::Const   qw/ $M_PI /;
use Math::GSL qw/gsl_version/;
use List::Util qw/sum/;
use Data::Dumper;
BEGIN { gsl_set_error_handler_off() }

# note: The point-values for beta, binom, cauchy, chisq, exp, f, gamma, geom,
# hyper, lnorm, multinom, nbinom, t, unif, weibull, and norm were calculated
# using R, so if there were an error in gsl itself it would show.  Other dists
# are not available in R (at least not in the standard lib), though may be
# calc'd some other way.

# Not tested yet: bernoulli, bivariate, choose, discrete, erlang, exppow,
# gumbel1, gumbel2, landau, laplace, levy, logarithmic, logistic, pareto,
# pascal, poisson, rayleigh, sample, shuffle, ugaussian

use strict;
use warnings;

my $TOL0 = 0.00000001;
sub magnitude{ return sum map {$_ * $_} @_; }

sub make_fixture : Test(setup) {
    my $self = shift;
    $self->{rng} = Math::GSL::RNG->new;
}

sub teardown : Test(teardown) {
    my $self = shift;
    undef $self->{rng};
}

sub GSL_RAN_SHUFFLE : Tests {
}

sub GSL_RAN_PDF : Tests(4) {
    ok_similar(0, gsl_ran_bernoulli_pdf(2, 0.5), 'gsl_ran_bernoulli_pdf(2,0.5)=0' );
    ok_similar( gsl_ran_gaussian_pdf(0,1), 1/sqrt(2*$M_PI), 'gsl_ran_gaussian_pdf' );
    ok_similar( gsl_ran_ugaussian_pdf(0), 1/sqrt(2*$M_PI), 'gsl_ran_ugaussian_pdf' );
    ok_similar( gsl_ran_chisq_pdf(1,2), exp(-1/2)/2, 'gsl_ran_chisq_pdf' );
}

sub GSL_RAN_BASIC : Tests {
    my $self = shift;
    lives_ok( sub{ gsl_ran_lognormal($self->{rng}->raw, 0.1, 0.2 ) },
        'gsl_ran_lognormal works');
}

sub GSL_RAN_DIR : Tests(5) {
    my $self = shift;
    my $raw = $self->{rng}->raw;
    lives_ok( sub{ gsl_ran_dir_nd($self->{rng}->raw, 20) }, 'gsl_ran_dir_nd');
    ok_similar(magnitude(@{gsl_ran_dir_nd($raw, 20)}), 1.0, 'norm(gsl_ran_dir_nd(N)|^2=1.0');
    ok_similar(magnitude(gsl_ran_dir_2d($raw)), 1.0, '|gsl_ran_dir_2d()|^2=1.0');
    ok_similar(magnitude(gsl_ran_dir_2d_trig_method($raw)), 1.0, '|gsl_ran_dir_2d()|^2=1.0');
    ok_similar(magnitude(gsl_ran_dir_3d($raw)), 1.0, '|gsl_ran_dir_3d()|^2=1.0');
}

sub GSL_RAN_BETA : Tests(38){
    my $results = {
        'gsl_ran_beta_pdf(0,1,1)' => [1, $TOL0],
        'gsl_ran_beta_pdf(0.2,1,1)' => [1, $TOL0],
        'gsl_ran_beta_pdf(0.4,1,1)' => [1, $TOL0],
        'gsl_ran_beta_pdf(0.6,1,1)' => [1, $TOL0],
        'gsl_ran_beta_pdf(0.8,1,1)' => [1, $TOL0],
        'gsl_ran_beta_pdf(1,1,1)' => [1, $TOL0],
        'gsl_ran_beta_pdf(0.001,0.5,0.5)' => [10.0708791199471, $TOL0],
        'gsl_ran_beta_pdf(0.01,0.5,0.5)' => [3.19913472585565, $TOL0],
        'gsl_ran_beta_pdf(0.2,0.5,0.5)' => [0.795774715459476, $TOL0],
        'gsl_ran_beta_pdf(0.4,0.5,0.5)' => [0.649747334361397, $TOL0],
        'gsl_ran_beta_pdf(0.6,0.5,0.5)' => [0.649747334361397, $TOL0],
        'gsl_ran_beta_pdf(0.8,0.5,0.5)' => [0.795774715459477, $TOL0],
        'gsl_ran_beta_pdf(0.99,0.5,0.5)' => [3.19913472585565, $TOL0],
        'gsl_ran_beta_pdf(0.999,0.5,0.5)' => [10.0708791199471, $TOL0],
        'gsl_ran_beta_pdf(0.001,10,2)' => [1.0989e-25, $TOL0],
        'gsl_ran_beta_pdf(0.01,10,2)' => [1.089e-16, $TOL0],
        'gsl_ran_beta_pdf(0.2,10,2)' => [4.5056e-05, $TOL0],
        'gsl_ran_beta_pdf(0.4,10,2)' => [0.017301504, $TOL0],
        'gsl_ran_beta_pdf(0.6,10,2)' => [0.443418624, $TOL0],
        'gsl_ran_beta_pdf(0.8,10,2)' => [2.952790016, $TOL0],
        'gsl_ran_beta_pdf(0.99,10,2)' => [1.00486897223201, $TOL0],
        'gsl_ran_beta_pdf(0.999,10,2)' => [0.109013950773846, $TOL0],
        'gsl_ran_beta_pdf(0.001,2,10)' => [0.109013950773846, $TOL0],
        'gsl_ran_beta_pdf(0.01,2,10)' => [1.004868972232, $TOL0],
        'gsl_ran_beta_pdf(0.2,2,10)' => [2.952790016, $TOL0],
        'gsl_ran_beta_pdf(0.4,2,10)' => [0.443418624, $TOL0],
        'gsl_ran_beta_pdf(0.6,2,10)' => [0.017301504, $TOL0],
        'gsl_ran_beta_pdf(0.8,2,10)' => [4.5056e-05, $TOL0],
        'gsl_ran_beta_pdf(0.99,2,10)' => [1.08900000000002e-16, $TOL0],
        'gsl_ran_beta_pdf(0.999,2,10)' => [1.09890000000001e-25, $TOL0],
        'gsl_ran_beta_pdf(0.001,100,200)' => [2.27170349888188e-214, $TOL0],
        'gsl_ran_beta_pdf(0.01,100,200)' => [3.75165777121227e-116, $TOL0],
        'gsl_ran_beta_pdf(0.2,100,200)' => [9.11373658731348e-06, $TOL0],
        'gsl_ran_beta_pdf(0.4,100,200)' => [0.792241261860708, $TOL0],
        'gsl_ran_beta_pdf(0.6,100,200)' => [1.94863972665491e-18, $TOL0],
        'gsl_ran_beta_pdf(0.8,100,200)' => [5.67149220212515e-66, $TOL0],
        'gsl_ran_beta_pdf(0.99,100,200)' => [1.02495253689207e-315, $TOL0],
        'gsl_ran_beta_pdf(0.999,100,200)' => [0, $TOL0],
    };
    verify($results, 'Math::GSL::Randist');
}

sub GSL_RAN_BINOMIAL : Tests(27){
    my $results = {
        'gsl_ran_binomial_pdf(0,0.5,100)' => [7.8886090522101e-31, $TOL0],
        'gsl_ran_binomial_pdf(1,0.5,100)' => [7.88860905221007e-29, $TOL0],
        'gsl_ran_binomial_pdf(4,0.5,100)' => [3.09330110307526e-24, $TOL0],
        'gsl_ran_binomial_pdf(9,0.5,100)' => [1.50059630631462e-18, $TOL0],
        'gsl_ran_binomial_pdf(16,0.5,100)' => [1.0616968341312e-12, $TOL0],
        'gsl_ran_binomial_pdf(25,0.5,100)' => [1.91313970645126e-07, $TOL0],
        'gsl_ran_binomial_pdf(50,0.5,100)' => [0.0795892373871788, $TOL0],
        'gsl_ran_binomial_pdf(74,0.5,100)' => [5.51867223014786e-07, $TOL0],
        'gsl_ran_binomial_pdf(100,0.5,100)' => [7.8886090522101e-31, $TOL0],
        'gsl_ran_binomial_pdf(0,0.1,10)' => [0.3486784401, $TOL0],
        'gsl_ran_binomial_pdf(1,0.1,10)' => [0.387420489, $TOL0],
        'gsl_ran_binomial_pdf(2,0.1,10)' => [0.1937102445, $TOL0],
        'gsl_ran_binomial_pdf(3,0.1,10)' => [0.057395628, $TOL0],
        'gsl_ran_binomial_pdf(5,0.1,10)' => [0.0014880348, $TOL0],
        'gsl_ran_binomial_pdf(7,0.1,10)' => [8.748e-06, $TOL0],
        'gsl_ran_binomial_pdf(10,0.1,10)' => [1e-10, $TOL0],
        'gsl_ran_binomial_pdf(0,0.99,100)' => [1.00000000000003e-200, $TOL0],
        'gsl_ran_binomial_pdf(1,0.99,100)' => [9.9000000000009e-197, $TOL0],
        'gsl_ran_binomial_pdf(4,0.99,100)' => [3.76671308931275e-186, $TOL0],
        'gsl_ran_binomial_pdf(9,0.99,100)' => [1.73772156568561e-170, $TOL0],
        'gsl_ran_binomial_pdf(16,0.99,100)' => [1.14594349141262e-150, $TOL0],
        'gsl_ran_binomial_pdf(25,0.99,100)' => [1.8863666805437e-127, $TOL0],
        'gsl_ran_binomial_pdf(50,0.99,100)' => [6.10398755717333e-72, $TOL0],
        'gsl_ran_binomial_pdf(74,0.99,100)' => [3.32535922661711e-29, $TOL0],
        'gsl_ran_binomial_pdf(80,0.99,100)' => [2.39865000447078e-20, $TOL0],
        'gsl_ran_binomial_pdf(99,0.99,100)' => [0.369729637649727, $TOL0],
        'gsl_ran_binomial_pdf(100,0.99,100)' => [0.366032341273229, $TOL0],
    };
    verify($results, 'Math::GSL::Randist');
}

sub GSL_RAN_CAUCHY : Tests(25){
    my $results = {
        'gsl_ran_cauchy_pdf(-10,1)' => [0.00315158303152268, $TOL0],
        'gsl_ran_cauchy_pdf(-6,1)' => [0.00860296989685921, $TOL0],
        'gsl_ran_cauchy_pdf(-3,1)' => [0.0318309886183791, $TOL0],
        'gsl_ran_cauchy_pdf(0,1)' => [0.318309886183791, $TOL0],
        'gsl_ran_cauchy_pdf(3,1)' => [0.0318309886183791, $TOL0],
        'gsl_ran_cauchy_pdf(6,1)' => [0.00860296989685921, $TOL0],
        'gsl_ran_cauchy_pdf(10,1)' => [0.00315158303152268, $TOL0],
        'gsl_ran_cauchy_pdf(-20,2)' => [0.00157579151576134, $TOL0],
        'gsl_ran_cauchy_pdf(-10,2)' => [0.0061213439650729, $TOL0],
        'gsl_ran_cauchy_pdf(-6,2)' => [0.0159154943091895, $TOL0],
        'gsl_ran_cauchy_pdf(-3,2)' => [0.0489707517205832, $TOL0],
        'gsl_ran_cauchy_pdf(0,2)' => [0.159154943091895, $TOL0],
        'gsl_ran_cauchy_pdf(3,2)' => [0.0489707517205832, $TOL0],
        'gsl_ran_cauchy_pdf(6,2)' => [0.0159154943091895, $TOL0],
        'gsl_ran_cauchy_pdf(10,2)' => [0.0061213439650729, $TOL0],
        'gsl_ran_cauchy_pdf(20,2)' => [0.00157579151576134, $TOL0],
        'gsl_ran_cauchy_pdf(-20,10)' => [0.00636619772367581, $TOL0],
        'gsl_ran_cauchy_pdf(-10,10)' => [0.0159154943091895, $TOL0],
        'gsl_ran_cauchy_pdf(-6,10)' => [0.0234051386899846, $TOL0],
        'gsl_ran_cauchy_pdf(-3,10)' => [0.0292027418517239, $TOL0],
        'gsl_ran_cauchy_pdf(0,10)' => [0.0318309886183791, $TOL0],
        'gsl_ran_cauchy_pdf(3,10)' => [0.0292027418517239, $TOL0],
        'gsl_ran_cauchy_pdf(6,10)' => [0.0234051386899846, $TOL0],
        'gsl_ran_cauchy_pdf(10,10)' => [0.0159154943091895, $TOL0],
        'gsl_ran_cauchy_pdf(20,10)' => [0.00636619772367581, $TOL0],
    };
    verify($results, 'Math::GSL::Randist');
}

sub GSL_RAN_CHISQ : Tests(28){
    my $results = {
        'gsl_ran_chisq_pdf(0.01,1)' => [3.96952547477012, $TOL0],
        'gsl_ran_chisq_pdf(0.1,1)' => [1.20003894843014, $TOL0],
        'gsl_ran_chisq_pdf(0.3,1)' => [0.626910099227521, $TOL0],
        'gsl_ran_chisq_pdf(0.5,1)' => [0.439391289467722, $TOL0],
        'gsl_ran_chisq_pdf(1,1)' => [0.241970724519143, $TOL0],
        'gsl_ran_chisq_pdf(1.5,1)' => [0.153866322805455, $TOL0],
        'gsl_ran_chisq_pdf(2,1)' => [0.103776874355149, $TOL0],
        'gsl_ran_chisq_pdf(4,1)' => [0.026995483256594, $TOL0],
        'gsl_ran_chisq_pdf(0.0001,2)' => [0.499975, $TOL0],
        'gsl_ran_chisq_pdf(0.01,2)' => [0.497506239596341, $TOL0],
        'gsl_ran_chisq_pdf(0.1,2)' => [0.475614712250357, $TOL0],
        'gsl_ran_chisq_pdf(0.3,2)' => [0.430353988212529, $TOL0],
        'gsl_ran_chisq_pdf(0.5,2)' => [0.389400391535702, $TOL0],
        'gsl_ran_chisq_pdf(1,2)' => [0.303265329856317, $TOL0],
        'gsl_ran_chisq_pdf(1.5,2)' => [0.236183276370507, $TOL0],
        'gsl_ran_chisq_pdf(2,2)' => [0.183939720585721, $TOL0],
        'gsl_ran_chisq_pdf(4,2)' => [0.0676676416183064, $TOL0],
        'gsl_ran_chisq_pdf(0,4)' => [0, $TOL0],
        'gsl_ran_chisq_pdf(0.01,4)' => [0.00248753119798171, $TOL0],
        'gsl_ran_chisq_pdf(0.1,4)' => [0.0237807356125179, $TOL0],
        'gsl_ran_chisq_pdf(0.3,4)' => [0.0645530982318794, $TOL0],
        'gsl_ran_chisq_pdf(0.5,4)' => [0.0973500978839256, $TOL0],
        'gsl_ran_chisq_pdf(1,4)' => [0.151632664928158, $TOL0],
        'gsl_ran_chisq_pdf(1.5,4)' => [0.177137457277881, $TOL0],
        'gsl_ran_chisq_pdf(2,4)' => [0.183939720585721, $TOL0],
        'gsl_ran_chisq_pdf(4,4)' => [0.135335283236613, $TOL0],
    };

    verify($results, 'Math::GSL::Randist');
    return;

    # These test disabled until we figure out exactly which version of
    # GSL have which behavior
    my ($major, $minor) = split /\./, gsl_version();
    if ($major >= 1 && $minor >= 15) {
        $results->{'gsl_ran_chisq_pdf(0.0,2)'} = [0.5, $TOL0];
        $results->{'gsl_ran_chisq_pdf(0,2)'}   = [0.5, $TOL0];
    } else {
        $results->{'gsl_ran_chisq_pdf(0.0,2)'} = [0, $TOL0];
        $results->{'gsl_ran_chisq_pdf(0,2)'}   = [0, $TOL0];
    }

}

sub GSL_RAN_DIRICHLET : Tests(31) {
    my $self = shift;
    my $alpha = [ 1.0, 2.0 ];
    my $theta = [ 2.0, 3.0 ];

    lives_ok( sub{ gsl_ran_dirichlet($self->{rng}->raw, $alpha ) }, 'gsl_ran_dirichlet');
    lives_ok( sub{ gsl_ran_dirichlet_pdf($theta, $alpha ) }, 'gsl_ran_dirichlet_pdf');
    lives_ok( sub{ gsl_ran_dirichlet_lnpdf($theta, $alpha ) }, 'gsl_ran_dirichlet_lnpdf');

    ok_similar(sum(@{gsl_ran_dirichlet($self->{rng}->raw, $alpha)}), 1.0, 'sum(gsl_ran_dirichlet(alpha))=1');

    # when dim = 2, dirichlet is beta.
    for my $x (0.001,0.2,0.5,0.75,0.999) { # 5
        my $y = 1 - $x;
        for my $ab ([0.5,0.5],[1,1],[2,5],[10,2]) { # 4
            my ($a, $b) = @$ab;
            ok_similar(gsl_ran_dirichlet_pdf([$x,$y], [$a,$b]), gsl_ran_beta_pdf($x,$a,$b), 
                "dirichlet == beta ([$a, $b], [$x, $y])");
        }
    }

    # these values calculated by Math::GSL itself... should be confirmed by
    # some other software package.
    my $results = {
        'gsl_ran_dirichlet_pdf([0.31,0.25,0.44],[10,10,10])' => [11.5355719548212,$TOL0],
        'gsl_ran_dirichlet_pdf([0.1,0.1,0.8],[10,10,10])' => [2.48347392489645e-05,$TOL0],
        'gsl_ran_dirichlet_pdf([0.9,0.01,0.09],[10,2,2])' => [5.98332203211598,$TOL0],
        'gsl_ran_dirichlet_pdf([0.31,0.25,0.44],[1,1,1])' => [2,$TOL0],
        'gsl_ran_dirichlet_pdf([0.31,0.25,0.44],[.4,.5,.6])' => [0.848903581683801,$TOL0],
        'gsl_ran_dirichlet_pdf([0.1,0.2,0.145,0.145,0.25,0.16],[1.1,1.2,1.3,1.4,1.5,1.6])' => [277.893874809885,$TOL0],
        'gsl_ran_dirichlet_pdf([0.1,0.2,0.145,0.145,0.25,0.16],[10.1,1.2,1.3,1.4,1.5,1.6])' => [0.00261027364595901,$TOL0],
    };
    verify($results, 'Math::GSL::Randist');
}


sub GSL_RAN_EXPONENTIAL : Tests(24){
    my $results = {
        'gsl_ran_exponential_pdf(0.05,2)' => [0.487654956014166, $TOL0],
        'gsl_ran_exponential_pdf(0.1,2)' => [0.475614712250357, $TOL0],
        'gsl_ran_exponential_pdf(0.2,2)' => [0.45241870901798, $TOL0],
        'gsl_ran_exponential_pdf(0.4,2)' => [0.409365376538991, $TOL0],
        'gsl_ran_exponential_pdf(0.8,2)' => [0.33516002301782, $TOL0],
        'gsl_ran_exponential_pdf(1.6,2)' => [0.224664482058611, $TOL0],
        'gsl_ran_exponential_pdf(3.2,2)' => [0.100948258997328, $TOL0],
        'gsl_ran_exponential_pdf(6.4,2)' => [0.0203811019891831, $TOL0],
        'gsl_ran_exponential_pdf(0.05,0.666666666666667)' => [1.39161522949283, $TOL0],
        'gsl_ran_exponential_pdf(0.1,0.666666666666667)' => [1.29106196463759, $TOL0],
        'gsl_ran_exponential_pdf(0.2,0.666666666666667)' => [1.11122733102258, $TOL0],
        'gsl_ran_exponential_pdf(0.4,0.666666666666667)' => [0.82321745414104, $TOL0],
        'gsl_ran_exponential_pdf(0.8,0.666666666666667)' => [0.451791317868303, $TOL0],
        'gsl_ran_exponential_pdf(1.6,0.666666666666667)' => [0.136076929934119, $TOL0],
        'gsl_ran_exponential_pdf(3.2,0.666666666666667)' => [0.01234462057353, $TOL0],
        'gsl_ran_exponential_pdf(6.4,0.666666666666667)' => [0.000101593104736281, $TOL0],
        'gsl_ran_exponential_pdf(0.05,0.4)' => [2.20624225646149, $TOL0],
        'gsl_ran_exponential_pdf(0.1,0.4)' => [1.94700195767851, $TOL0],
        'gsl_ran_exponential_pdf(0.2,0.4)' => [1.51632664928158, $TOL0],
        'gsl_ran_exponential_pdf(0.4,0.4)' => [0.919698602928606, $TOL0],
        'gsl_ran_exponential_pdf(0.8,0.4)' => [0.338338208091532, $TOL0],
        'gsl_ran_exponential_pdf(1.6,0.4)' => [0.0457890972218354, $TOL0],
        'gsl_ran_exponential_pdf(3.2,0.4)' => [0.00083865656975628, $TOL0],
        'gsl_ran_exponential_pdf(6.4,0.4)' => [2.81337936798148e-07, $TOL0],
    };
    verify($results, 'Math::GSL::Randist');
}

sub GSL_RAN_FDIST : Tests(49){
    my $results = {
        'gsl_ran_fdist_pdf(0.01,1,1)' => [3.15158303152268, $TOL0],
        'gsl_ran_fdist_pdf(0.1,1,1)' => [0.915076583717946, $TOL0],
        'gsl_ran_fdist_pdf(0.3,1,1)' => [0.447039756255806, $TOL0],
        'gsl_ran_fdist_pdf(0.5,1,1)' => [0.300105438719035, $TOL0],
        'gsl_ran_fdist_pdf(1,1,1)' => [0.159154943091895, $TOL0],
        'gsl_ran_fdist_pdf(1.5,1,1)' => [0.103959573497823, $TOL0],
        'gsl_ran_fdist_pdf(2,1,1)' => [0.0750263596797588, $TOL0],
        'gsl_ran_fdist_pdf(4,1,1)' => [0.0318309886183791, $TOL0],
        'gsl_ran_fdist_pdf(8,1,1)' => [0.0125043932799598, $TOL0],
        'gsl_ran_fdist_pdf(0,5,2)' => [0, $TOL0],
        'gsl_ran_fdist_pdf(0.01,5,2)' => [0.0226598223892001, $TOL0],
        'gsl_ran_fdist_pdf(0.1,5,2)' => [0.357770876399966, $TOL0],
        'gsl_ran_fdist_pdf(0.3,5,2)' => [0.572583385458872, $TOL0],
        'gsl_ran_fdist_pdf(0.5,5,2)' => [0.511218101851804, $TOL0],
        'gsl_ran_fdist_pdf(1,5,2)' => [0.308000821694066, $TOL0],
        'gsl_ran_fdist_pdf(1.5,5,2)' => [0.194311849388826, $TOL0],
        'gsl_ran_fdist_pdf(2,5,2)' => [0.132070446929294, $TOL0],
        'gsl_ran_fdist_pdf(4,5,2)' => [0.0447719097128847, $TOL0],
        'gsl_ran_fdist_pdf(8,5,2)' => [0.0131721746159774, $TOL0],
        'gsl_ran_fdist_pdf(0,100,5)' => [0, $TOL0],
        'gsl_ran_fdist_pdf(0.01,100,5)' => [1.08229600950106e-33, $TOL0],
        'gsl_ran_fdist_pdf(0.1,100,5)' => [1.38833925012955e-05, $TOL0],
        'gsl_ran_fdist_pdf(0.3,100,5)' => [0.15946150372866, $TOL0],
        'gsl_ran_fdist_pdf(0.5,100,5)' => [0.585835542027015, $TOL0],
        'gsl_ran_fdist_pdf(1,100,5)' => [0.595454389579381, $TOL0],
        'gsl_ran_fdist_pdf(1.5,100,5)' => [0.333690806894543, $TOL0],
        'gsl_ran_fdist_pdf(2,100,5)' => [0.186499977790239, $TOL0],
        'gsl_ran_fdist_pdf(4,100,5)' => [0.03139334253032, $TOL0],
        'gsl_ran_fdist_pdf(8,100,5)' => [0.00384071733507687, $TOL0],
        'gsl_ran_fdist_pdf(0,5,100)' => [0, $TOL0],
        'gsl_ran_fdist_pdf(0.01,5,100)' => [0.00751431369448564, $TOL0],
        'gsl_ran_fdist_pdf(0.1,5,100)' => [0.187745034732677, $TOL0],
        'gsl_ran_fdist_pdf(0.3,5,100)' => [0.580097997537792, $TOL0],
        'gsl_ran_fdist_pdf(0.5,5,100)' => [0.745999911160957, $TOL0],
        'gsl_ran_fdist_pdf(1,5,100)' => [0.59545438957938, $TOL0],
        'gsl_ran_fdist_pdf(1.5,5,100)' => [0.318038149378196, $TOL0],
        'gsl_ran_fdist_pdf(2,5,100)' => [0.146458885506754, $TOL0],
        'gsl_ran_fdist_pdf(4,5,100)' => [0.00429893889201534, $TOL0],
        'gsl_ran_fdist_pdf(8,5,100)' => [3.71706203919573e-06, $TOL0],
        'gsl_ran_fdist_pdf(0,100,100)' => [0, $TOL0],
        'gsl_ran_fdist_pdf(0.01,100,100)' => [9.32516532636391e-69, $TOL0],
        'gsl_ran_fdist_pdf(0.1,100,100)' => [1.83031316130297e-23, $TOL0],
        'gsl_ran_fdist_pdf(0.3,100,100)' => [2.43444613115675e-07, $TOL0],
        'gsl_ran_fdist_pdf(0.5,100,100)' => [0.0110204220067396, $TOL0],
        'gsl_ran_fdist_pdf(1,100,100)' => [1.98973093467947, $TOL0],
        'gsl_ran_fdist_pdf(1.5,100,100)' => [0.172291854230794, $TOL0],
        'gsl_ran_fdist_pdf(2,100,100)' => [0.00275510550168489, $TOL0],
        'gsl_ran_fdist_pdf(4,100,100)' => [1.01328837429194e-10, $TOL0],
        'gsl_ran_fdist_pdf(8,100,100)' => [1.69415186072842e-21, $TOL0],
    };
    verify($results, 'Math::GSL::Randist');
}

sub GSL_RAN_GAMMA : Tests(50){
    my $results = {
        'gsl_ran_gamma_pdf(0,1,2)' => [0.5, $TOL0],
        'gsl_ran_gamma_pdf(0.01,1,2)' => [0.497506239596341, $TOL0],
        'gsl_ran_gamma_pdf(0.1,1,2)' => [0.475614712250357, $TOL0],
        'gsl_ran_gamma_pdf(0.3,1,2)' => [0.430353988212529, $TOL0],
        'gsl_ran_gamma_pdf(0.5,1,2)' => [0.389400391535702, $TOL0],
        'gsl_ran_gamma_pdf(1,1,2)' => [0.303265329856317, $TOL0],
        'gsl_ran_gamma_pdf(1.5,1,2)' => [0.236183276370507, $TOL0],
        'gsl_ran_gamma_pdf(2,1,2)' => [0.183939720585721, $TOL0],
        'gsl_ran_gamma_pdf(4,1,2)' => [0.0676676416183064, $TOL0],
        'gsl_ran_gamma_pdf(8,1,2)' => [0.00915781944436709, $TOL0],
        'gsl_ran_gamma_pdf(0,5,2)' => [0, $TOL0],
        'gsl_ran_gamma_pdf(0.01,5,2)' => [1.29558916561548e-11, $TOL0],
        'gsl_ran_gamma_pdf(0.1,5,2)' => [1.23857997981864e-07, $TOL0],
        'gsl_ran_gamma_pdf(0.3,5,2)' => [9.07777943885803e-06, $TOL0],
        'gsl_ran_gamma_pdf(0.5,5,2)' => [6.33789699765141e-05, $TOL0],
        'gsl_ran_gamma_pdf(1,5,2)' => [0.000789753463167492, $TOL0],
        'gsl_ran_gamma_pdf(1.5,5,2)' => [0.00311374436621274, $TOL0],
        'gsl_ran_gamma_pdf(2,5,2)' => [0.00766415502440505, $TOL0],
        'gsl_ran_gamma_pdf(4,5,2)' => [0.0451117610788709, $TOL0],
        'gsl_ran_gamma_pdf(8,5,2)' => [0.0976834074065823, $TOL0],
        'gsl_ran_gamma_pdf(0,10,2)' => [0, $TOL0],
        'gsl_ran_gamma_pdf(0.01,10,2)' => [2.67772231650023e-27, $TOL0],
        'gsl_ran_gamma_pdf(0.1,10,2)' => [2.55989579162251e-18, $TOL0],
        'gsl_ran_gamma_pdf(0.3,10,2)' => [4.55915261996222e-14, $TOL0],
        'gsl_ran_gamma_pdf(0.5,10,2)' => [4.09348712749271e-12, $TOL0],
        'gsl_ran_gamma_pdf(1,10,2)' => [1.63226162195662e-09, $TOL0],
        'gsl_ran_gamma_pdf(1.5,10,2)' => [4.88694532922619e-08, $TOL0],
        'gsl_ran_gamma_pdf(2,10,2)' => [5.06888559815148e-07, $TOL0],
        'gsl_ran_gamma_pdf(4,10,2)' => [9.54746266219488e-05, $TOL0],
        'gsl_ran_gamma_pdf(8,10,2)' => [0.00661559584552515, $TOL0],
        'gsl_ran_gamma_pdf(0,1,1)' => [1, $TOL0],
        'gsl_ran_gamma_pdf(0.01,1,1)' => [0.990049833749168, $TOL0],
        'gsl_ran_gamma_pdf(0.1,1,1)' => [0.90483741803596, $TOL0],
        'gsl_ran_gamma_pdf(0.3,1,1)' => [0.740818220681718, $TOL0],
        'gsl_ran_gamma_pdf(0.5,1,1)' => [0.606530659712633, $TOL0],
        'gsl_ran_gamma_pdf(1,1,1)' => [0.367879441171442, $TOL0],
        'gsl_ran_gamma_pdf(1.5,1,1)' => [0.22313016014843, $TOL0],
        'gsl_ran_gamma_pdf(2,1,1)' => [0.135335283236613, $TOL0],
        'gsl_ran_gamma_pdf(4,1,1)' => [0.0183156388887342, $TOL0],
        'gsl_ran_gamma_pdf(8,1,1)' => [0.000335462627902512, $TOL0],
        'gsl_ran_gamma_pdf(0,2,0.5)' => [0, $TOL0],
        'gsl_ran_gamma_pdf(0.01,2,0.5)' => [0.0392079469322702, $TOL0],
        'gsl_ran_gamma_pdf(0.1,2,0.5)' => [0.327492301231193, $TOL0],
        'gsl_ran_gamma_pdf(0.3,2,0.5)' => [0.658573963312832, $TOL0],
        'gsl_ran_gamma_pdf(0.5,2,0.5)' => [0.735758882342885, $TOL0],
        'gsl_ran_gamma_pdf(1,2,0.5)' => [0.541341132946451, $TOL0],
        'gsl_ran_gamma_pdf(1.5,2,0.5)' => [0.298722410207184, $TOL0],
        'gsl_ran_gamma_pdf(2,2,0.5)' => [0.146525111109873, $TOL0],
        'gsl_ran_gamma_pdf(4,2,0.5)' => [0.00536740204644019, $TOL0],
        'gsl_ran_gamma_pdf(8,2,0.5)' => [3.60112559101629e-06, $TOL0],
    };
    verify($results, 'Math::GSL::Randist');
}

sub GSL_RAN_GEOMETRIC : Tests(19){
    my $results = {
        'gsl_ran_geometric_pdf(1,0.1)' => [0.1, $TOL0],
        'gsl_ran_geometric_pdf(2,0.1)' => [0.09, $TOL0],
        'gsl_ran_geometric_pdf(3,0.1)' => [0.081, $TOL0],
        'gsl_ran_geometric_pdf(4,0.1)' => [0.0729, $TOL0],
        'gsl_ran_geometric_pdf(5,0.1)' => [0.06561, $TOL0],
        'gsl_ran_geometric_pdf(6,0.1)' => [0.059049, $TOL0],
        'gsl_ran_geometric_pdf(1,0.2)' => [0.2, $TOL0],
        'gsl_ran_geometric_pdf(2,0.2)' => [0.16, $TOL0],
        'gsl_ran_geometric_pdf(3,0.2)' => [0.128, $TOL0],
        'gsl_ran_geometric_pdf(4,0.2)' => [0.1024, $TOL0],
        'gsl_ran_geometric_pdf(5,0.2)' => [0.08192, $TOL0],
        'gsl_ran_geometric_pdf(6,0.2)' => [0.065536, $TOL0],
        'gsl_ran_geometric_pdf(1,0.8)' => [0.8, $TOL0],
        'gsl_ran_geometric_pdf(2,0.8)' => [0.16, $TOL0],
        'gsl_ran_geometric_pdf(3,0.8)' => [0.032, $TOL0],
        'gsl_ran_geometric_pdf(5,0.8)' => [0.00128, $TOL0],
        'gsl_ran_geometric_pdf(9,0.8)' => [2.048e-06, $TOL0],
        'gsl_ran_geometric_pdf(17,0.8)' => [5.24287999999999e-12, $TOL0],
        'gsl_ran_geometric_pdf(33,0.8)' => [3.43597383679999e-23, $TOL0],
    };
    verify($results, 'Math::GSL::Randist');
}

sub GSL_RAN_HYPERGEOMETRIC : Tests(19){
    my $results = {
        'gsl_ran_hypergeometric_pdf(0,10,10,5)' => [0.0162538699690403, $TOL0],
        'gsl_ran_hypergeometric_pdf(1,10,10,5)' => [0.135448916408669, $TOL0],
        'gsl_ran_hypergeometric_pdf(2,10,10,5)' => [0.348297213622291, $TOL0],
        'gsl_ran_hypergeometric_pdf(3,10,10,5)' => [0.348297213622291, $TOL0],
        'gsl_ran_hypergeometric_pdf(4,10,10,5)' => [0.135448916408669, $TOL0],
        'gsl_ran_hypergeometric_pdf(5,10,10,5)' => [0.0162538699690403, $TOL0],
        'gsl_ran_hypergeometric_pdf(0,10,2,5)' => [0, $TOL0],
        'gsl_ran_hypergeometric_pdf(1,10,2,5)' => [0, $TOL0],
        'gsl_ran_hypergeometric_pdf(2,10,2,5)' => [0, $TOL0],
        'gsl_ran_hypergeometric_pdf(3,10,2,5)' => [0.151515151515152, $TOL0],
        'gsl_ran_hypergeometric_pdf(4,10,2,5)' => [0.53030303030303, $TOL0],
        'gsl_ran_hypergeometric_pdf(5,10,2,5)' => [0.318181818181818, $TOL0],
        'gsl_ran_hypergeometric_pdf(0,100,100,32)' => [1.20532309637759e-11, $TOL0],
        'gsl_ran_hypergeometric_pdf(1,100,100,32)' => [5.58990421508451e-10, $TOL0],
        'gsl_ran_hypergeometric_pdf(2,100,100,32)' => [1.22538685972103e-08, $TOL0],
        'gsl_ran_hypergeometric_pdf(4,100,100,32)' => [1.65203099162136e-06, $TOL0],
        'gsl_ran_hypergeometric_pdf(8,100,100,32)' => [0.00125118135998831, $TOL0],
        'gsl_ran_hypergeometric_pdf(16,100,100,32)' => [0.15266154501257, $TOL0],
        'gsl_ran_hypergeometric_pdf(32,100,100,32)' => [1.20532309637759e-11, $TOL0],
    };
    verify($results, 'Math::GSL::Randist');
}

sub GSL_RAN_LOGNORMAL : Tests(27){
    my $results = {
        'gsl_ran_lognormal_pdf(0,0,1)' => [0, $TOL0],
        'gsl_ran_lognormal_pdf(0.01,0,1)' => [0.000990238664959182, $TOL0],
        'gsl_ran_lognormal_pdf(0.1,0,1)' => [0.281590189015268, $TOL0],
        'gsl_ran_lognormal_pdf(0.3,0,1)' => [0.6442032573592, $TOL0],
        'gsl_ran_lognormal_pdf(0.5,0,1)' => [0.627496077115924, $TOL0],
        'gsl_ran_lognormal_pdf(1,0,1)' => [0.398942280401433, $TOL0],
        'gsl_ran_lognormal_pdf(1.5,0,1)' => [0.24497365171051, $TOL0],
        'gsl_ran_lognormal_pdf(2,0,1)' => [0.156874019278981, $TOL0],
        'gsl_ran_lognormal_pdf(4,0,1)' => [0.0381534565118865, $TOL0],
        'gsl_ran_lognormal_pdf(0,1,2)' => [0, $TOL0],
        'gsl_ran_lognormal_pdf(0.01,1,2)' => [0.392916904062993, $TOL0],
        'gsl_ran_lognormal_pdf(0.1,1,2)' => [0.510234855730895, $TOL0],
        'gsl_ran_lognormal_pdf(0.3,1,2)' => [0.362293752685404, $TOL0],
        'gsl_ran_lognormal_pdf(0.5,1,2)' => [0.278794046292731, $TOL0],
        'gsl_ran_lognormal_pdf(1,1,2)' => [0.17603266338215, $TOL0],
        'gsl_ran_lognormal_pdf(1.5,1,2)' => [0.127233055814411, $TOL0],
        'gsl_ran_lognormal_pdf(2,1,2)' => [0.0985685803440131, $TOL0],
        'gsl_ran_lognormal_pdf(4,1,2)' => [0.0489462270031511, $TOL0],
        'gsl_ran_lognormal_pdf(0,2,1.5)' => [0, $TOL0],
        'gsl_ran_lognormal_pdf(0.01,2,1.5)' => [0.00163779365635777, $TOL0],
        'gsl_ran_lognormal_pdf(0.1,2,1.5)' => [0.0434715176417356, $TOL0],
        'gsl_ran_lognormal_pdf(0.3,2,1.5)' => [0.0905692877679183, $TOL0],
        'gsl_ran_lognormal_pdf(0.5,2,1.5)' => [0.106134989073751, $TOL0],
        'gsl_ran_lognormal_pdf(1,2,1.5)' => [0.109340049783996, $TOL0],
        'gsl_ran_lognormal_pdf(1.5,2,1.5)' => [0.100773689285206, $TOL0],
        'gsl_ran_lognormal_pdf(2,2,1.5)' => [0.0909835807536498, $TOL0],
        'gsl_ran_lognormal_pdf(4,2,1.5)' => [0.0611518855374068, $TOL0],
    };
    verify($results, 'Math::GSL::Randist');
}

sub GSL_RAN_MULTINOMIAL : Tests(10){
    my $self = shift;
    my $prob = [ .25, .25, .5 ];
    my $N = 100;
    my $counts = [100, 112, 220];

    lives_ok( sub{ gsl_ran_multinomial($self->{rng}->raw, $prob, $N) }, 'gsl_ran_multinomial');
    lives_ok( sub{ gsl_ran_multinomial_pdf($counts,$prob ) }, 'gsl_ran_multinomial_pdf');
    lives_ok( sub{ gsl_ran_multinomial_lnpdf($counts,$prob ) }, 'gsl_ran_multinomial_lnpdf');

    ok_similar(sum(@{gsl_ran_multinomial($self->{rng}->raw, $prob, $N )}), 100, 'gsl_ran_multinomial(N,p)=N');
    my $results = {
        'gsl_ran_multinomial_pdf([1,1,2,4],[0.25,0.25,0.25,0.25])' => [0.01281738, $TOL0],
        'gsl_ran_multinomial_pdf([199,123,12,123],[0.25,0.25,0.25,0.25])' => [1.78547e-48, $TOL0],
        'gsl_ran_multinomial_pdf([0,0,0,1,0],[0.1,0.1,0.1,0.5,0.1])' => [0.55555556, 0.0001],
        'gsl_ran_multinomial_pdf([5,6,7,6,5,5,5],[0.1,0.15,0.2,0.15,0.1,0.1,0.1])' => [3.807253e-05, $TOL0],
        'gsl_ran_multinomial_pdf([1,1,2,4],[0.5,0.2,0.2,0.1])' => [0.000336, $TOL0],
        'gsl_ran_multinomial_pdf([2,1,2,4],[0.5,0.2,0.2,0.1])' => [0.000756, $TOL0],
    };
    verify($results, 'Math::GSL::Randist');
}

sub GSL_RAN_NEGATIVE_BINOMIAL : Tests(16){
    my $results = {
        'gsl_ran_negative_binomial_pdf(0,0.5,100)' => [7.8886090522101e-31, $TOL0],
        'gsl_ran_negative_binomial_pdf(1,0.5,100)' => [3.94430452610504e-29, $TOL0],
        'gsl_ran_negative_binomial_pdf(4,0.5,100)' => [2.17985687420687e-25, $TOL0],
        'gsl_ran_negative_binomial_pdf(9,0.5,100)' => [6.02645956264326e-21, $TOL0],
        'gsl_ran_negative_binomial_pdf(16,0.5,100)' => [1.80317150607037e-16, $TOL0],
        'gsl_ran_negative_binomial_pdf(25,0.5,100)' => [2.4460597044091e-12, $TOL0],
        'gsl_ran_negative_binomial_pdf(50,0.5,100)' => [9.40208720724083e-06, $TOL0],
        'gsl_ran_negative_binomial_pdf(74,0.5,100)' => [0.00499550380756991, $TOL0],
        'gsl_ran_negative_binomial_pdf(100,0.5,100)' => [0.0281742395046282, $TOL0],
        'gsl_ran_negative_binomial_pdf(0,0.1,10)' => [1e-10, $TOL0],
        'gsl_ran_negative_binomial_pdf(1,0.1,10)' => [8.99999999999999e-10, $TOL0],
        'gsl_ran_negative_binomial_pdf(2,0.1,10)' => [4.45499999999998e-09, $TOL0],
        'gsl_ran_negative_binomial_pdf(3,0.1,10)' => [1.6038e-08, $TOL0],
        'gsl_ran_negative_binomial_pdf(5,0.1,10)' => [1.18216098e-07, $TOL0],
        'gsl_ran_negative_binomial_pdf(7,0.1,10)' => [5.47171653600001e-07, $TOL0],
        'gsl_ran_negative_binomial_pdf(10,0.1,10)' => [3.22102169395578e-06, $TOL0],
    };
    verify($results, 'Math::GSL::Randist');
}

sub GSL_RAN_GAUSSIAN : Tests(9){
    my $results = {
        'gsl_ran_gaussian_pdf(1,1)' => [0.241970724519143, $TOL0],
        'gsl_ran_gaussian_pdf(2,1)' => [0.0539909665131881, $TOL0],
        'gsl_ran_gaussian_pdf(4,1)' => [0.000133830225764885, $TOL0],
        'gsl_ran_gaussian_pdf(8,1)' => [5.05227108353689e-15, $TOL0],
        'gsl_ran_gaussian_pdf(100,1)' => [0, $TOL0],
        'gsl_ran_gaussian_pdf(5e-04,0.005)' => [79.3905094954024, $TOL0],
        'gsl_ran_gaussian_pdf(0.005,0.005)' => [48.3941449038287, $TOL0],
        'gsl_ran_gaussian_pdf(0.05,0.005)' => [1.53891972534128e-20, $TOL0],
        'gsl_ran_gaussian_pdf(0.5,0.005)' => [0, $TOL0],
    };
    verify($results, 'Math::GSL::Randist');
}

sub GSL_RAN_POISSON : Tests(20){
    my $results = {
        'gsl_ran_poisson_pdf(1,1)' => [0.367879441171442, $TOL0],
        'gsl_ran_poisson_pdf(2,1)' => [0.183939720585721, $TOL0],
        'gsl_ran_poisson_pdf(4,1)' => [0.0153283100488101, $TOL0],
        'gsl_ran_poisson_pdf(8,1)' => [9.12399407667269e-06, $TOL0],
        'gsl_ran_poisson_pdf(16,1)' => [1.75827145013025e-14, $TOL0],
        'gsl_ran_poisson_pdf(1,2)' => [0.270670566473225, $TOL0],
        'gsl_ran_poisson_pdf(2,2)' => [0.270670566473225, $TOL0],
        'gsl_ran_poisson_pdf(4,2)' => [0.0902235221577418, $TOL0],
        'gsl_ran_poisson_pdf(8,2)' => [0.000859271639597541, $TOL0],
        'gsl_ran_poisson_pdf(16,2)' => [4.23907766109221e-10, $TOL0],
        'gsl_ran_poisson_pdf(1,4)' => [0.0732625555549367, $TOL0],
        'gsl_ran_poisson_pdf(2,4)' => [0.146525111109873, $TOL0],
        'gsl_ran_poisson_pdf(4,4)' => [0.195366814813165, $TOL0],
        'gsl_ran_poisson_pdf(8,4)' => [0.0297701813048632, $TOL0],
        'gsl_ran_poisson_pdf(16,4)' => [3.75977919070804e-06, $TOL0],
        'gsl_ran_poisson_pdf(1,10)' => [0.000453999297624848, $TOL0],
        'gsl_ran_poisson_pdf(2,10)' => [0.00226999648812424, $TOL0],
        'gsl_ran_poisson_pdf(4,10)' => [0.0189166374010354, $TOL0],
        'gsl_ran_poisson_pdf(8,10)' => [0.11259903214902, $TOL0],
        'gsl_ran_poisson_pdf(16,10)' => [0.0216987935191775, $TOL0],
    };
    verify($results, 'Math::GSL::Randist');
}

sub GSL_RAN_TDIST : Tests(15){
    my $results = {
        'gsl_ran_tdist_pdf(1,1)' => [0.159154943091895, $TOL0],
        'gsl_ran_tdist_pdf(2,1)' => [0.0636619772367581, $TOL0],
        'gsl_ran_tdist_pdf(4,1)' => [0.0187241109519877, $TOL0],
        'gsl_ran_tdist_pdf(8,1)' => [0.00489707517205832, $TOL0],
        'gsl_ran_tdist_pdf(100,1)' => [3.18278058377953e-05, $TOL0],
        'gsl_ran_tdist_pdf(1,5)' => [0.219679797350981, $TOL0],
        'gsl_ran_tdist_pdf(2,5)' => [0.0650903103262165, $TOL0],
        'gsl_ran_tdist_pdf(4,5)' => [0.00512372705191791, $TOL0],
        'gsl_ran_tdist_pdf(8,5)' => [0.000144443032695639, $TOL0],
        'gsl_ran_tdist_pdf(100,5)' => [4.73797310904554e-11, $TOL0],
        'gsl_ran_tdist_pdf(1,999)' => [0.241849668546797, $TOL0],
        'gsl_ran_tdist_pdf(2,999)' => [0.0540852680348771, $TOL0],
        'gsl_ran_tdist_pdf(4,999)' => [0.00014142440879592, $TOL0],
        'gsl_ran_tdist_pdf(8,999)' => [1.30892039542662e-14, $TOL0],
        'gsl_ran_tdist_pdf(100,999)' => [0, $TOL0],
    };
    verify($results, 'Math::GSL::Randist');
}

sub GSL_RAN_FLAT : Tests(8){
    my $results = {
        'gsl_ran_flat_pdf(0.001,0,1)' => [1, $TOL0],
        'gsl_ran_flat_pdf(0.25,0,1)' => [1, $TOL0],
        'gsl_ran_flat_pdf(0.5,0,1)' => [1, $TOL0],
        'gsl_ran_flat_pdf(0.75,0,1)' => [1, $TOL0],
        'gsl_ran_flat_pdf(0.999,0,1)' => [1, $TOL0],
        'gsl_ran_flat_pdf(0.001,0,100)' => [0.01, $TOL0],
        'gsl_ran_flat_pdf(10,0,100)' => [0.01, $TOL0],
        'gsl_ran_flat_pdf(20,0,100)' => [0.01, $TOL0],
    };
    verify($results, 'Math::GSL::Randist');
}

sub GSL_RAN_WEIBULL : Tests(24){
    my $results = {
        'gsl_ran_weibull_pdf(0,1,2)' => [0, $TOL0],
        'gsl_ran_weibull_pdf(0.01,1,2)' => [0.0199980000999967, $TOL0],
        'gsl_ran_weibull_pdf(0.1,1,2)' => [0.198009966749834, $TOL0],
        'gsl_ran_weibull_pdf(0.3,1,2)' => [0.548358711162737, $TOL0],
        'gsl_ran_weibull_pdf(0.5,1,2)' => [0.778800783071405, $TOL0],
        'gsl_ran_weibull_pdf(1,1,2)' => [0.735758882342885, $TOL0],
        'gsl_ran_weibull_pdf(1.5,1,2)' => [0.316197673685593, $TOL0],
        'gsl_ran_weibull_pdf(2,1,2)' => [0.0732625555549367, $TOL0],
        'gsl_ran_weibull_pdf(0,2,1)' => [0.5, $TOL0],
        'gsl_ran_weibull_pdf(0.01,2,1)' => [0.497506239596341, $TOL0],
        'gsl_ran_weibull_pdf(0.1,2,1)' => [0.475614712250357, $TOL0],
        'gsl_ran_weibull_pdf(0.3,2,1)' => [0.430353988212529, $TOL0],
        'gsl_ran_weibull_pdf(0.5,2,1)' => [0.389400391535702, $TOL0],
        'gsl_ran_weibull_pdf(1,2,1)' => [0.303265329856317, $TOL0],
        'gsl_ran_weibull_pdf(1.5,2,1)' => [0.236183276370507, $TOL0],
        'gsl_ran_weibull_pdf(2,2,1)' => [0.183939720585721, $TOL0],
        'gsl_ran_weibull_pdf(0,3,1.5)' => [0, $TOL0],
        'gsl_ran_weibull_pdf(0.01,3,1.5)' => [0.028861958438475, $TOL0],
        'gsl_ran_weibull_pdf(0.1,3,1.5)' => [0.0907332244395488, $TOL0],
        'gsl_ran_weibull_pdf(0.3,3,1.5)' => [0.15319211316322, $TOL0],
        'gsl_ran_weibull_pdf(0.5,3,1.5)' => [0.190697229045737, $TOL0],
        'gsl_ran_weibull_pdf(1,3,1.5)' => [0.238138363587375, $TOL0],
        'gsl_ran_weibull_pdf(1.5,3,1.5)' => [0.248261125479615, $TOL0],
        'gsl_ran_weibull_pdf(2,3,1.5)' => [0.236877822282856, $TOL0],
    };
    verify($results, 'Math::GSL::Randist');
}

Test::Class->runtests;
