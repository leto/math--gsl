# Upgrading to support a new version of GSL

## The travis build script

When upgrading to a new version, the travis CI builds will tell us
when something is not right. Currently we are building and testing
for 58 different setups (combinations of GSL version and perl version).

### Stage 1
For each setup, the build script first builds a CPAN distribution 
`Math-GSL-yy.xx.tar.gz` where `yy.xx` is the current version (as
defined by the GSL_CURRENT environment variable, see
`.travis.yml`). 

First `perl Build.PL` is run. It uses `gsl-config` to determine the 
installed version of GSL on the system. Here you can change the `PATH`
environment variable before calling `perl Build.PL` in order for 
it to use another version of `GSL` if you have multiple versions
installed. 

Then, `Build.PL` extracts the GSL version by running `gsl-config` and
writes this information to `swig/system.i`. Then it generates a script
called `Build`.

Next, `Build` is called, which will iterate through all the versions as given in
the `@ver2func` array in `inc/Ver2Func.pm`. For each version,
it first generates a `rename.i` file in the `swig/` directory
based on the version in `@ver2func` and then runs the `swig` command on all
interface files found in the `swig/` directory that also matches the
current subsystem information found in `@ver2func` for the current version.

The output of each `swig` call is a `.pm` which is put in the `pm/`
directory, and a `.c` file which is put in the `xs/` directory.

After `Build` is finished, travis calls `Build dist` to generate a
CPAN distribution archive file. This will include all the files listed
in the `MANIFEST` file.

NOTE: no tests (the test files are in the `t/` directory) are run at
this stage.

### Stage 2

In this stage, the travis build script tries to build the cpan
distribution generated in stage 1 above for each version of GSL as
given by the value of the GSL variable in `.travis.yml` and for each
version of perl in the `perl` key in `.travis.yml`.

This stage first extracts the distribution, then runs `perl Build.PL`,
`./Build`, and finally `./Build test` runs the tests as given in the
`/t` directory.

## What to do?

### Update MANIFEST

#### Add C files for the new distribution


#### Add pm files for the new distribution


### Update tavis.yml

#### Update GSL_CURRENT in env:global

#### Update env:matrix with the previous version

### Update Ver2Func.pm

This is the main part of the upgrading work, and it can be time consuming
depending on the number of new features that has been added. 

First, add a new hash entry to the end of the `@ver2func` array.
Now, all functions that are new to this version compared to the
previous version should be added in the `new` item of the hash.
How to determine which items are new? The brute force approach is 
to run the test suite repeatedly looking at the failed tests will
given an indication of the names of the new functions. 

When all the tests passes, we can be confident that we have added
most of the new functions. 

There can also be C structures that have been rewritten in the new
version compared to the old such that the names/fields in the structure are
different. Since swig generates accessor functions for the structures 
it will typically also lead to failed tests.

An example:

[coming soon]



