package Math::GSL;
use base qw(Exporter);
use base qw(DynaLoader);
use strict;
use warnings;
use Math::GSL::Machine qw/:all/;
use Math::GSL::Const qw/:all/;
use Math::GSL::Errno qw/:all/;
use Carp qw/croak/;
use Config;
use Data::Dumper;
use Test::More;
use Scalar::Util qw/looks_like_number/;
our @EXPORT = qw();
our @EXPORT_OK = qw( ok_similar ok_status  is_similar
                     is_similar_relative verify verify_results 
                     $GSL_MODE_DEFAULT $GSL_PREC_DOUBLE
                     $GSL_PREC_SINGLE $GSL_PREC_APPROX
                   );

our %EXPORT_TAGS = ( 
                     all => \@EXPORT_OK,
                   );

our ($GSL_PREC_DOUBLE, $GSL_PREC_SINGLE, $GSL_PREC_APPROX ) = 0..2;
our $GSL_MODE_DEFAULT = $GSL_PREC_DOUBLE;
our $VERSION = '0.06_03';

=head1 NAME

Math::GSL - Perl interface to the  GNU Scientific Library (GSL) using SWIG

=head1 VERSION

Version 0.06_03

=cut

=head1 SYNOPSIS

    use Math::GSL::Matrix qw/:all/;
    my $matrix = Math::GSL::Matrix->new(5,5);   # 5x5 zero matrix
    $matrix->set_col(0, [1..5])
           ->set_row(2, [5..9]);
    my @matrix = $matrix->as_list;              # matrix as Perl list
    my $gsl_matrix = $matrix->raw;              # underlying GSL object

Each GSL subsystem has it's own module. For example, the random number generator
subsystem is Math::GSL::RNG. Many subsystems have a more Perlish and
object-oriented frontend which can be used, as the above example shows. The raw
GSL object is useful for using the low-level GSL functions, which in the case of
the Matrix subsytem, would be of the form gsl_matrix_* . Each module has further
documentation about the low-level C functions as well as using the more
intuitive (but slightly slower) object-oriented interface.

=head1 SUBSYSTEMS

    Math::GSL::BLAS             - Linear Algebra Functions
    Math::GSL::BSpline          - BSplines
    Math::GSL::CBLAS            - Linear Algebra Functions
    Math::GSL::CDF              - Cumulative Distribution Functions
    Math::GSL::Chebyshev        - Chebyshev Polynomials
    Math::GSL::Combination      - Combinatoric Functions
    Math::GSL::Complex          - Complex Numbers
    Math::GSL::Const            - Various Constants
    Math::GSL::DHT              - Discrete Hilbert Transform
    Math::GSL::Deriv            - Numerical Derivative
    Math::GSL::Eigen            - Eigenvalues and Eigenvectors
    Math::GSL::Errno            - Error Handling
    Math::GSL::FFT              - Fast Fourier Transform
    Math::GSL::Fit              - Curve Fitting
    Math::GSL::Heapsort         - Sorting Heaps
    Math::GSL::Histograma       - Histograms
    Math::GSL::Histogram2D      - 2D Histograms
    Math::GSL::Integration      - Numerical Integration
    Math::GSL::Interp           - Interpolation
    Math::GSL::Linalg           - Linear Algebra
    Math::GSL::Machine          - Machine Specific Information
    Math::GSL::Matrix           - NxM Matrices
    Math::GSL::Min              - Minimization
    Math::GSL::Mode             - GSL Precision Modes
    Math::GSL::Monte            - Monte Carlo Integrations
    Math::GSL::Multifit         - Multivariable Fitting
    Math::GSL::Multimin         - Multivariable Minimization
    Math::GSL::Multiroots       - Muiltvariable Root Finding
    Math::GSL::NTuple           - N Tuples
    Math::GSL::ODEIV            - Ordinary Differential Equation Solvers (Initial Value Problems)
    Math::GSL::Permutation      - Permutations
    Math::GSL::Poly             - Polynmials
    Math::GSL::PowInt           - Integer Power Functions
    Math::GSL::QRNG             - Quasi-Random Number Generators
    Math::GSL::RNG              - Random Number Generators
    Math::GSL::Randist          - Random Number Distributions
    Math::GSL::Roots            - Root Finding Algorithms
    Math::GSL::SF               - Special Functions
    Math::GSL::Siman            - Simulated Annealing
    Math::GSL::Sort             - Sorting
    Math::GSL::Spline           - Splines
    Math::GSL::Statistics       - Statistics Functions
    Math::GSL::Sum              - Summation
    Math::GSL::Sys              - Sytem utility functions
    Math::GSL::Vector           - N-dimensional Vectors
    Math::GSL::Wavelet          - Basic Wavelets
    Math::GSL::Wavelet2D        - 2D Wavelets


=head1 AUTHORS

Jonathan Leto, C<< <jonathan@leto.net> >> and Thierry Moisan C<< <thierry.moisan@gmail.com> >>

=head1 BUGS

This software is still in active development, we appreciate your detailed bug reports.
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

=head1 DEVELOPMENT

If you would like the help develop Math::GSL, email the authors
and do

    git clone http://leto.net/code/Math-GSL.git 
    cd Math-GSL
    git checkout -b bleed   # create new local branch
    git pull origin bleed   # pull in remote bleed

to get the latest source, which is a two-headed beast with branches master and
bleed. The master branch is our stable branch, which is periodically sync-ed
with bleed. To view the latest source code online, go to
L<http://leto.net/gitweb/>.  The latest version of Git can be found at
L<http://git.or.cz>.

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
    return sort qw/
        Diff         Machine      Statistics
        Block        Eigen        Matrix        Poly 
        BSpline      Errno        PowInt        
        CBLAS        FFT          Min           IEEEUtils
        CDF          Fit          Mode          QRNG
        Chebyshev    Monte        RNG           Vector
        Heapsort     Multifit     Randist       Roots     
        Combination  Histogram    Multimin      Wavelet
        Complex      Histogram2D  Multiroots    Wavelet2D
        Const        Siman        Sum           Sys
        Integration  NTuple       Sort                  
        DHT          Interp       ODEIV         SF 
        Deriv        Linalg       Permutation   Spline
    /;
}


sub is_similar {
    my ($x,$y, $eps, $similarity_function) = @_;
    $eps ||= 1e-8;
    if (ref $x eq 'ARRAY' && ref $y eq 'ARRAY') {
        if ( $#$x != $#$y ){
            warn "is_similar(): argument of different lengths, $#$x != $#$y !!!";
            return 0;
        } else {
            map { 
                    my $delta = abs($x->[$_] - $y->[$_]);
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
        } else { 
            abs($x-$y) <= $eps ? return 1 : return 0;
        }
    }
}
sub ok_status {
    my ($got, $expected) = @_;
    ok( $got == $expected, gsl_strerror($expected) );
}
sub ok_similar {
    my ($x,$y, $msg, $eps) = @_;
    ok(is_similar($x,$y,$eps), $msg);
}

sub is_similar_relative {
    my ($x,$y, $eps) = @_;
    return is_similar($x,$y,$eps, sub { abs( ($_[0] - $_[1])/abs($_[1]) ) } );
}

# this is a huge hack
sub verify_results
{
    my ($results,$class) = @_;
    # GSL uses a factor of 100 
    my $factor   = 20; 
    my $eps      = 2048*$Math::GSL::Machine::GSL_DBL_EPSILON; # TOL3
    my ($x,$res);

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

            if ($x =~ /nan|inf/i) {
                    ok( $expected eq $x, "'$expected'?='$x'" );
            } else { 
                ok( $res <= $eps, "$code ?= $x,\nres= +-$res, eps=$eps" );    
            }
        }
    }
}
sub verify
{
    my ($results,$class) = @_;
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
        if ($x =~ /nan|inf/i ){
            ok( $expected eq $x, "'$expected' ?='$x'" );
        } else {
            ok( $res <= $eps, "$code ?= $x,\nres= +-$res, eps=$eps" );    
        }
    }
}

sub _dump_result($)
{
    my $r=shift;
    printf "result->err: %.18g\n", $r->{err};
    printf "result->val: %.18g\n", $r->{val};
}

42;
