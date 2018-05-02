#!/bin/bash
set -ev

get_gsl () {

    if [ "$1" = master ] ; then
        get_gsl_master
    else
        get_gsl_version $1 &> /dev/null

    fi
}

get_gsl_version () {
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


get_master_gsl () {

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


cpanm -n PkgConfig
export ORIG_DIR=`pwd`
echo ORIG_DIR=$ORIG_DIR
cd /tmp
ls -la /tmp/
get_gsl $GSL
get_gsl $GSL_CURRENT

ls -la /tmp/
ls -la /tmp/gsl-${GSL_CURRENT}/bin
cd $TRAVIS_BUILD_DIR
LD_LIBRARY_PATH=/tmp/gsl-${GSL_CURRENT}/lib:$LD_LIBRARY_PATH PATH=/tmp/gsl-${GSL_CURRENT}/bin:$PATH perl Build.PL && ./Build && ./Build dist # create a CPAN dist with latest supported GSL release
cp Math-GSL*.tar.gz /tmp
ls -la /tmp/Math-GSL*.tar.gz # now we have a CPAN dist to test on each version of GSL
cd $ORIG_DIR
