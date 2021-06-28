#! /bin/bash

GSL_MIRROR=http://mirrors.kernel.org/gnu/gsl
BUILD_DIR=$GSL_DIR/build
INSTALL_DIR=$GSL_DIR
mkdir -p $BUILD_DIR
cd "$BUILD_DIR"
export PATH=$PERL_DIR/bin:$PATH
ZIP_NAME="$GSL_NAME".tar.gz
wget "$GSL_MIRROR"/"$ZIP_NAME" --retry-connrefused --timeout=900
tar zxvf "$ZIP_NAME"
cd "$GSL_NAME"
./configure --prefix "$INSTALL_DIR"
make -j$(nproc)
make install
echo "PATH=$PATH" >> $GITHUB_ENV
