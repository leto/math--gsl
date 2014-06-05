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
use Math::GSL::Version;
use version;
our @EXPORT = qw();
our @EXPORT_OK = qw(
                     gsl_fopen gsl_fclose gsl_version
                     $GSL_MODE_DEFAULT $GSL_PREC_DOUBLE
                     $GSL_PREC_SINGLE $GSL_PREC_APPROX
                   );


our %EXPORT_TAGS = ( all => \@EXPORT_OK, );

our ($GSL_PREC_DOUBLE, $GSL_PREC_SINGLE, $GSL_PREC_APPROX ) = 0 .. 2;
our $GSL_MODE_DEFAULT = $GSL_PREC_DOUBLE;
our $VERSION = '0.30_3';

=head1 NAME

Math::GSL - Perl interface to the GNU Scientific Library (GSL)

=head1 VERSION

Version 0.30

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
    my @random_numbers = $rng->get(1000);

    use Math::GSL::Deriv qw/:all/;
    my $function = sub { my $x=shift; sin($x**2) };
    my ($status,$val,$err) = gsl_deriv_central($function, 5, 0.01 );

    use Math::GSL qw/gsl_version/;
    # get a version object for the version of the underlying GSL library,
    # which will stringify to a version number
    my $gsl_version = gsl_version();

Each GSL subsystem has it's own module. For example, the random number generator
subsystem is Math::GSL::RNG. Many subsystems have a more Perlish and
object-oriented frontend which can be used, as the above example shows. The raw
GSL object is useful for using the low-level GSL functions, which in the case of
the Matrix subsytem, would be of the form gsl_matrix_* . Each module has further
documentation about the low-level C functions as well as using the more
intuitive (but slightly slower) object-oriented interface.

=head1 SUBSYSTEMS

L<Math::GSL::BLAS>            - Linear Algebra Functions

L<Math::GSL::BSpline>         - BSplines

L<Math::GSL::CBLAS>           - Linear Algebra Functions

L<Math::GSL::CDF>             - Cumulative Distribution Functions

L<Math::GSL::Chebyshev>       - Chebyshev Polynomials

L<Math::GSL::Combination>     - Combinatoric Functions

L<Math::GSL::Complex>         - Complex Numbers

L<Math::GSL::Const>           - Various Constants

L<Math::GSL::DHT>             - Discrete Hankel Transforms

L<Math::GSL::Deriv>            - Numerical Derivative

L<Math::GSL::Eigen>           - Eigenvalues and Eigenvectors

L<Math::GSL::Errno>           - Error Handling

L<Math::GSL::FFT>             - Fast Fourier Transform

L<Math::GSL::Fit>             - Curve Fitting

L<Math::GSL::Heapsort>        - Sorting Heaps

L<Math::GSL::Histogram>       - Histograms

L<Math::GSL::Histogram2D>     - 2D Histograms

L<Math::GSL::Integration>     - Numerical Integration

L<Math::GSL::Interp>          - Interpolation

L<Math::GSL::Linalg>          - Linear Algebra

L<Math::GSL::Machine>         - Machine Specific Information

L<Math::GSL::Matrix>          - NxM Matrices

L<Math::GSL::Min>             - Minimization

L<Math::GSL::Monte>           - Monte Carlo Integrations

L<Math::GSL::Multifit>        - Multivariable Fitting

L<Math::GSL::Multimin>        - Multivariable Minimization

L<Math::GSL::Multiroots>      - Muiltvariable Root Finding

L<Math::GSL::NTuple>          - N Tuples

L<Math::GSL::ODEIV>           - Ordinary Differential Equation Solvers (Initial Value Problems)

L<Math::GSL::Permutation>     - Permutations

L<Math::GSL::Poly>            - Polynmials

L<Math::GSL::PowInt>          - Integer Power Functions

L<Math::GSL::QRNG>            - Quasi-Random Number Generators

L<Math::GSL::RNG>             - Random Number Generators

L<Math::GSL::Randist>         - Random Number Distributions

L<Math::GSL::Roots>           - Root Finding Algorithms

L<Math::GSL::SF>              - Special Functions

L<Math::GSL::Siman>           - Simulated Annealing

L<Math::GSL::Sort>            - Sorting

L<Math::GSL::Spline>          - Splines

L<Math::GSL::Statistics>      - Statistics Functions

L<Math::GSL::Sum>             - Summation

L<Math::GSL::Sys>             - Sytem utility functions

L<Math::GSL::Vector>          - N-dimensional Vectors

L<Math::GSL::Wavelet>         - Basic Wavelets

L<Math::GSL::Wavelet2D>        - 2D Wavelets

=cut

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

sub gsl_version{
    return version->parse($Math::GSL::Version::GSL_VERSION);
}

=head1 AUTHORS

Jonathan "Duke" Leto, C<< <jonathan@leto.net> >> and Thierry Moisan C<< <thierry.moisan@gmail.com> >>

=head1 BUGS

This software is still in active development, we appreciate your detailed bug reports and
documentation patches. Please report any bugs or feature requests to the authors directly.

=head1 COMPILING ISSUES

Some operating system configurations will make the compilation of Math::GSL fail. One
common problem that happens on RedHat Linux (RHEL) and CentOS looks like this:


    Error:  Can't load '/usr/src/misc/perl-package/Math-GSL-0.20/blib/arch/auto/Math/GSL/Errno/Errno.so'
    for module Math::GSL::Errno: /usr/src/misc/perl-package/Math-GSL-0.20/blib/arch/auto/Math/GSL/Errno/Errno.so:
    cannot restore segment prot after reloc: Permission denied at /usr/lib/perl5/5.10.0/i386-linux-thread-multi/DynaLoader.pm line 203.
    #  at blib/lib/Math/GSL/Errno.pm line 10

This is due the the SE Linux setting being set to "enforcing". To Temporarily
disable enforcement on a running system:

    /usr/sbin/setenforce 0

To permanently disable enforcement during a system startup change "enforcing" to
"disabled" in ''/etc/selinux/config'' and reboot.


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

    git clone git://github.com/leto/math--gsl.git
    cd math--gsl
    # start hacking

to get the latest source, which is a two-headed beast with branches master and
bleed. The master branch is our stable branch, which is periodically sync-ed
with bleed. To view the latest source code online, go to
L<http://github.com/leto/math--gsl/tree/master>.  The latest version of Git can be found at
L<http://git-scm.com> .

=head1 ACKNOWLEDGEMENTS

Thanks to PDX.pm, The Perl Foundation and everyone at Google who makes
the Summer of Code happen each year. You rock.

=head1 DEDICATION

This Perl module is dedicated in memory of Nick Ing-Simmons.

=head1 COPYRIGHT & LICENSE

Copyright 2008-2010 Jonathan "Duke" Leto, Thierry Moisan all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

42;
