#!/bin/bash

set -euv

: ${GSL_INST_DIR:?environment variable not specified}
: ${GSL_SRC_DIR:?environment variable not specified}
: ${DIST_DIR:?environment variable not specified}
: ${GSL:?environment variable not specified}
: ${GSL_CURRENT:?environment variable not specified}

mkdir -p $GSL_SRC_DIR
mkdir -p $GSL_INST_DIR

get_gsl () {

    if [ "$1" = master ] ; then
        get_gsl_master
    else
        get_gsl_version $1 &> /dev/null

    fi
}

get_gsl_version () (

    set -euv
    cd $GSL_SRC_DIR

    # only download if necessary
    if [ ! -e "gsl-$1.tar.gz" ]; then
        wget -q ftp://ftp.gnu.org/gnu/gsl/gsl-$1.tar.gz
    fi
    tar zxpf gsl-$1.tar.gz
    cd gsl-$1
    ./configure --prefix $GSL_INST_DIR/gsl-$1
    make -j2
    make -j2 install
)


get_gsl_master () (

    set -euv
    cd $GSL_SRC_DIR

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
    ./configure --enable-maintainer-mode --prefix $GSL_INST_DIR/gsl-master
    make -j2
    make -j2 install
)

ls -la $GSL_SRC_DIR
get_gsl $GSL
get_gsl $GSL_CURRENT

ls -la $GSL_INST_DIR
ls -la ${GSL_INST_DIR}/gsl-${GSL_CURRENT}/bin

if [ -n "$TRAVIS_BUILD_DIR" ] ; then

    # perform in subshell to avoid polluting this shell
    (
	cpanm -n PkgConfig
	cd $TRAVIS_BUILD_DIR

	export LD_LIBRARY_PATH=$GSL_INST_DIR/gsl-${GSL_CURRENT}/lib${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}
	PATH=$GSL_INST_DIR/gsl-${GSL_CURRENT}/bin:$PATH

	perl Build.PL && ./Build && ./Build dist # create a CPAN dist with latest supported GSL release
	cp Math-GSL*.tar.gz $DIST_DIR
	ls -la ${DIST_DIR}/Math-GSL*.tar.gz # now we have a CPAN dist to test on each version of GSL
    )
fi
