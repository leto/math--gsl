package Math::GSL;
use base 'Exporter';
use base 'DynaLoader';
use strict;
use Config;
use warnings;
use Test::More;
use Math::GSL::Test    qw/:all/;
use Math::GSL::Const   qw/:all/;
use Math::GSL::Errno   qw/:all/;
use Math::GSL::Vector  qw/:file/;
use Math::GSL::Machine qw/:all/;
our @EXPORT = qw();
our @EXPORT_OK = qw( 
                     gsl_fopen gsl_fclose 
                     $GSL_MODE_DEFAULT $GSL_PREC_DOUBLE
                     $GSL_PREC_SINGLE $GSL_PREC_APPROX
                   );


our %EXPORT_TAGS = ( all => \@EXPORT_OK, );

our ($GSL_PREC_DOUBLE, $GSL_PREC_SINGLE, $GSL_PREC_APPROX ) = 0 .. 2;
our $GSL_MODE_DEFAULT = $GSL_PREC_DOUBLE;
our $VERSION = '0.17_03';

=head1 NAME

Math::GSL - Perl interface to the GNU Scientific Library (GSL)

=head1 VERSION

Version 0.17_03

=head1 SYNOPSIS

    use Math::GSL::Matrix;
    my $matrix = Math::GSL::Matrix->new(5,5);   # 5x5 zero matrix
    # note that columns and rows are zero-based
    $matrix->set_col(0, [1..5])                 # set *first* column to 1,2,3,4,5
           ->set_row(2, [5..9]);                # set *third* column to 5,6,7,8,9   
    my @matrix = $matrix->as_list;              # matrix as Perl list
    my $gsl_matrix = $matrix->raw;              # underlying GSL object

    use Math::GSL::RNG;
    my $rng = Math::GSL::RNG->new;
    my @random_numbers = map { $rng->get } (1 .. 1000);

    use Math::GSL::Deriv qw/:all/;
    my $function = sub { my $x=shift; sin($x**2) };
    my ($status,$val,$err) = gsl_deriv_central($function, 5, 0.01 );

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
    Math::GSL::Histogram        - Histograms
    Math::GSL::Histogram2D      - 2D Histograms
    Math::GSL::Integration      - Numerical Integration
    Math::GSL::Interp           - Interpolation
    Math::GSL::Linalg           - Linear Algebra
    Math::GSL::Machine          - Machine Specific Information
    Math::GSL::Matrix           - NxM Matrices
    Math::GSL::Min              - Minimization
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

This software is still in active development, we appreciate your detailed bug reports and
documentation patches. Please report any bugs or feature requests to the authors directly.


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

Thanks to PDX.pm, The Perl Foundation and everyone at Google who makes
the Summer of Code happen each year. You rock.

=head1 DEDICATION

This Perl module is dedicated in memory of Nick Ing-Simmons.

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
sub gsl_fopen
{
    my ($file, $mode) = @_;
    $mode .= '+b' if (is_windows() and $mode !~ /\+b/);
    return Math::GSL::Vector::fopen($file, $mode);
}

sub gsl_fclose
{
    my $file = shift;
    return Math::GSL::Vector::fclose($file);
}

42;
