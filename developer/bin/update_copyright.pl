#! /usr/bin/env perl

# See developer/wiki/Upload.md for usage information..

use feature qw(say);
use strict;
use warnings;
use File::Find;

{
    my $year = @{[localtime]}[5] + 1900;
    say "Using year = $year..";
    chdir "../..";
    die "Could not find lib and pod dirs!" if !((-d 'lib') && (-d 'pod'));
    File::Find::find(sub {find_helper($year)}, ".");
}

sub find_helper {
    my ($year) = @_;
    my $fn = $_;
    return if !(-f $fn);
    return if $fn !~ /\.pod$/;

    system 'perl', '-i', '-spE',
      '$line = $_;
       if (s/Copyright \(C\) 2008-\K\d+/$year/) {
          print STDOUT "$fullpath: $line";
       }',
      '--', "-fn=$fn", "-year=$year", "-fullpath=$File::Find::name", '--', $fn;
}
