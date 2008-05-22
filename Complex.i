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

@EXPORT_OK = qw(gsl_complex_arg gsl_complex_abs gsl_complex_rect gsl_complex_polar doubleArray_getitem doubleArray_setitem);

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
