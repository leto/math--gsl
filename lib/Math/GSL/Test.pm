package Math::GSL::Test;
use lib qw{lib blib/lib blib/arch};
use base qw(Exporter);
use base qw(DynaLoader);
use strict;
use warnings;
use Test::More;
use Math::GSL::Errno qw/:all/;
use Math::GSL::Machine qw/:all/;
use Math::GSL::Const qw/:all/;
use Math::GSL::Sys qw/gsl_nan gsl_isnan gsl_isinf/;
use Data::Dumper;
use Carp qw/croak/;
our @EXPORT = qw();
our @EXPORT_OK = qw( 
                     is_similar ok_similar 
                     ok_similar_relative
                     is_similar_relative 
                     verify verify_results 
                     is_windows 
                     ok_status is_status_ok
);
use constant GSL_IS_WINDOWS =>  ($^O =~ /MSWin32/i)  ?  1 : 0 ;

=head1 NAME

Math::GSL::Test - Assertions and such

=head1 SYNOPSIS


    use Math::GSL::Test qw/:all/;
    ok_similar($x,$y, $msg, $eps);

=cut

our %EXPORT_TAGS = ( all => \@EXPORT_OK,);

sub _dump_result($)
{
    my $r=shift;
    diag sprintf( "result->err: %.18g\n", $r->{err});
    diag sprintf( "result->val: %.18g\n", $r->{val});
}

=head2 is_windows()

Returns true if current system is Windows-like.

=cut

sub is_windows() { GSL_IS_WINDOWS }

=head2 is_similar($x,$y;$eps,$similarity_function)
    
    is_similar($x,$y);
    is_similar($x, $y, 1e-7);
    is_similar($x,$y, 1e-3, sub { ... } );

Return true if $x and $y are within $eps of each other, i.e. 

    abs($x-$y) <= $eps 

If passed a code reference $similarity_function, it will pass $x and $y as parameters to it and 
will check to see if 

    $similarity_function->($x,$y_) <= $eps

The default value of $eps is 1e-8. Don't try sending anything to the Moon with this value...

=cut

sub is_similar {
    my ($x,$y, $eps, $similarity_function) = @_;
    local $Test::Builder::Level = $Test::Builder::Level + 1;
    $eps ||= 1e-8;
    if (ref $x eq 'ARRAY' && ref $y eq 'ARRAY') {
        if ( $#$x != $#$y ){
            diag "is_similar(): items differ in length, $#$x != $#$y !!!";
            return 0;
        } else {
            map { 
                    my $delta = (gsl_isnan($x->[$_]) or gsl_isnan($y->[$_])) ? gsl_nan() : abs($x->[$_] - $y->[$_]);
                    if($delta > $eps){
                        diag "\n\tElements start differing at index $_, delta = $delta\n";
                        diag qq{\t\t\$x->[$_] = } . $x->[$_] . "\n";
                        diag qq{\t\t\$y->[$_] = } . $y->[$_] . "\n";
                        return 0;
                    }
                } (0..$#$x);
            return 1;
        }
    } else {
        if( ref $similarity_function eq 'CODE') {
               $similarity_function->($x,$y) <= $eps ? return 1 : return 0;
        } elsif( defined $x && defined $y) { 
            my $delta = (gsl_isnan($x) or gsl_isnan($y)) ? gsl_nan() : abs($x-$y);
            $delta > $eps ? diag qq{\t\t\$x=$x\n\t\t\$y=$y\n\t\tdelta=$delta\n} && return 0 : return 1;
        } else {
            return 0;
        }
    }
}

# this is a huge hack
sub verify_results
{
    my ($results,$class, $eps) = @_;
    # GSL uses a factor of 100
    my $factor   = 100;
    my ($x,$res);

    local $Test::Builder::Level = $Test::Builder::Level + 1;

    # If no epsilon is passed in, default to TOL3 from the GSL test suite
    $eps    ||= 2048*$Math::GSL::Machine::GSL_DBL_EPSILON; # TOL3

    croak "Usage: verify_results(%results, \$class)" unless $class;
    while (my($code,$expected)=each %$results){
        my $r        = Math::GSL::SF::gsl_sf_result_struct->new;
        my $status   = eval qq{${class}::$code};

        ok(0, qq{'$code' died} ) if !defined $status;
        
        if ( defined $r && $code =~ /_e\(.*\$r/) {
            $x   = $r->{val};

            # if $eps=0, give some default
            $eps = $factor*$r->{err} || 1e-8;
            $res = abs($x-$expected);

            if ($ENV{DEBUG} ){
                _dump_result($r);
                #print "got $code = $x\n";
                diag sprintf("expected   : %.18g\n", $expected);
                diag sprintf("difference : %.18g\n", $res);
                diag sprintf("unexpected error of %.18g\n", $res-$eps) if ($res-$eps>0);
            }
            if (gsl_isnan($x)) {
                    ok( gsl_isnan($expected), sprintf("'$expected'?='$x' (%16b ?= %16b)", $expected, $x) );
            } elsif(gsl_isinf($x)) { 
                    ok( gsl_isinf($expected), sprintf("'$expected'?='$x' (%16b ?= %16b)", $expected, $x) );
            } else {
                    cmp_ok( $res,'<=', $eps, "$code ?= $x,\nres= +-$res, eps=$eps" );
            }
        }
    }
}

=head2 verify( $results, $class) 

Takes a hash reference of key/value pairs where the keys are bits of code, which when evaluated should
be within some tolerance of the value. For example:

    my $results = { 
                    'gsl_cdf_ugaussian_P(2.0)'        => [ 0.977250, 1e-5 ],
                    'gsl_cdf_ugaussian_Q(2.0)'        => [ 0.022750, 1e-7 ],
                    'gsl_cdf_ugaussian_Pinv(0.977250)'=> [ 2.000000 ],
                  };
    verify($results, 'Math::GSL::CDF');

When no tolerance is given, a value of 1e-8 = 0.00000001 is used. One
may use $GSL_NAN and $GSL_INF in comparisons and this routine will
use the gsl_isnan() and gsl_isinf() routines to compare them.


Note: Needing to pass in the class name is honky. This may change.

=cut

sub verify
{
    my ($results,$class) = @_;
    local $Test::Builder::Level = $Test::Builder::Level + 1;
    croak "Usage: verify(%results, \$class)" unless $class;
    while (my($code,$result)=each %$results){
        my $x = eval qq{${class}::$code};
        ok(0, $@) if $@;

        croak(__PACKAGE__." : $result is not an array reference!") unless ref $result;
        my($expected,$eps)=@$result;
        $eps ||= 1e-8;

        if (gsl_isnan($x)) {
               ok( gsl_isnan($expected), "'$expected'?='$x'" );
        } elsif(gsl_isinf($x)) {
               ok( gsl_isinf($expected), "'$expected'?='$x'" );
        } else {
            my $res = abs($x - $expected);
            ok( $res <= $eps, "$code ?= $x,\nres= +-$res, eps=$eps" );    
        }
    }
}

=head2 ok_status( $got_status; $expected_status )

    ok_status( $status );                  # defaults to checking for $GSL_SUCCESS

    ok_status( $status, $GSL_ECONTINUE );

Pass a test if the GSL status codes match, with a default expected status of $GSL_SUCCESS. This
function also stringifies the status codes into meaningful messages when it fails.

=cut

sub ok_status {
    my ($got, $expected, $msg ) = @_;
    local $Test::Builder::Level = $Test::Builder::Level + 1;
    $expected ||= $GSL_SUCCESS;
    my $strerr = $got ? gsl_strerror(int($got)) : '';

    ok( defined $got && $got == $expected, $msg ? "$msg: " .$strerr : $strerr );
}

=head2 is_status_ok($status)

    is_status_ok( $status );

Return true if $status is $GSL_SUCCESS, false otherwise.

=cut

sub is_status_ok {
    my ($got) = shift;
    local $Test::Builder::Level = $Test::Builder::Level + 1;
    return ( defined $got && $got == $GSL_SUCCESS ) ? 1 : 0 ;
}

=head2 ok_similar( $x, $y, $msg, $eps)

    ok_similar( $x, $y);
    ok_similar( $x, $y, 'reason');
    ok_similar( $x, $y, 'reason', 1e-4);

Pass a test if is_similar($x,$y,$msg,$eps) is true, otherwise fail.

=cut

sub ok_similar {
    my ($x,$y, $msg, $eps) = @_;
    local $Test::Builder::Level = $Test::Builder::Level + 1;
    ok(is_similar($x,$y,$eps), $msg);
}

=head2 is_similar_relative( $x, $y, $msg, $eps )

    is_similar_relative($x, $y, $eps );

Returns true if $x has a relative error with repect to $y less than $eps. The
current default for $eps is the same as is_similar(), i.e. 1e-8. This doesn't
seem very useful. What should the default be?

=cut

sub is_similar_relative {
    my ($x,$y, $eps) = @_;
    local $Test::Builder::Level = $Test::Builder::Level + 1;
    return is_similar($x,$y,$eps, sub { abs( ($_[0] - $_[1])/abs($_[1]) ) } );
}

=head2 ok_similar_relative( $x, $y, $msg, $eps )

    ok_similar_relative($x, $y, $msg, $eps );

Pass a test if $x has a relative error with repect to $y less than $eps.

=cut

sub ok_similar_relative {
    my ($x,$y, $msg, $eps,) = @_;
    local $Test::Builder::Level = $Test::Builder::Level + 1;
    ok(is_similar_relative($x,$y,$eps), $msg );
}

1;
