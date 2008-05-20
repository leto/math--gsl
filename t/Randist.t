use Test::More 'no_plan';
use Math::GSL;
use Math::GSL::Randist qw/:all/;
use Math::GSL::RNG qw/:all/;
use Data::Dumper;
use strict;
use warnings;

{
    my $gsl = Math::GSL->new;
    my $results = { 
                    'Math::GSL::Randist::gsl_ran_hypergeometric_pdf(1,3,5,6)' => 0.107142857142857,
                    'Math::GSL::Randist::gsl_ran_laplace_pdf(5,10)'           => 0.0303265329856317, 
                    'Math::GSL::Randist::gsl_ran_gaussian_pdf(2,3.14)'        => 0.10372528979964, 
                };
    $gsl->verify_results($results);
}
{
	my $rng = gsl_rng_alloc($gsl_rng_default);
    ok( !$@, join (" ", $@) );
    isa_ok( $rng, 'Math::GSL::RNG' );
}

{
	my $rng = gsl_rng_alloc($gsl_rng_default);
	my ($i,$j);
	my $x= [0..9];

	my @count = map { [(0) x 10] } (1 .. 10);
	for($i=0; $i<100000; $i++)
	{
		$x = gsl_ran_shuffle ($rng, $x, 10, 4);
		map { $count[ $x->[$_] ][$_]++ } (0 .. 9);
	}
	for($i=0; $i<10; $i++)
	{
		for($j=0; $j<10; $j++)
		{
			my $d = abs($count[$i][$j] - 10000);
			my $sigma = $d / 10000;
			if($sigma>5 && $d>1)
			{
				print "Error, expected:0.1 but observed" . $count[$i][$j]/100000;	
			}
		}
	}
	print "gsl_ran_shuffle on {0, 1, 2, 3, 4, 5, 6, 7, 8, 9}";
}	
