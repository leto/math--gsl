#! /bin/bash

perl --version
export PATH=$GITHUB_WORKSPACE/perl/bin:$PATH
echo "PATH=$PATH" >> $GITHUB_ENV
perl --version
cpan -v
#uname -a
#lsb_release -d
