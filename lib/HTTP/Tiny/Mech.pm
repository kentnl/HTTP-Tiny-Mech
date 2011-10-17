use strict;
use warnings;

package HTTP::Tiny::Mech;
BEGIN {
  $HTTP::Tiny::Mech::AUTHORITY = 'cpan:KENTNL';
}
{
  $HTTP::Tiny::Mech::VERSION = '0.1.0';
}

# ABSTRACT: Wrap a WWW::Mechanize instance in an HTTP::Tiny compatible interface.

use Moose;
use MooseX::NonMoose;
extends 'HTTP::Tiny';

has 'mechua' => (
  is         => 'rw',
  lazy_build => 1,
);



sub _build_mechua {
  require WWW::Mechanize;
  return WWW::Mechanize->new();
}

sub _unwrap_response {
  my ( $self, $response ) = @_;
  return {
    status  => $response->code,
    reason  => $response->message,
    headers => $response->headers,
    success => 1,
    content => $response->content,
  };
}

sub _wrap_request {
  my ( $self, $method, $uri, $opts ) = @_;
  require HTTP::Request;
  my $req = HTTP::Request->new( $method, $uri );
  $req->headers( $opts->{headers} ) if $opts->{headers};
  $req->content( $opts->{content} ) if $opts->{content};
  return $req;
}


sub get {
  my ( $self, $uri, $opts ) = @_;
  return $self->_unwrap_response( $self->mechua->get( $uri, $opts ) );
}


sub request {
  my $self     = shift;
  my $req      = $self->_wrap_request(@_);
  my $response = $self->mechua->request($req);
  return $self->_unwrap_response($response);
}

__PACKAGE__->meta->make_immutable;
no Moose;

1;

__END__
=pod

=head1 NAME

HTTP::Tiny::Mech - Wrap a WWW::Mechanize instance in an HTTP::Tiny compatible interface.

=head1 VERSION

version 0.1.0

=head1 SYNOPSIS

  # Get something that expects an HTTP::Tiny instance
  # to work with HTTP::Mechanize under the hood.
  #
  my $thing => ThingThatExpectsHTTPTiny->new(
    ua => HTTP::Tiny::Mech->new()
  );

  # Get something that expects HTTP::Tiny
  # to work via WWW::Mechanize::Cached
  #
  my $thing => ThingThatExpectsHTTPTiny->new(
    ua => HTTP::Tiny::Mech->new(
      mechua => WWW::Mechanize::Cached->new( )
    );
  );

=head1 DESCRIPTION

This code is somewhat poorly documented, and highly experimental.

Its the result of a quick bit of hacking to get L<MetaCPAN::API> working faster
via the L<WWW::Mechanize::Cached> module ( and gaining cache persistence via
L<CHI> )

It works so far for this purpose.

At present, only L</get> and L</request> are implemented, and all other calls
fall through to a native L<HTTP::Tiny>.

=head1 WRAPPED METHODS

=head2 get

Interface should be the same as it is with L<HTTP::Tiny/get>.

=head2 request

Interface should be the same as it is with L<HTTP::Tiny/request>

=head1 AUTHOR

Kent Fredric <kentnl@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Kent Fredric <kentnl@cpan.org>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

