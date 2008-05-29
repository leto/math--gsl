%module Complex
%{
    #include "/usr/local/include/gsl/gsl_complex.h"
    #include "/usr/local/include/gsl/gsl_complex_math.h"
%}

%include "/usr/local/include/gsl/gsl_complex.h"
%include "/usr/local/include/gsl/gsl_complex_math.h"


%include "carrays.i"
%array_functions(double, doubleArray);

%perlcode %{

@EXPORT_OK = qw(
    gsl_complex_arg gsl_complex_abs gsl_complex_rect gsl_complex_polar doubleArray_getitem 
    gsl_complex_rect gsl_complex_polar gsl_complex_arg gsl_complex_abs gsl_complex_abs2 
    gsl_complex_logabs gsl_complex_add gsl_complex_sub gsl_complex_mul gsl_complex_div 
    gsl_complex_add_real gsl_complex_sub_real gsl_complex_mul_real gsl_complex_div_real 
    gsl_complex_add_imag gsl_complex_sub_imag gsl_complex_mul_imag gsl_complex_div_imag 
    gsl_complex_conjugate gsl_complex_inverse gsl_complex_negative gsl_complex_sqrt 
    gsl_complex_sqrt_real gsl_complex_pow gsl_complex_pow_real gsl_complex_exp 
    gsl_complex_log gsl_complex_log10 gsl_complex_log_b gsl_complex_sin 
    gsl_complex_cos gsl_complex_sec gsl_complex_csc gsl_complex_tan 
    gsl_complex_cot gsl_complex_arcsin gsl_complex_arcsin_real gsl_complex_arccos 
    gsl_complex_arccos_real gsl_complex_arcsec gsl_complex_arcsec_real gsl_complex_arccsc 
    gsl_complex_arccsc_real gsl_complex_arctan gsl_complex_arccot gsl_complex_sinh 
    gsl_complex_cosh gsl_complex_sech gsl_complex_csch gsl_complex_tanh 
    gsl_complex_coth gsl_complex_arcsinh gsl_complex_arccosh gsl_complex_arccosh_real 
    gsl_complex_arcsech gsl_complex_arccsch gsl_complex_arctanh gsl_complex_arctanh_real 
    gsl_complex_arccoth new_doubleArray delete_doubleArray doubleArray_setitem
    gsl_real gsl_imag gsl_parts
    gsl_complex_eq gsl_set_real gsl_set_imag
    $GSL_COMPLEX_ONE $GSL_COMPLEX_ZERO $GSL_COMPLEX_NEGONE
);
# macros to implement
# gsl_set_complex gsl_set_complex_packed
our ($GSL_COMPLEX_ONE, $GSL_COMPLEX_ZERO, $GSL_COMPLEX_NEGONE) = map { gsl_complex_rect($_, 0) } qw(1 0 -1); 


%EXPORT_TAGS = ( all => [ @EXPORT_OK ] );

### wrapper interface ###
sub new {
    my ($class, @values) = @_;
    my $this = {};
    $this->{_complex} = gsl_complex_rect($values[0], $values[1]);
    bless $this, $class;
}
sub real {
    my ($self) = @_;
    gsl_real($self->{_complex}->{dat});
}

sub imag {
    my ($self) = @_;
    gsl_imag($self->{_complex}->{dat});
}

sub parts {
    my ($self) = @_;
    gsl_parts($self->{_complex}->{dat});
}

### end wrapper interface ###

### some important macros that are in gsl_complex.h
sub gsl_complex_eq {
    my ($z,$w) = @_;
    gsl_real($z) == gsl_real($w) && gsl_imag($z) == gsl_imag($w) ? 1 : 0;
}

sub gsl_set_real {
    my ($z,$r) = @_;
    doubleArray_setitem($z->{dat}, 0, $r);
}

sub gsl_set_imag {
    my ($z,$i) = @_;
    doubleArray_setitem($z->{dat}, 1, $i);
}

sub gsl_real {
    my $z = shift;
    return doubleArray_getitem($z->{dat}, 0 );
}

sub gsl_imag {
    my $z = shift;
    return doubleArray_getitem($z->{dat}, 1 );
}

sub gsl_parts {
    my $z = shift;
    return (gsl_real($z), gsl_imag($z));
}

__END__

=head1 NAME

Math::GSL::Complex
Functions concerning complex numbers.

=head1 SYPNOPSIS

use Math::GSL::Complex qw/:all/;

=head1 DESCRIPTION

Here is a list of all the functions included in this module :
gsl_complex_arg gsl_complex_abs gsl_complex_rect gsl_complex_polar doubleArray_getitem 
gsl_complex_rect gsl_complex_polar gsl_complex_arg gsl_complex_abs gsl_complex_abs2 
gsl_complex_logabs gsl_complex_add gsl_complex_sub gsl_complex_mul gsl_complex_div 
gsl_complex_add_real gsl_complex_sub_real gsl_complex_mul_real gsl_complex_div_real 
gsl_complex_add_imag gsl_complex_sub_imag gsl_complex_mul_imag gsl_complex_div_imag 
gsl_complex_conjugate gsl_complex_inverse gsl_complex_negative gsl_complex_sqrt 
gsl_complex_sqrt_real gsl_complex_pow gsl_complex_pow_real gsl_complex_exp 
gsl_complex_log gsl_complex_log10 gsl_complex_log_b gsl_complex_sin 
gsl_complex_cos gsl_complex_sec gsl_complex_csc gsl_complex_tan 
gsl_complex_cot gsl_complex_arcsin gsl_complex_arcsin_real gsl_complex_arccos 
gsl_complex_arccos_real gsl_complex_arcsec gsl_complex_arcsec_real gsl_complex_arccsc 
gsl_complex_arccsc_real gsl_complex_arctan gsl_complex_arccot gsl_complex_sinh 
gsl_complex_cosh gsl_complex_sech gsl_complex_csch gsl_complex_tanh 
gsl_complex_coth gsl_complex_arcsinh gsl_complex_arccosh gsl_complex_arccosh_real 
gsl_complex_arcsech gsl_complex_arccsch gsl_complex_arctanh gsl_complex_arctanh_real 
gsl_complex_arccoth new_doubleArray delete_doubleArray doubleArray_setitem

You have to add the functions you want to use inside the qw /put_funtion_here / with spaces between each function. You can also write use Math::GSL::Complex qw/:all/ to use all avaible functions of the module.

For more informations on the functions, we refer you to the GSL offcial documentation: http://www.gnu.org/software/gsl/manual/html_node/
Tip : search on google: site:http://www.gnu.org/software/gsl/manual/html_node/ name_of_the_function_you_want

=head1 EXAMPLES


=head1 AUTHOR

Jonathan Leto <jaleto@gmail.com> and Thierry Moisan <thierry.moisan@gmail.com>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2008 Jonathan Leto and Thierry Moisan

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut
%}
