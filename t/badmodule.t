use Mojo::Base -strict;

use Test::More;
use Mojolicious::Lite;
use Test::Mojo;

use File::Basename qw( dirname );
use lib join '/', dirname($0), 'lib';

subtest "default" => sub {
  plugin 'Mojolyst' => {controllers => 'MyApp::Controller'};
  ok(1, "Sure.");
};

subtest "dies" => sub {
  my @warnings; $SIG{__WARN__} = sub { push @warnings, shift };
  plugin 'Mojolyst' => {controllers => 'MyApp::Controller', errors => 'warn'};
  is_deeply(\@warnings, [], "BadModule produced a warning");
};

subtest "dies" => sub {
  my ($survived, $e);
  eval {
    plugin 'Mojolyst' => {controllers => 'MyApp::Controller', errors => 'die'};
    $survived=1;
  1} or do { 
    $e = $@;
   };
  is($survived, undef, "exceptions are fatal");
  is($e, "", "died when loading a controller that doesn't load");
};

done_testing();
