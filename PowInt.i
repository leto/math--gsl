%module PowInt
%{
#include "/usr/local/include/gsl/gsl_pow_int.h"
extern double gsl_pow_int(double x, int n);
%}

%include "/usr/local/include/gsl/gsl_pow_int.h"

%perlcode %{

our @EXPORT_OK = qw/ gsl_pow_2 gsl_pow_2 gsl_pow_3 
                    gsl_pow_4 gsl_pow_5 gsl_pow_6 
                    gsl_pow_7 gsl_pow_8 gsl_pow_9 
		    gsl_pow_int
                /;
our %EXPORT_TAGS = ( all =>  [  @EXPORT_OK ] );

__END__

=head1 NAME

Math::GSL::PowInt - mathematical power functions

=head1 SYPNOPSIS

use Math::GSL::PowInt qw /gsl_pow_2/;

print "gsl_pow_2(4)=" . gsl_pow_2(4) . "\n";

=head1 ABSTRACT


=head1 DESCRIPTION

This module uses the GSL mathematical functions. It contains gsl_pow_2 to gsl_pow_9. If you need a power higher than 9, you can use gsl_pow_int.
You have to add the functions you want to use inside the qw /put_funtion_here /.

=head1 EXPORT


=head1 SEE ALSO


=head1 AUTHOR


Jonathan Leto <jaleto@gmail.com> and Thierry Moisan <thierry.moisan@gmail.com>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2008 Jonathan Leto and Thierry Moisan

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut
%}
