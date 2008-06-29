use Test::More 'no_plan';
use Math::GSL qw/:all/;
use Math::GSL::SF qw/:all/;
use Data::Dumper;
use strict;

my $results = { 
                q{is_valid_double(420)}       => 1,
                q{is_valid_double(0)}         => 1,
                q{is_valid_double(-1e5)}      => 1,
                q{is_valid_double(1e-5)}      => 1,
                q{is_valid_double(1e309)}     => 0,
                q{is_valid_double(1e-309)}    => 0,
                q{is_valid_double('nan')}     => 0,
                q{is_valid_double('inf')}     => 0,
                q{is_valid_float(0)}          => 1,
                q{is_valid_float(3.14)}       => 1,
                q{is_valid_float(-2e24)}      => 1,
                q{is_valid_float(1e39)}       => 0,
                q{is_valid_float()}           => 0,
                q{is_valid_float('foo')}      => 0,
                q{is_valid_float('e')}        => 0,
                q{is_valid_float('nan')}      => 0,
                q{is_valid_float('inf')}      => 0,
                q{is_valid_float(0e0)}        => 1,
                q{is_valid_float(0e1)}        => 1,
                q{is_valid_float(1E1)}        => 1,
                q{is_valid_float(1E1)}        => 1,
                q{is_valid_float(1e0)}        => 1,
                q{is_valid_float(1e0)}        => 1,
                q{is_valid_float('0e0')}      => 1,
                q{is_similar(5,5)}            => 1,
                q{is_similar(5,4)}            => 0,
                q{is_similar(0.10005,0.1000501, 1e-5)}  => 1,
                q{is_similar(0.10005,0.1000501, 1e-7)}  => 0,
                q{is_similar([1,2,3    ], [1,2,3.001])} => 0, 
                q{is_similar([1,2,3.001], [1,2,3.001])} => 1, 
                q{is_similar([1,2,3.0010001], [1,2,3.0010002], 1e-5)} => 1, 
                q{is_similar([1,2,3.0010001], [1,2,3.0010002] )}      => 0, 
              };

verify_results($results, 'Math::GSL');

