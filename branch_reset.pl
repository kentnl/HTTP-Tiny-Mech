#!/usr/bin/env perl
use strict;
use warnings;

use FindBin;
use lib "$FindBin::Bin/lib";
use tools;

if ( not env_true('TRAVIS') ) {
  diag('Is not running under travis!');
  exit 1;
}
diag("Resetting branch to \e[32m$ENV{TRAVIS_BRANCH}\e[0m @ \e[33m$ENV{TRAVIS_COMMIT}\e[0m");
git( 'checkout', $ENV{TRAVIS_BRANCH} );
git( 'reset', '--hard', $ENV{TRAVIS_COMMIT} );

