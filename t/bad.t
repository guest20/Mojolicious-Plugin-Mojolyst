package MyApp::Controller::Foo;
use Mojolicious::Lite;

get '/' => {text => 'Welcome to Mojolyst!'};

package main;
use Mojo::Base -strict;
use Test::More;
use Test::Mojo;

use Mojolicious::Lite;
my $t = Test::Mojo->new;
use lib 't/lib';
plugin 'Mojolyst' => {controllers => 'Test'};

$t->app->log->level('trace');
$t->get_ok('/')->status_is(200)->content_is('Welcome to Mojolyst!');

like qr/Mojolyst: Test::BadApp died: syntax error at",/, join '-|-', map { $_->[2] } @{ $t->app->log->history };

done_testing();
