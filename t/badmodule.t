use Mojo::Base -strict;

use Test::More;
use Mojolicious::Lite;
use Test::Mojo;

use File::Basename qw( dirname );
use lib join '/', dirname($0), 'lib';

subtest "default" => sub {
  eval {
    plugin 'Mojolyst' => {controllers => 'MyApp::Controller'} } 
  };
  like $@, qr/Can't locate object method "new" via package/, "existing behaviour";
};

subtest "dies" => sub {
  my @warnings; $SIG{__WARN__} = sub { push @warnings, shift };
  plugin 'Mojolyst' => {controllers => 'MyApp::Controller', errors => 'warn'};
  is($@,undef);
  is_deeply(\@warnings, [], "BadModule produced a warning");
};

subtest "dies" => sub {
  eval {
    plugin 'Mojolyst' => {controllers => 'MyApp::Controller', errors => 'die'};
  };
  like $@, qr/Loading "[^"]+" failed: /, "couldn't load it"
};

subtest "callback" => sub {
  my @errors;
  eval {
    plugin 'Mojolyst' => {controllers => 'MyApp::Controller', errors => sub { push @errors, shift}};
  };
  is($@,undef);
  is_deeply(\@warnings, [], "BadModule produced a warning");
};

done_testing();
