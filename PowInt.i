%module "Math::GSL::PowInt"
%{
    #include "gsl/gsl_pow_int.h"
%}

%include "gsl/gsl_pow_int.h"

%perlcode %{

our @EXPORT_OK = qw/gsl_pow_2 gsl_pow_2 gsl_pow_3 
                    gsl_pow_4 gsl_pow_5 gsl_pow_6 
                    gsl_pow_7 gsl_pow_8 gsl_pow_9 gsl_pow_int
                /;
our %EXPORT_TAGS = ( all =>  \@EXPORT_OK );

__END__

=head1 NAME

Math::GSL::PowInt - Integer Power functions

=head1 SYNOPSIS

    use Math::GSL::PowInt qw /gsl_pow_2 gsl_pow_4 gsl_pow_int/;
    print '2**4  = ' . gsl_pow_2(4) . "\n";
    print '4**7  = ' . gsl_pow_4(7) . "\n";
    print '17**5 = ' . gsl_pow_int(17,5) . "\n";

=head1 DESCRIPTION

This module implements the GSL Integer Power functions, which allow one to
quickly compute a given integer raised to any real number.  It contains
gsl_pow_2 to gsl_pow_9 and gsl_pow_int. If you need a power higher than 9, you
can use gsl_pow_int, which takes a base as the first argument and power being
raised to as the second argument.

You can also write 

C<use Math::GSL::PowInt qw/:all/;>
    
to use all avaible functions of the module.

=head1 PURPOSE

This module is used to speed up arithmetic operations. The underlying code
decomposes the multiplication in the most efficient way. Since it is
implemented in XS (via SWIG), it should lend a large performance increase over
the Perl builtin exponentiation operator, '**' .

=head1 BENCHMARKS

Would someone like to submit some benchmarks?

=head1 AUTHOR

Jonathan Leto <jonathan@leto.net> and Thierry Moisan <thierry.moisan@gmail.com>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2008 Jonathan Leto and Thierry Moisan

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut
%}
