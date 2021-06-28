#! /bin/bash

if [[ -n $PERL_DIR ]] ; then
    PERL_DIR="${PERL_DIR/#\~/$HOME}"
    echo "PERL_NAME=$PERL_NAME" >> $GITHUB_ENV
    echo "PERL_DIR=$PERL_DIR" >> $GITHUB_ENV
    export PATH=$PERL_DIR/bin:"$PATH"
fi
if [[ -n $GSL_DIR ]] ; then
    # autoconf needs an absolute prefix to install GSL, replace tilde with $HOME
    GSL_DIR="${GSL_DIR/#\~/$HOME}"
    echo "GSL_NAME=$GSL_NAME" >> $GITHUB_ENV
    echo "GSL_DIR=$GSL_DIR" >> $GITHUB_ENV
    export LD_LIBRARY_PATH=$GSL_DIR/lib
    export PATH=$GSL_DIR/bin:"$PATH"
    export PKG_CONFIG_PATH="$GSL_DIR"/lib/pkgconfig
fi

echo "LD_LIBRARY_PATH=$LD_LIBRARY_PATH" >> $GITHUB_ENV
echo "PATH=$PATH" >> $GITHUB_ENV
echo "PKG_CONFIG_PATH=$PKG_CONFIG_PATH" >> $GITHUB_ENV
