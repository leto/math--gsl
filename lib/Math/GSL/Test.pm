package Math::GSL::Test;
use base qw(Exporter);
use base qw(DynaLoader);
use strict;
use warnings;
use Test::More;
use Math::GSL::Errno qw/:all/;
use Math::GSL::Machine qw/:all/;
use Math::GSL::Const qw/:all/;
use Math::GSL::Sys qw/gsl_nan gsl_isnan gsl_isinf/;
use Carp qw/croak/;
our @EXPORT = qw();
our @EXPORT_OK = qw( 
                     is_similar ok_similar 
                     ok_similar_relative
                     is_similar_relative 
                     verify verify_results 
                     is_windows 
                     ok_status
);
use constant GSL_IS_WINDOWS =>  ($^O =~ /MSWin32/i)  ?  1 : 0 ;

our %EXPORT_TAGS = ( 
                     all => \@EXPORT_OK,
                   );

sub _dump_result($)
{
    my $r=shift;
    printf "result->err: %.18g\n", $r->{err};
    printf "result->val: %.18g\n", $r->{val};
}

sub is_windows() { GSL_IS_WINDOWS }

sub is_similar {
    my ($x,$y, $eps, $similarity_function) = @_;
    $eps ||= 1e-8;
    if (ref $x eq 'ARRAY' && ref $y eq 'ARRAY') {
        if ( $#$x != $#$y ){
            warn "is_similar(): argument of different lengths, $#$x != $#$y !!!";
            return 0;
        } else {
            map { 
                    my $delta = (gsl_isnan($x->[$_]) or gsl_isnan($y->[$_])) ? gsl_nan() : abs($x->[$_] - $y->[$_]);
                    if($delta > $eps){
                        warn "\n\tElements start differing at index $_, delta = $delta\n";
                        warn qq{\t\t\$x->[$_] = } . $x->[$_] . "\n";
                        warn qq{\t\t\$y->[$_] = } . $y->[$_] . "\n";
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
            $delta > $eps ? return 0 : return 1;
        } else {
            return 0;
        }
    }
}

# this is a huge hack
sub verify_results
{
    my ($results,$class) = @_;
    # GSL uses a factor of 100 
    my $factor   = 20; 
    my $eps      = 2048*$Math::GSL::Machine::GSL_DBL_EPSILON; # TOL3
    my ($x,$res);
    local $Test::Builder::Level = $Test::Builder::Level + 1;

    croak "Usage: verify_results(%results, \$class)" unless $class;
    while (my($code,$expected)=each %$results){
        my $r        = Math::GSL::SF::gsl_sf_result_struct->new;
        my $status   = eval qq{${class}::$code};

        ok(0, qq{'$code' died} ) if !defined $status;
        
        if ( defined $r && $code =~ /_e\(.*\$r/) {
            $x   = $r->{val};
            $eps = $factor*$r->{err};
            $res = abs($x-$expected);

            if ($ENV{DEBUG} ){
                _dump_result($r);
                print "got $code = $x\n";
                printf "expected   : %.18g\n", $expected ;
                printf "difference : %.18g\n", $res;
                printf "unexpected error of %.18g\n", $res-$eps if ($res-$eps>0);
            }
            if (gsl_isnan($x)) {
                    ok( gsl_isnan($expected), "'$expected'?='$x'" );
            } elsif(gsl_isinf($x)) { 
                    ok( gsl_isinf($expected), "'$expected'?='$x'" );
            } else {
                ok( $res <= $eps, "$code ?= $x,\nres= +-$res, eps=$eps" );    
            }
        }
    }
}
sub verify
{
    my ($results,$class) = @_;
    local $Test::Builder::Level = $Test::Builder::Level + 1;
    croak "Usage: verify(%results, \$class)" unless $class;
    while (my($code,$result)=each %$results){
        my $x = eval qq{${class}::$code};
        ok(0, $@) if $@;

        my ($expected,$eps);
        if (ref $result){
            ($expected,$eps)=@$result;
        } else {
            ($expected,$eps)=($result,1e-8);
        }
        my $res = abs($x - $expected);

        if (gsl_isnan($x)) {
               ok( gsl_isnan($expected), "'$expected'?='$x'" );
        } elsif(gsl_isinf($x)) {
               ok( gsl_isinf($expected), "'$expected'?='$x'" );
        } else {
            ok( $res <= $eps, "$code ?= $x,\nres= +-$res, eps=$eps" );    
        }
    }
}
sub ok_status {
    my ($got, $expected) = @_;
    local $Test::Builder::Level = $Test::Builder::Level + 1;
    $expected ||= $GSL_SUCCESS;
    ok( defined $got && $got == $expected, gsl_strerror(int($got)) );
}
sub ok_similar {
    my ($x,$y, $msg, $eps) = @_;
    local $Test::Builder::Level = $Test::Builder::Level + 1;
    ok(is_similar($x,$y,$eps), $msg);
}

sub is_similar_relative {
    my ($x,$y, $eps) = @_;
    return is_similar($x,$y,$eps, sub { abs( ($_[0] - $_[1])/abs($_[1]) ) } );
}

sub ok_similar_relative {
    my ($x,$y, $msg, $eps,) = @_;
    local $Test::Builder::Level = $Test::Builder::Level + 1;
    ok(is_similar_relative($x,$y,$eps), $msg );
}

1;
