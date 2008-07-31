use Test::More 'no_plan';
use Math::GSL qw/:all/;
use Math::GSL::SF qw/:all/;
use Math::GSL::Errno qw/:all/;
use Data::Dumper;
use strict;

{
    my $results = { 
                q{is_similar(undef, [1,2,3]) } => 0, 
                q{is_similar(0.10005,0.1000501, 1e-5)}  => 1,
                q{is_similar(0.10005,0.1000501, 1e-7)}  => 0,
                q{is_similar([1,2,3    ], [1,2,3.001])} => 0, 
                q{is_similar([1,2,3.001], [1,2,3.001])} => 1, 
                q{is_similar([1,2,3.001], [1,2,3.001],1e-2)} => 1, 
                q{is_similar([1,2,3.0010001], [1,2,3.0010002], 1e-5)} => 1, 
                q{is_similar([1,2,3.0010001], [1,2,3.0010002] )}      => 0, 
                q{is_similar_relative( 1e8, 1e8 + 1, 1e-7) } => 1,
                q{is_similar_relative( 1e8, 1e8 + 1e3, 1e-7) } => 0,
              };

    verify($results, 'Math::GSL');
}
{
        ok_status(0,$GSL_SUCCESS);
        ok_status(0);
}
