package Math::GSL;
use strict;
use warnings;
use Math::GSL::Machine qw/:all/;
use Config;
use Data::Dumper;
use Test::More;
use Scalar::Util qw/looks_like_number/;
require DynaLoader;
require Exporter;
our @ISA = qw(Exporter DynaLoader);
our @EXPORT = qw();
our @EXPORT_OK = qw( is_similar );
use constant MAX_DOUBLE => 1.7976931348623157e+308;
use constant MIN_DOUBLE => 2.2250738585072014e-308;
use constant MAX_FLOAT  => 3.40282347e+38;
use constant MIN_FLOAT  => 1.175494351e-38;
our $VERSION = 0.043;

=head1 NAME

Math::GSL - Perl interface to the  GNU Scientific Library (GSL) using SWIG

=head1 VERSION

Version 0.43

=cut

=head1 SYNOPSIS

    use Math::GSL::RNG qw/:all/;


=head1 AUTHOR

Jonathan Leto, C<< <jonathan@leto.net> >> and Thierry Moisan C<< <thierry.moisan@gmail.com> >>

=head1 BUGS

Please report any bugs or feature requests to the authors directly.


=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Math::GSL

or online at L<http://leto.net/code/Math-GSL/>

=over 4

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Math::GSL>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Math::GSL>

=item * Search CPAN

L<http://search.cpan.org/dist/Math::GSL>

=back


=head1 ACKNOWLEDGEMENTS


=head1 COPYRIGHT & LICENSE

Copyright 2008 Jonathan Leto, Thierry Moisan all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

sub new 
{
    my ($self,$args) = @_;
    my $class = ref $self || $self || 'Math::GSL';
    my $this = { };
    bless $this, $class;
}

sub subsystems
{
    return qw/
        BLAS         Diff         Machine       Permute   Statistics
        Block        Eigen        Matrix        Poly      Sum
        BSpline      Errno        PowInt        Sys
        CBLAS        FFT          Min           IEEEUtils
        CDF          Fit          Mode          QRNG      Types
        Chebyshev    Function     Monte         RNG       Vector
        Heapsort     Multifit     Randist       
        Combination  Histogram    Multimin      Roots     Wavelet
        Complex      Histogram2d  Multiroots    SF        Wavelet2D
        Const        Siman         
        DFT          Integration  NTuple        Sort                  
        DHT          Interp       ODEIV         
        Deriv        Linalg       Permutation   Spline
    /;
}

sub verify_results
{
    my ($self,$results,$class) = @_;
    my ($x,$val);

    while (my($k,$v)=each %$results){
        my $eps = 2048*$Math::GSL::Machine::GSL_DBL_EPSILON; # TOL3
        defined $class ? ( $x = eval qq{${class}::$k} )
                       : ( $x = eval $k);

        print "got $x for $k\n" if defined $ENV{DEBUG};

        if (ref $v eq 'ARRAY'){
            ($val, $eps)   = @$v;
        } else {
             $val = $v;
        }
        if (defined $x && $x =~ /nan|inf/i){
                ok( $val eq $x, "'$v'?='$x'" );
        } else { 
            my $res = abs($x-$val);
            $@ ? ok(0)
            : ok( $res < $eps, "$k ?= $x, +- $res" );    
        }
    }
}

sub is_similar {
    my ($x,$y, $eps) = @_;
    $eps ||= 1e-8;
    abs($x-$y) < $eps ? 1 : 0;
}

sub is_valid_double
{
    my $x=shift;
    return 0 unless ( defined $x && looks_like_number($x) );

    return 1 if ($x == 0);

    $x = abs $x;
    (  
      $x > MIN_DOUBLE && 
      $x < MAX_DOUBLE       
    ) ? 1 : 0;  
}
sub is_valid_float
{ 
    my $x=shift; 
    return 0 unless ( defined $x && looks_like_number($x) );

    return 1 if ($x == 0);

    $x = abs $x ;
    ( 
      $x > MIN_FLOAT && 
      $x < MAX_FLOAT        
    ) ? 1 : 0;  
}

sub _has_quads          { $Config{use64bitint} eq 'define' || ($Config{longsize} >= 8) }
sub _has_long_doubles                 { $Config{d_longdbl}     eq 'define'             }
sub _has_long_doubles_as_default      { $Config{uselongdouble} eq 'define'             }
sub _has_long_doubles_same_as_doubles { $Config{doublesize}    == $Config{longdblsize} }

sub _assert_dies($;$)
{
    my ($code,$msg) = @_;
    my $status = eval { &$code };
    print "status=||$status||\n\$\?=$?\n\$\!=$!\n" if 0;
    $@  ?  ok(1, $msg) : ok (0, join "\n", $@,  $msg );
}

42;
