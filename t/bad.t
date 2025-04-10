package MyApp::Controller::Foo;
use Mojolicious::Lite;

get '/' => {text => 'Welcome to Mojolyst!'};

package main;
use Mojo::Base -strict;

use Test::More;
use Mojolicious::Lite;

use lib 't/lib';
plugin('Mojolyst' => {controllers => 'Test::Mojolicious::Plugin::Mojolyst'});

my $log = join '-|-', map {join ' ', @$_ } @{ app->log->history };
diag "startup log: $log"; 
like $log, qr/\Qdied: syntax error/;
like $log, qr/Test::Mojolicious::Plugin::Mojolyst::BadApp/;

done_testing();
