#!/usr/bin/env perl

use strict;
use warnings;
use Math::GSL::SF      qw/:all/;
use Data::Dumper;

my $r      = Math::GSL::SF::gsl_sf_result_struct->new;
my $status = gsl_sf_mathieu_ce(0,0,0,$r);
warn Dumper [$status, $r->{err}, $r->{val} ];
