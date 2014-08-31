#!perl -T
package Math::GSL::GSL::Test;
use base q{Test::Class};
use Test::More tests => 21;
use Test::Exception;
use Test::Taint;
use Math::GSL::SF      qw/:all/;
use Math::GSL::BLAS    qw/:all/;
use Math::GSL::Vector  qw/:all/;
use Math::GSL::Complex qw/:all/;
use Math::GSL::Matrix  qw/:all/;
use Math::GSL::CBLAS   qw/:all/;
use Math::GSL          qw/:all/;
use Math::GSL::Test    qw/:all/;
use Math::GSL::Errno   qw/:all/;
use Math::GSL qw/gsl_version/;
use Data::Dumper;
use strict;

BEGIN { gsl_set_error_handler_off(); }

sub make_fixture : Test(setup) {
}

sub teardown : Test(teardown) {
}

sub TEST_STUFF : Tests { 
    {
        my $results = { 
                    q{is_similar(undef, [1,2,3]) }                        => [ 0 ],
                    q{is_similar(0.10005,0.1000501, 1e-5)}                => [ 1 ],
                    q{is_similar(0.10005,0.1000501, 1e-7)}                => [ 0 ],
                    q{is_similar([1,2,3    ], [1,2,3.001])}               => [ 0 ], 
                    q{is_similar([1,2,3.001], [1,2,3.001])}               => [ 1 ], 
                    q{is_similar([1,2,3.001], [1,2,3.001],1e-2)}          => [ 1 ], 
                    q{is_similar([1,2,3.0010001], [1,2,3.0010002], 1e-5)} => [ 1 ], 
                    q{is_similar([1,2,3.0010001], [1,2,3.0010002] )}      => [ 0 ], 
                    q{is_similar_relative( 1e8, 1e8 + 1, 1e-7) }          => [ 1 ],
                    q{is_similar_relative( 1e8, 1e8 + 1e3, 1e-7) }        => [ 0 ],
                    q{is_status_ok($GSL_SUCCESS)}                         => [ 1 ],
                    q{is_status_ok($GSL_EDOM)}                            => [ 0 ],
        };

        verify($results, 'Math::GSL');
    }
    {
            ok_status(0,$GSL_SUCCESS);
            ok_status(0);
    }
    {
        my $fh = gsl_fopen('mrfuji','w');
        ok(defined $fh, 'gsl_fopen can create files');
        ok_status(gsl_fclose($fh));
    }
    {
        my $fh = gsl_fopen('mrfuji','r');
        ok(defined $fh, 'gsl_fopen can read files');
        ok_status(gsl_fclose($fh));
        unlink 'mrfuji' if -e 'mrfuji';
    }
    {
        taint_checking_ok();
        my $file = "foo";
        taint($file);
        dies_ok(
                sub { my $fh = gsl_fopen($file, 'w'); },
                "gsl_fopen doesn't work with tainted variables");
    }


}

sub TEST_VERSION : Tests { 
    isa_ok(gsl_version(), "version");
}

Test::Class->runtests;
