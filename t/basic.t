package MyApp::Controller::Foo;
use Mojolicious::Lite;

helper jank => sub { 'Welcome to this helper' };
get '/helper' => sub { $_[0]->render(text => $_[0]->jank) };

our $startup_hook_fired=0;
hook before_server_start => sub { $startup_hook_fired ++ };
get '/hooked' => sub { $_[0]->render(text => $startup_hook_fired) };

get '/' => {text => 'Welcome to Mojolyst!'};

package main;
use Mojo::Base -strict;

use Test::More;
use Mojolicious::Lite;
get '/foreigner' => sub { $_[0]->render(text => $_[0]->jank) };
use Test::Mojo;

plugin 'Mojolyst' => {controllers => 'MyApp::Controller'};

my $t = Test::Mojo->new;
$t->get_ok('/')->status_is(200)->content_is('Welcome to Mojolyst!');
$t->get_ok('/hooked')->status_is(200)->content_isnt(0);
$t->get_ok('/helper')->status_is(200)->content_is('Welcome to this helper');
$t->get_ok('/foreigner')->status_is(200)->content_is('Welcome to this helper');

done_testing();
