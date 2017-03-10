use strict;
use warnings;

use Test::More;

# ABSTRACT: Test ->get with a dummy class

use HTTP::Tiny::Mech;
use HTTP::Tiny 0.022;
use lib 't/get';
use FakeUA;

my $instance = HTTP::Tiny::Mech->new( mechua => FakeUA->new(), );
isa_ok( $instance,         'HTTP::Tiny' );
isa_ok( $instance,         'HTTP::Tiny::Mech' );
isa_ok( $instance->mechua, 'FakeUA' );

subtest "get url" => sub {
  local $instance->mechua->{calls} = [];
  my $result = $instance->get('http://www.example.org:80/');
  is( ref $result, 'HASH', "Got a hash back" );
  note explain $instance;
};

subtest "get url + opts" => sub {
  local $instance->mechua->{calls} = [];
  my $result = $instance->get( 'http://www.example.org:80/', { args => {} } );
  is( ref $result, 'HASH', "Got a hash back" );
  note explain $instance;
};

subtest "request url" => sub {
  local $instance->mechua->{calls} = [];
  my $result = $instance->request( 'HEAD', 'http://www.example.org:80/' );
  is( ref $result, 'HASH', "Got a hash back" );
  note explain $instance;
};
subtest "request url + opts" => sub {
  local $instance->mechua->{calls} = [];
  my $result = $instance->request( 'POST', 'http://www.example.org:80/', { headers => {}, content => "CONTENT" } );
  is( ref $result, 'HASH', "Got a hash back" );
  note explain $instance;
};

done_testing;

