
use strict;
use warnings;

use Module::Build 0.3601;


my %module_build_args = (
  "build_requires" => {
    "Module::Build" => "0.4202"
  },
  "configure_requires" => {
    "Module::Build" => "0.4202"
  },
  "dist_abstract" => "Wrap a WWW::Mechanize instance in an HTTP::Tiny compatible interface.",
  "dist_author" => [
    "Kent Fredric <kentnl\@cpan.org>",
    "Pedro Melo <melo\@simplicidade.org>"
  ],
  "dist_name" => "HTTP-Tiny-Mech",
  "dist_version" => "0.2.1",
  "license" => "perl",
  "module_name" => "HTTP::Tiny::Mech",
  "recommends" => {},
  "recursive_test_files" => 1,
  "requires" => {
    "Class::Tiny" => 0,
    "HTTP::Request" => 0,
    "HTTP::Tiny" => "0.022",
    "WWW::Mechanize" => 0,
    "parent" => 0,
    "perl" => "5.006",
    "strict" => 0,
    "warnings" => 0
  },
  "script_files" => [],
  "test_requires" => {
    "HTTP::Tiny" => "0.022",
    "Test::More" => "1.001002"
  }
);


my %fallback_build_requires = (
  "HTTP::Tiny" => "0.022",
  "Module::Build" => "0.4202",
  "Test::More" => "1.001002"
);


unless ( eval { Module::Build->VERSION(0.4004) } ) {
  delete $module_build_args{test_requires};
  $module_build_args{build_requires} = \%fallback_build_requires;
}

my $build = Module::Build->new(%module_build_args);

$build->create_build_script;
