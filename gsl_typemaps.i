
%typemap(in) double const [] {
    AV *tempav;
    I32 len;
    int i;
    SV **tv;
    if (!SvROK($input))
        croak("Math::GSL : $input is not a reference!");
    if (SvTYPE(SvRV($input)) != SVt_PVAV)
        croak("Math::GSL : $input is not an array ref!");
        
    tempav = (AV*)SvRV($input);
    len = av_len(tempav);
    $1 = (double *) malloc((len+1)*sizeof(double));
    for (i = 0; i <= len; i++) {
        tv = av_fetch(tempav, i, 0);
        $1[i] = (double) SvNV(*tv);
    }
}


%apply double const [] { double *data, double *dest, double *f_in, double *f_out, double data[] };
%apply double const [] { double x[], double a[], double b[] };
%apply double const [] { const double * x, const double * y, const double * w };
%apply double const [] { const double x_array[], const double xrange[], const double yrange[]};

