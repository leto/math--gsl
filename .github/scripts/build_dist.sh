#! /bin/bash

export LD_LIBRARY_PATH=${GSL_DIR}/lib
./Build dist
DISTNAME=$(ls -1 Math*.tar.gz)
echo "MATH_GSL_DISTNAME=$DISTNAME" >> $GITHUB_ENV
echo "$DISTNAME" > math-gsl-dist-name.txt
