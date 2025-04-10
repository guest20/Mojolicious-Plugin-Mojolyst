package MyApp::Controller::Foo;
use Mojolicious::Lite;

get '/' => {text => 'Welcome to Mojolyst!'};

package main;
use Mojo::Base -strict;

use Test::More;
use Mojolicious::Lite;
use Test::Mojo;

my $t = Test::Mojo->new;
$t->app->log->level('trace');
plugin 'Mojolyst' => {controllers => 'MyApp::Controller'};
like +(join '-|-', map { join ' ', @$_ } @{ $t->app->log->history }), qr/Mojolyst: Test::BadApp died: syntax error at",/, ;

$t->get_ok('/')->status_is(200)->content_is('Welcome to Mojolyst!');


done_testing();
