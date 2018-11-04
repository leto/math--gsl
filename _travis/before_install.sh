#!/bin/bash


set -u

: ${GSL_INST_DIR:?environment variable not specified}
: ${GSL_SRC_DIR:?environment variable not specified}
: ${GSL:?environment variable not specified}
: ${GSL_CURRENT:?environment variable not specified}
: ${GSL_MIRROR:=http://mirrors.kernel.org/gnu/gsl}

banner () {

    echo
    echo "==================================================="

}

die () {

    echo >&2 $@
    banner 
    exit 1
}

get_gsl () (

    if [ "$1" = master ] ; then
        get_gsl_master
    else
        get_gsl_version $1
    fi
)

list_cache () {

    banner

    echo "Source directory: $GSL_SRC_DIR"
    ls -al $GSL_SRC_DIR

    
    echo "Installation directory: $GSL_INST_DIR"
    find $GSL_INST_DIR -name gsl-config
}


get_gsl_version () (

    cd $GSL_SRC_DIR

    banner

    if [ ! -e $GSL_INST_DIR/gsl-$1/bin/gsl-config ]; then

        echo "GSL $1 has not been built and installed"

        # only download if necessary
        if [ ! -e "gsl-$1.tar.gz" ]; then
            echo "Retrieving GSL $1"
            wget -q $GSL_MIRROR/gsl-$1.tar.gz \
                 --retry-connrefused \
                 --timeout=900 \
                || die "Error retrieving GSL $1"
        fi

        rm -rf gsl-$1 || die "Error removing existing build"

        echo
        echo "Extracting..."
        tar zxpf gsl-$1.tar.gz \
            || die "Error extracting"

        cd gsl-$1

        echo
        echo "Configuring..."
        ./configure --prefix $GSL_INST_DIR/gsl-$1 \
                    || die "Error Configuing"

        echo
        echo "Building..."
        if ! make -j2 >& make.log ; then
            cat make.log
            die "Error Building"
        fi

        echo
        echo "Installing..."
        if ! make -j2 install >& install.log ; then
            cat install.log
            die "Error Installing"
        fi

        rm -rf gsl-$1 || die "Error removing existing build"

    else
        echo "GSL $1 already installed"
    fi

    banner
)

get_gsl_master () (

    banner

    cd $GSL_SRC_DIR

    if [ -d gsl-master -a ! -d gsl-master/.git ] ; then

        echo
        echo "Removing existing but incomplete gsl-master directory"
        rm -rf gsl-master || die "Error removing gsl-master"
    fi


    if [ ! -d "gsl-master" ]; then

        echo
        echo "Cloning master from repo"
        git clone git://git.savannah.gnu.org/gsl.git gsl-master \
            || die "Error cloning GSL master"

    else

        echo
        echo "Updating from repo"
        git \
            --git-dir=gsl-master/.git \
            --work-tree=gsl-master \
            pull origin master \
          || die "Error updating working dir"

    fi


    GSL_COMMIT=$(git --git-dir=gsl-master/.git rev-parse master)

    if [ ! -e $GSL_INST_DIR/gsl-master/$GSL_COMMIT ]; then

        echo
        echo "GSL master $GSL_COMMIT has not been built and installed"

        cd gsl-master || die "Where's $GSL_SRC_DIR/gsl-master"

        echo
        echo "Bootstrapping..."
        ./autogen.sh || die "error bootstrapping"

        echo
        echo "Configuring..."
        ./configure --enable-maintainer-mode --enable-silent-rules --prefix $GSL_INST_DIR/gsl-master \
            || die "error configuring"

        echo
        echo "Building..."
        if ! make -j2 >& make.log ; then
            cat make.log
            die "Error Building"
        fi

        echo
        echo "Installing..."
        if ! make -j2 install >& install.log ; then
            cat install.log
            die "Error Installing"
        fi

        touch $GSL_INST_DIR/gsl-master/$GSL_COMMIT

    else

        echo
        echo "GSL master $GSL_COMMIT already installed"

    fi
    banner

)

mkdir -p $GSL_SRC_DIR
mkdir -p $GSL_INST_DIR

list_cache

echo "Testing agains GSL $GSL; Building with GSL $GSL_CURRENT"
echo

set -e

get_gsl $GSL
if [ $GSL != $GSL_CURRENT ] ; then
    get_gsl $GSL_CURRENT
fi


if [ -n "$TRAVIS_BUILD_DIR" ] ; then

    : ${DIST_DIR:?environment variable not specified}

    # perform in subshell to avoid polluting this shell
    (
        set -v
	cpanm -n PkgConfig
	cd $TRAVIS_BUILD_DIR

	export LD_LIBRARY_PATH=$GSL_INST_DIR/gsl-${GSL_CURRENT}/lib${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}
	PATH=$GSL_INST_DIR/gsl-${GSL_CURRENT}/bin:$PATH

	perl Build.PL && ./Build && ./Build dist # create a CPAN dist with latest supported GSL release
	cp Math-GSL*.tar.gz $DIST_DIR
	ls -la ${DIST_DIR}/Math-GSL*.tar.gz # now we have a CPAN dist to test on each version of GSL
    )
fi
