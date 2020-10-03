# Math::GSL

Math::GSL is a Perl interface to the [GNU Scientific Library](http://www.gnu.org/software/gsl/), using [SWIG](http://swig.org).  The GNU
Scientific Library (GSL) is a numerical library for C and C++ programmers. It
is free Software under the GNU General Public License.  Math::GSL uses SWIG to
generate Perl bindings to *most* GSL functionality.

[![Build Status](https://secure.travis-ci.org/leto/math--gsl.png)](http://travis-ci.org/leto/math--gsl)

# Dependencies

Currently `Math::GSL` requires at least Perl 5.8.1 to compile.

## Library dependencies

- GSL version 1.15 or larger. If you have installed GSL on your system,
the location of the library files are determined by running the
`gsl-config` binary. If it cannot be found
in your `PATH`, [PkgConfig](http://metacpan.org/release/PkgConfig/) is
tried to locate GSL.

- If you have not installed GSL on your system,
[`Alien::GSL`](https://metacpan.org/pod/Alien::GSL) is used to
install the latest version on your system. `Alien::GSL` depends
on [`Net::SSLeay`](https://metacpan.org/pod/Net::SSLeay) to download
the library, which requires that you have
installed `libssl-dev` and `libz-dev` (on Debian platforms, or similar
libraries on other platforms).


# Installation

To install this module, run

```
cpanm Math::GSL
```

or download the tarball distribution
from [metacpan.org](https://metacpan.org/pod/Math::GSL) and run the following
commands:

    perl Build.PL
    ./Build
    ./Build test
    ./Build install clean

# Support

After installing, you can find documentation for this module with the
perldoc command.

    perldoc Math::GSL

You can also look for information at:

MetaCPAN: https://metacpan.org/release/Math-GSL

Known bugs/issues: https://github.com/leto/math--gsl/issues/

AnnoCPAN, Annotated CPAN documentation http://annocpan.org/dist/Math::GSL

CPAN Ratings http://cpanratings.perl.org/d/Math::GSL

Search CPAN http://search.cpan.org/dist/Math::GSL


# Developer information

## Git repo dependencies

SWIG >= 2.x is needed to build `Math::GSL` from the git repo, version
2.0.8 or newer is required to work with Perl 5.20 and
higher. SWIG 3.x is recommended.

On OS X with Homebrew, you can install swig with:

    brew install swig

## Upgrading and uploading

- [Upgrading to a new GSL version](developer/wiki/Upgrade.md)
- [Uploading a new CPAN distribution](developer/wiki/Upload.md)

# Copyright and Licence

Copyright (C) 2008-2020 Jonathan "Duke" Leto and Thierry Moisan.

A full list of contributors is listed in the [CREDITS](https://github.com/leto/math--gsl/blob/master/CREDITS) file.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself. Fuck Yeah.

