#! /bin/bash

# NOTE: perl version 5.26.1 is already installed (on Ubuntu 20.04),
#   but we would like to not mess with that, so we install a custom perl.

BUILD_DIR=$PERL_DIR/build
INSTALL_DIR=$PERL_DIR
mkdir -p $BUILD_DIR
cd "$BUILD_DIR"
ZIP_NAME=${PERL_NAME}.tar.gz
wget https://www.cpan.org/src/5.0/$ZIP_NAME
ZIP_TYPE=$(perl -pe 's/^.*\.([^.]*)$/$1/' <<<$ZIP_NAME)
TAR_NAME=$(perl -pe 's/^(.*)\.[^.]*$/$1/' <<<$ZIP_NAME)
if [[ $ZIP_TYPE == 'gz' ]] ; then
    gunzip $ZIP_NAME
elif [[ $ZIP_TYPE == 'bz2' ]] ; then
    bunzip2 $ZIP_NAME
else
    echo "Unknown archive type: $ZIP_TYPE"
    exit 1
fi
tar xvf $TAR_NAME
PERL_DIR2=$(perl -pe 's/\.tar$//' <<<$TAR_NAME)
cd $PERL_DIR2
sh Configure -des -Dprefix=$INSTALL_DIR -Dman1dir=none -Dman3dir=none
make
make install
export PATH=$INSTALL_DIR/bin:$PATH
echo "PATH=$PATH" >> $GITHUB_ENV
perl --version
cpan -v
cpan App::cpanminus

