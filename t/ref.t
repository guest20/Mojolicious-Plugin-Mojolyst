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
$t->get_ok('/ref')->status_is(200)->content_is('Mojolicious::Controller');
$t->get_ok('/')->status_is(200)->content_is('Mojolicious::Controller');

done_testing();
