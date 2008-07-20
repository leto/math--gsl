%module "Math::GSL::Block"
%{
    #include "gsl/gsl_block.h"
    #include "gsl/gsl_block_char.h"
    #include "gsl/gsl_block_complex_double.h"
    #include "gsl/gsl_block_complex_float.h"
    #include "gsl/gsl_block_complex_long_double.h"
    #include "gsl/gsl_block_double.h"
    #include "gsl/gsl_block_float.h"
    #include "gsl/gsl_block_int.h"
    #include "gsl/gsl_block_long.h"
    #include "gsl/gsl_block_long_double.h"
    #include "gsl/gsl_block_short.h"
    #include "gsl/gsl_block_uchar.h"
    #include "gsl/gsl_block_uint.h"
    #include "gsl/gsl_block_ulong.h"
    #include "gsl/gsl_block_ushort.h"
%}
%include "gsl/gsl_block.h"
%include "gsl/gsl_block_char.h"
%include "gsl/gsl_block_complex_double.h"
%include "gsl/gsl_block_complex_float.h"
%include "gsl/gsl_block_complex_long_double.h"
%include "gsl/gsl_block_double.h"
%include "gsl/gsl_block_float.h"
%include "gsl/gsl_block_int.h"
%include "gsl/gsl_block_long.h"
%include "gsl/gsl_block_long_double.h"
%include "gsl/gsl_block_short.h"
%include "gsl/gsl_block_uchar.h"
%include "gsl/gsl_block_uint.h"
%include "gsl/gsl_block_ulong.h"
%include "gsl/gsl_block_ushort.h"

%perlcode %{

@EXPORT_OK = qw/gsl_block_alloc gsl_block_calloc gsl_block_free 
                gsl_block_fread gsl_block_fwrite gsl_block_fscanf 
                gsl_block_fprintf gsl_block_raw_fread gsl_block_raw_fwrite 
                gsl_block_raw_fscanf gsl_block_raw_fprintf gsl_block_size 
                gsl_block_data 
            /;

%EXPORT_TAGS = ( all => [ @EXPORT_OK ] );


%}
