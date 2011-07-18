%module "Math::GSL::Poly"
// this brakes stuff
// %include "typemaps.i"
%include "gsl_typemaps.i" 
%include "renames.i"

%{
    #include "gsl/gsl_sys.h"
%}

%typemap(in) double * (double dvalue) {
  SV* tempsv;
  if (!SvROK($input)) {
    croak("$input is not a reference!\n");
  }
  tempsv = SvRV($input);
  if ((!SvNOK(tempsv)) && (!SvIOK(tempsv))) {
    croak("$input is not a reference to number!\n");
  }
  dvalue = SvNV(tempsv);
  $1 = &dvalue;
}

#gsl_complex gsl_complex_poly_complex_eval (const gsl_complex c [], const int len, const gsl_complex z);

%typemap(argout) gsl_complex {
    AV* tempav = newAV();
    double x,y;
    if (argvi >= items) {            
        EXTEND(sp,1);              
    }
    //fprintf(stderr,"--> %g <--\n", GSL_REAL($1));
    //fprintf(stderr,"--> %g <--\n", GSL_IMAG($1));

    $result = sv_newmortal();
   
    x = GSL_REAL($1); 
    y = GSL_IMAG($1);

    /* the next 2 lines blow up
    sv_setnv($result, x);
    argvi++;
    */
};

%typemap(argout) double * {
  SV *tempsv;
  tempsv = SvRV($input);
  sv_setnv(tempsv, *$1);
}

%typemap(in) gsl_complex const [] {
    AV *tempav;
    I32 len;
    int i, magic, stuff;
    double x,y;
    gsl_complex z;
    SV **elem, **helem, **real, **imag;
    HV *hash, *htmp;
    SV *svtmp, tmp;
    double result[2];

    printf("gsl_complex typemap\n");
    if (!SvROK($input))
        croak("Math::GSL : $input is not a reference!");
    if (SvTYPE(SvRV($input)) != SVt_PVAV)
        croak("Math::GSL : $input is not an array ref!");
       
    z      = gsl_complex_rect(0,0);
    tempav = (AV*)SvRV($input);
    len    = av_len(tempav);
    $1 = (gsl_complex *) malloc((len+1)*sizeof(gsl_complex));
    for (i = 0; i <= len; i++) {
        elem  = av_fetch(tempav, i, 0);

        hash = (HV*) SvRV(*elem);
        helem = hv_fetch(hash, "dat", 3, 0);
        magic = mg_get(*helem);
        if ( magic != 0)
            croak("FETCH magic failed!\n");

        printf("magic = %d\n", magic);
        if( *helem == NULL)
            croak("Structure does not contain 'dat' element\n");
        printf("helem is:\n");
        //Perl_sv_dump(*helem);
        if( i == 0){
            svtmp = (SV*)SvRV(*helem);
            //Perl_sv_dump(svtmp);
        }
        printf("re z = %f\n", GSL_REAL(z) );
        printf("im z = %f\n", GSL_IMAG(z) );
        $1[i] = z;
    }
}
%{
    #include "gsl/gsl_nan.h"
    #include "gsl/gsl_poly.h"
    #include "gsl/gsl_complex.h"
    #include "gsl/gsl_complex_math.h"
%}

%include "gsl/gsl_nan.h"
%include "gsl/gsl_poly.h"
%include "gsl/gsl_complex.h"
%include "gsl/gsl_complex_math.h"
%include "../pod/Poly.pod"

