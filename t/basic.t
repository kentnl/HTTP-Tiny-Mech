use strict;
use warnings;

use Test::More tests => 3;
use HTTP::Tiny::Mech;
use HTTP::Tiny 0.022;

subtest basic => sub {
  my $instance = HTTP::Tiny::Mech->new();
  isa_ok( $instance,         'HTTP::Tiny' );
  isa_ok( $instance,         'HTTP::Tiny::Mech' );
  isa_ok( $instance->mechua, 'WWW::Mechanize' );
};

subtest "Parameters for HTTP::Tiny::Mech" => sub {
  {

    package Foo;
    @Foo::ISA = ('WWW::Mechanize');
  }
  {

    package Bar;
    @Bar::ISA = ('WWW::Mechanize');
  }
  my $instance = HTTP::Tiny::Mech->new( mechua => Foo->new(), );
  isa_ok( $instance,         'HTTP::Tiny' );
  isa_ok( $instance,         'HTTP::Tiny::Mech' );
  isa_ok( $instance->mechua, 'WWW::Mechanize' );
  isa_ok( $instance->mechua, 'Foo' );
  subtest "Set mechua" => sub {
    $instance->mechua( Bar->new() );
    isa_ok( $instance->mechua, 'WWW::Mechanize' );
    isa_ok( $instance->mechua, 'Bar' );
  };

};

subtest "Parameters for HTTP::Tiny" => sub {
  my %test_map = (
    agent         => "Test::Version/1.0",
    local_address => "123.4.5.6",
  );
  for my $key ( sort keys %test_map ) {
    my $instance = HTTP::Tiny::Mech->new( $key => $test_map{$key} );
    can_ok( $instance, $key ) and is( $instance->$key(), $test_map{$key}, "Value pass through" );
  }
};
