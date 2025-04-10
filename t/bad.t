package MyApp::Controller::Foo;
use Mojolicious::Lite;

get '/' => {text => 'Welcome to Mojolyst!'};

package main;
use Mojo::Base -strict;

use Test::More;
use Mojolicious::Lite;
use Test::Mojo;

my $t = Test::Mojo->new;
plugin 'Mojolyst' => {controllers => 'MyApp::Controller'};

$t->app->log->level('trace');
$t->get_ok('/')->status_is(200)->content_is('Welcome to Mojolyst!');

like +(join '-|-', map { join ' ', @$_ } @{ $t->app->log->history }), qr/Mojolyst: Test::BadApp died: syntax error at",/, ;

done_testing();
