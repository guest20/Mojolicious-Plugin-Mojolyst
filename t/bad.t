package MyApp::Controller::Foo;
use Mojolicious::Lite;

get '/' => {text => 'Welcome to Mojolyst!'};

package main;
use Mojo::Base -strict;

use Test::More;
use Mojolicious::Lite;
use Test::Mojo;
my $t = Test::Mojo->new;

plugin('Mojolyst' => {controllers => 'Test'});
like +(join '-|-', map { join ' ', @$_ } @{ app->log->history }), qr/Mojolyst: Test::BadApp died: syntax error at",/, ;



done_testing();
