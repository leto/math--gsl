package Math::GSL;

use warnings;
use Config;
use Data::Dumper;
use Test::More;
use Scalar::Util qw/looks_like_number/;
require DynaLoader;
require Exporter;
our @ISA = qw(Exporter DynaLoader);
our @EXPORT = qw();
our @EXPORT_OK = qw( is_similar );

use strict;

our $VERSION = 0.01;

=head1 NAME

Math::GSL - Perl interface to the  GNU Scientific Library (GSL) using SWIG

=head1 VERSION

Version 0.01

=cut

=head1 SYNOPSIS


    use Math::GSL::Sf qw/ ... /;
    ...

=head1 EXPORT



=head1 AUTHOR

Jonathan Leto, C<< <jonathan at leto.net> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-math-gsl at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Math::GSL>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.


=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Math::GSL

or online at L<http://leto.net/code/Math-GSL/>


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Math::GSL>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Math::GSL>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Math::GSL>

=item * Search CPAN

L<http://search.cpan.org/dist/Math::GSL>

=back


=head1 ACKNOWLEDGEMENTS


=head1 COPYRIGHT & LICENSE

Copyright 2008 Jonathan Leto, all rights reserved.

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
             CDF Errno Fit Machine
             Poly PowInt Randist SF Types 
    /;
}

sub verify_results
{
    my ($self,$results,$class, $eps) = @_;
    $eps ||= 1e-8;
    while (my($k,$v)=each %$results){
        my $x; 
        if (defined $class){
            $x = eval qq{${class}::$k};
        } else {
            $x = eval $k;
        }

        print "got $x for $k\n" if defined $ENV{DEBUG};
        if(defined $x && $x =~ /nan|inf/i){
                ok( $v eq $x, "'$v'?='$x'" );
        } else { 
            my $res = abs($x-$v);
            $@ ? ok(0)
               : ok( $res < $eps, "$k ?= $x, +- $res" );    
        }
    }
}

use constant MAX_DOUBLE => 1.7976931348623157e+308;
use constant MIN_DOUBLE => 2.2250738585072014e-308;
use constant MAX_FLOAT  => 3.40282347e+38;
use constant MIN_FLOAT  => 1.175494351e-38;


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
