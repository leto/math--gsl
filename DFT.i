%module DFT
%{
    #include "gsl/gsl_dft_complex.h"
%}

%include "gsl/gsl_dft_complex.h"


%perlcode %{
@EXPORT_OK = qw/
               gsl_dft_complex_forward 
               gsl_dft_complex_backward 
               gsl_dft_complex_inverse 
               gsl_dft_complex_transform 
             /;
%EXPORT_TAGS = ( all => [ @EXPORT_OK ] );

__END__

=head1 NAME

Math::GSL::DFT

=head1 SYNOPSIS

use Math::GSL::DFT qw/:all/;

=head1 DESCRIPTION

Here is a list of all the functions included in this module :

=over

=item C<gsl_dft_complex_forward> 

=item C<gsl_dft_complex_backward> 

=item C<gsl_dft_complex_inverse> 

=item C<gsl_dft_complex_transform> 

=item For more informations on the functions, we refer you to the GSL offcial documentation: L<http://www.gnu.org/software/gsl/manual/html_node/>

=item Tip : search on google: site:http://www.gnu.org/software/gsl/manual/html_node/ name_of_the_function_you_want

=back

=head1 EXAMPLES

=head1 AUTHOR

Jonathan Leto <jonathan@leto.net> and Thierry Moisan <thierry.moisan@gmail.com>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2008 Jonathan Leto and Thierry Moisan

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

%}
