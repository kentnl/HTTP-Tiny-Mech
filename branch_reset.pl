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
my $goodtag;
do {
  my $output = capture_stdout {
    git( 'describe', '--tags', '--abbrev=0', $ENV{TRAVIS_BRANCH} );
  };
  ($goodtag) = split /\n/, $output;
};
diag("TIP Version tag is \e[32m$goodtag\e[0m");
my @tags;
do {
  my $output = capture_stdout {
    git('tag');
  };
  @tags = split /\n/, $output;
};
for my $tag (@tags) {
  next if $tag eq $goodtag;
  git( 'tag', '-d', $tag );
}

