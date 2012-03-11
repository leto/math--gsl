# Math::GSL

Math::GSL is an interface to the [GNU Scientific Library](http://www.gnu.org/software/gsl/), using [SWIG](http://swig.org).  The GNU
Scientific Library (GSL) is a numerical library for C and C++ programmers. It
is free software under the GNU General Public License.  Math::GSL uses SWIG to
generate Perl bindings to *most* GSL functionality.

# Dependencies

## CPAN distribution dependencies

Currently Math::GSL requires at least Perl 5.8.x and GSL 1.11 to compile. It
also requires [ExtUtils::PkgConfig](http://metacpan.org/release/ExtUtils-PkgConfig/) to find GSL and Module::Build.


## Git repo dependencies

SWIG 2.x is needed to build Math::GSL from the git repo, in addition to all
the dependencies above.

# Installation

To install this module, run the following commands:

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


# Copyright and Licence

Copyright (C) 2008-2012 Jonathan "Duke" Leto and Thierry Moisan.

A full list of contributors is listed in the [CREDITS](https://github.com/leto/math--gsl/blob/master/CREDITS) file.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself. Fuck Yeah.
