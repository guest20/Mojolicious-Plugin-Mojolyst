package MyApp::Controller::Foo;
use Mojolicious::Lite, -signatures;

helper jank => sub { 'Welcome to this helper' };

our $startup_hook_fired;
hook before_server_start => sub { $startup_hook_fired ++ };
get '/hooked' => sub ($c) { $c->render( text => $startup_hook_fired) };

get '/' => {text => 'Welcome to Mojolyst!'};

package main;
use Mojo::Base -strict;

use Test::More;
use Mojolicious::Lite, -signatures;
use Test::Mojo;

get '/helper' => sub ($c) { $c->render(text => $c->jank) };
plugin 'Mojolyst' => {controllers => 'MyApp::Controller'};

my $t = Test::Mojo->new;
$t->get_ok('/')->status_is(200)->content_is('Welcome to Mojolyst!');
$t->get_ok('/hooked')->status_is(200)->content_is(1);
$t->get_ok('/helper')->status_is(200)->content_is('Welcome to this helper');

done_testing();
