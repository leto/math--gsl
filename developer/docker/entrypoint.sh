#! /bin/bash

if (( $# != 1)) || [[ -z $1 ]] ; then
    echo "Bad arguments. Please specify version of GSL as first argument"
    exit
else
    echo "Using GSL_VERSION=$1 ..."
    export GSL_VERSION="$1"
fi
GSL_MIRROR=http://mirrors.kernel.org/gnu/gsl
CURDIR="$PWD"
GSL_INST_DIR="/tmp/gsl"
GSL_SRC_DIR="$CURDIR/gsl"
TARBALL_GSL=gsl-"$GSL_VERSION"
TARBALL="$TARBALL_GSL".tar.gz

install_gsl() {
    mkdir -p "$GSL_SRC_DIR"
    cd "$GSL_SRC_DIR"
    wget "$GSL_MIRROR"/"$TARBALL" --retry-connrefused --timeout=900 
    tar zxvf "$TARBALL"
    cd "$TARBALL_GSL"
    ./configure --prefix "$GSL_INST_DIR"/"$TARBALL_GSL"
    make -j$(nproc)
    make install
    cd "$CURDIR"
}

install_gsl
export LD_LIBRARY_PATH="$GSL_INST_DIR"/"$TARBALL_GSL"/lib
export PATH="$GSL_INST_DIR"/"$TARBALL_GSL"/bin:"$PATH"
git clone https://github.com/leto/math--gsl.git
cd math--gsl
cpanm -n Net::SSLeay
cpanm Alien::GSL
cpanm Module::Build
perl Build.PL
./Build installdeps --cpan_client cpanm
./Build
./Build test
./Build dist
mkdir -p /tmp/dist
mv *.tar.gz /tmp/dist

# Uncomment the following line if you do not want to immediately remove the container..
# exec bash
