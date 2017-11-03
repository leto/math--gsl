#!/bin/bash
set -ev

_get_gsl () {
    # only download if necessary
    if [ ! -e "gsl-$1.tar.gz" ]; then
        wget -q ftp://ftp.gnu.org/gnu/gsl/gsl-$1.tar.gz
    fi
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

_get_master_gsl () {
    
    rmdir "gsl-master" && echo "removed empty gsl-master directory"

    if [ ! -d "gsl-master" ]; then
        git clone git://git.savannah.gnu.org/gsl.git gsl-master
        cd gsl-master
    else
        cd gsl-master
        ls -la
        [ -d ".git" ] && git pull origin master
    fi

    GSL_COMMIT=`git rev-parse master`
    echo "Testing GSL master commit $GSL_COMMIT"

    ./autogen.sh
    ./configure --enable-maintainer-mode --prefix /tmp/gsl-master
    make -j2
    make -j2 install
    cd ..
}

get_master_gsl () {
    _get_master_gsl
    #_get_master_gsl &> /dev/null
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
get_gsl 2.3
get_gsl 2.4
get_master_gsl

GSL_CURRENT_DIR=/tmp/gsl-2.4

ls -la /tmp/
ls -la $GSL_CURRENT_DIR/bin
cd $TRAVIS_BUILD_DIR
export LD_LIBRARY_PATH=$GSL_CURRENT_DIR/lib:$LD_LIBRARY_PATH
export PATH=$GSL_CURRENT_DIR/bin:$PATH

# create a CPAN dist with latest supported GSL release
perl Build.PL                                   \
    && ./Build                                  \
    && ./Build dist

cp Math-GSL*.tar.gz /tmp

# now we have a CPAN dist to test on each version of GSL
ls -la /tmp/Math-GSL*.tar.gz
cd $ORIG_DIR

