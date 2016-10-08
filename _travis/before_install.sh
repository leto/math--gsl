#!/bin/bash
set -ev

_get_gsl () {
    wget -q ftp://ftp.gnu.org/gnu/gsl/gsl-$1.tar.gz
    tar zxpf gsl-$1.tar.gz
    cd gsl-$1
    ./configure --prefix /tmp/gsl-$1
    make -j2
    make -j2 install
    cd ..
}

get_gsl () {
    _get_gsl $1 &> /dev/null
}

cpanm -n PkgConfig
export ORIG_DIR=`pwd`
echo ORIG_DIR=$ORIG_DIR
cd /tmp
get_gsl 1.15
get_gsl 1.16
get_gsl 2.0
get_gsl 2.1
get_gsl 2.2.1
ls -la /tmp/gsl-*/lib
cd /home/travis/build/leto/math--gsl
PATH=/tmp/gsl-2.2.1/bin:$PATH perl Build.PL &>/dev/null && ./Build &>/dev/null && ./Build dist # create a CPAN dist with latest GSL
cp Math-GSL*.tar.gz /tmp
ls -la /tmp/Math-GSL*.tar.gz # now we have a CPAN dist to test on each version of GSL
cd $ORIG_DIR

