package Math::GSL::Statistics::Test;
use base q{Test::Class};
use Test::More;
use Math::GSL::Statistics qw/:all/;
use Math::GSL qw/:all/;
use strict;

sub make_fixture : Test(setup) {
 my $self = shift;
 $self->{data} =   
  [17, 18, 16, 18, 12,
   20, 18, 20, 20, 22,
   20, 10, 8, 12, 16,
   16, 18, 20, 18, 21];
 $self->{datab} = 
  [19, 20, 22, 24, 10,
   25, 20, 22, 21, 23,
   20, 10, 12, 14, 12,
   20, 22, 24, 23, 17];
}

sub teardown : Test(teardown) {
}

sub GSL_STATS_MEAN : Tests {
 my $x = gsl_stats_mean([2,3,4, 5], 1, 4);
 ok ($x eq 3.5);
}

sub GSL_STATS_VARIANCE : Tests {
 my $x = gsl_stats_variance([2,3,4, 5], 1, 4);
 ok ($x eq 5/3);
}

sub GSL_STATS_SD : Tests {
 my $self = shift;
 my $x = gsl_stats_sd($self->{data}, 1, 20);
 ok($x eq 3.79750610685209);
}

sub GSL_STATS_ABSDEV : Tests {
 my $self = shift;
 my $x = gsl_stats_absdev($self->{data},1, 20);
 ok($x eq 2.9); 
}

sub GSL_STATS_SKEW : Tests {
 my $self = shift;
 my $x = gsl_stats_skew($self->{data}, 1, 20);
 ok($x eq -0.909355923168064);
}

sub GSL_STATS_KURTOSIS : Tests {
 my $self = shift;
 my $x = gsl_stats_kurtosis($self->{data}, 1, 20);
 ok(is_similar_relative($x, -0.233692524908094));
}

sub GSL_STATS_COVARIANCE : Tests {
 my $self = shift;
 my $x = gsl_stats_covariance($self->{data}, 1, $self->{datab}, 1, 20); 
 ok(is_similar_relative($x, 14.5263157894737));
}

sub GSL_STATS_CORRELATION : Tests {
 my $self = shift;
 my $x = gsl_stats_correlation($self->{data}, 1, $self->{datab}, 1, 20);
 ok(is_similar_relative($x, 0.793090350710101)); 
}

sub GSL_STATS_PVARIANCE : Tests {
 my $self = shift;
 my $x = gsl_stats_pvariance($self->{data}, 1, 20, $self->{datab}, 1, 20); 
 ok(is_similar_relative($x, 18.8421052631579));
}

sub GSL_STATS_TTEST : Tests {
 my $self = shift;
 my $x = gsl_stats_ttest($self->{data}, 1, 20, $self->{datab}, 1, 20); 
 ok(is_similar_relative($x, -1.45701922702927));
}

sub GSL_STATS_MAX : Tests { 
 my $self = shift;
 my $x = gsl_stats_max($self->{data}, 1, 20); 
 ok(is_similar_relative($x, 22));
}

sub GSL_STATS_MIN : Tests {
 my $self = shift;
 my $x = gsl_stats_min($self->{data}, 1, 20); 
 ok(is_similar_relative($x, 8));
}

sub GSL_STATS_MINMAX : Tests {
 my $self = shift;
 my ($min, $max) = gsl_stats_minmax($self->{data}, 1, 20); 
 ok(is_similar_relative($max, 22));
 ok(is_similar_relative($min, 8));
}

sub GSL_STATS_MAX_INDEX : Tests {
 my $self = shift;
 my $x = gsl_stats_max_index($self->{data}, 1, 20); 
 ok(is_similar_relative($x, 9));
}

sub GSL_STATS_MIN_INDEX : Tests {
 my $self = shift;
 my $x = gsl_stats_min_index($self->{data}, 1, 20); 
 ok(is_similar_relative($x, 12));
}
1;
