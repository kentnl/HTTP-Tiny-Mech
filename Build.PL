
use strict;
use warnings;

use Module::Build 0.3601;


my %module_build_args = (
  "build_requires" => {
    "File::Find" => 0,
    "File::Temp" => 0,
    "Module::Build" => "0.3601",
    "Test::More" => "0.88"
  },
  "configure_requires" => {
    "Module::Build" => "0.3601"
  },
  "dist_abstract" => "Wrap a WWW::Mechanize instance in an HTTP::Tiny compatible interface.",
  "dist_author" => [
    "Kent Fredric <kentnl\@cpan.org>"
  ],
  "dist_name" => "HTTP-Tiny-Mech",
  "dist_version" => "0.1.0",
  "license" => "perl",
  "module_name" => "HTTP::Tiny::Mech",
  "recommends" => {},
  "recursive_test_files" => 1,
  "requires" => {
    "HTTP::Request" => 0,
    "HTTP::Tiny" => 0,
    "Moose" => 0,
    "MooseX::NonMoose" => 0,
    "WWW::Mechanize" => 0,
    "strict" => 0,
    "warnings" => 0
  },
  "script_files" => []
);


my $build = Module::Build->new(%module_build_args);

$build->create_build_script;
