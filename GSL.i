%typemap(in) double const [] {
    AV *tempav;
    I32 len;
    int i;
    SV **tv;
    if (!SvROK($input))
        croak("$input is not a reference!");
    if (SvTYPE(SvRV($input)) != SVt_PVAV)
        croak("$input is not an array!");
        
    tempav = (AV*)SvRV($input);
    len = av_len(tempav);
    $1 = (double *) malloc((len+1)*sizeof(double));
    for (i = 0; i <= len; i++) {
        tv = av_fetch(tempav, i, 0);
        $1[i] = (double) SvNV(*tv);
    }
    $1[i] = GSL_NAN;
}

%typemap(freearg) double const [] {
    free($1);
}

%typemap(in) double * (double dvalue) {
  SV* tempsv;
  if (!SvROK($input)) {
    croak("$input is not a reference!\n");
  }
  tempsv = SvRV($input);
  if ((!SvNOK(tempsv)) && (!SvIOK(tempsv))) {
    croak("$input is not a reference!\n");
  }
  dvalue = SvNV(tempsv);
  $1 = &dvalue;
}

%typemap(argout) double * {
  SV *tempsv;
  tempsv = SvRV($input);
  sv_setnv(tempsv, *$1);
}
