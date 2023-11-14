use Mojo::Base -strict;

use Test::More;
use Mojolicious::Lite;
use Test::Mojo;

use File::Basename qw( dirname );
use lib join '/', dirname($0), 'lib';

my $CANT_LOCATE_NEW = qr/^Can't locate object method "new" via package/;
my $LOADING_FAIL = qr/^Loading "MyApp::Controller::BadModule" failed:/;

subtest "default" => sub {
  eval {
    plugin 'Mojolyst' => {controllers => 'MyApp::Controller'} 
  };
  like $@, $CANT_LOCATE_NEW, "existing behaviour";
};

subtest "dies" => sub {
  my @warnings; $SIG{__WARN__} = sub { push @warnings, shift };
  plugin 'Mojolyst' => {controllers => 'MyApp::Controller', errors => 'warn'};
  is($@,undef);
  is(0+@warnings, 1, "want a single warning");
  like($warnings[0], $LOADING_FAIL, "BadModule produced desired warning: " . $warnings[0]);
};

subtest "dies" => sub {
  eval {
    plugin 'Mojolyst' => {controllers => 'MyApp::Controller', errors => 'die'};
  };
  like $@, $LOADING_FAIL, "couldn't load it"
};

subtest "callback" => sub {
  my @exceptions;
  eval {
    plugin 'Mojolyst' => {
      controllers => 'MyApp::Controller', 
      errors => sub { push @exceptions, shift },
    }
  };
  is($@,undef);
  is(0+@exceptions, 1, "want a single warning");
  like($exceptions[0], $LOADING_FAIL, "BadModule produced desired warning: " . $exceptions[0]);
};

done_testing();
