package MyApp::Controller::Foo;
use Mojolicious::Lite;

get '/ref' => sub { $_[0]->render(text => ref $_[0]) };

package main;
use Mojo::Base -strict;

use Test::More;
use Mojolicious::Lite;
use Test::Mojo;
get '/' => sub { $_[0]->render(text => ref $_[0]) };

plugin 'Mojolyst' => {controllers => 'MyApp::Controller'};

my $t = Test::Mojo->new;
$t->get_ok('/ref')->status_is(200)->content_is(1);
$t->get_ok('/ref')->status_is(200)->content_is(1);

done_testing();
