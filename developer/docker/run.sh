#! /bin/bash

if (( $# != 1)) || [[ -z $1 ]] ; then
    echo "Bad arguments. Please specify version of GSL as first argument"
    exit
else
    echo "Using GSL=$1 ..."
    GSL_VERSION="$1"
fi

docker run --rm -v "$PWD":/tmp/dist --name math-gsl-ubuntu-2004 -it math-gsl-ubuntu-2004 "$GSL_VERSION"
