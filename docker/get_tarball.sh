#! /bin/bash

version=$(perl -nE '/our\s+\$VERSION\s*=\s*.(\d+\.\d+)/ and do {print $1; exit}' ../lib/Math/GSL.pm)
docker cp math-gsl-ubuntu-2004:/math--gsl/Math-GSL-"$version".tar.gz .
