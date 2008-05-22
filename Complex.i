%module Complex
%{
    #include "/usr/local/include/gsl/gsl_complex.h"
    #include "/usr/local/include/gsl/gsl_complex_math.h"
%}

%include "/usr/local/include/gsl/gsl_complex.h"
%include "/usr/local/include/gsl/gsl_complex_math.h"


%include "carrays.i"
%array_functions(double, doubleArray);

/* r= real+i*imag */
//gsl_complex gsl_complex_rect (double x, double y); 

/* r= r e^(i theta) */
//gsl_complex gsl_complex_polar (double r, double theta); 

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
);

%EXPORT_TAGS = ( all => [ @EXPORT_OK ] );

sub new {
    my ($class, @values) = @_;
    my $this = {};
    $this->{_complex} = gsl_complex_rect($values[0], $values[1]);
    bless $this, $class;
}
sub real {
    my ($self) = @_;
    return doubleArray_getitem($self->{_complex}->{dat}, 0 );
}

sub imag {
    my ($self) = @_;
    return doubleArray_getitem($self->{_complex}->{dat}, 1 );
}
%}
