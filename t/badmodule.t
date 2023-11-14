use Mojo::Base -strict;

use Test::More;
use Mojolicious::Lite;
use Test::Mojo;

use File::Basename qw( dirname );
use lib join '/', dirname($0), 'lib';

my $CANT_LOCATE_NEW = qr/^Can't locate object method "new" via package/;
my $LOADING_FAIL = qr/^Loading "MyApp::Controller::BadModule" failed:/;
my $NEVER_AGAIN  = qr/^Attempt to reload .*[.]pm aborted[.]/;

subtest "default" => sub {
  local %INC = %INC; delete $INC{"MyApp/Controller/BadModule.pm"};
  eval {
    plugin 'Mojolyst' => {controllers => 'MyApp::Controller'} 
  };
  like $@, $CANT_LOCATE_NEW, "existing behaviour";
};

subtest "dies" => sub {
  local %INC = %INC; delete $INC{"MyApp/Controller/BadModule.pm"};
  my @warnings; $SIG{__WARN__} = sub { push @warnings, shift };
  plugin 'Mojolyst' => {controllers => 'MyApp::Controller', errors => 'warn'};
  is($@,'');
  is(0+@warnings, 1, "want a single warning") or diag explain \@warnings;
  like($warnings[0], $LOADING_FAIL, "BadModule produced desired warning: " . $warnings[0]) or diag explain \@warnings;
};

subtest "dies" => sub {
  local %INC = %INC; delete $INC{"MyApp/Controller/BadModule.pm"};
  eval {
    plugin 'Mojolyst' => {controllers => 'MyApp::Controller', errors => 'die'};
  };
  like $@, $LOADING_FAIL, "couldn't load it"
};

subtest "callback" => sub {
  local %INC = %INC; delete $INC{"MyApp/Controller/BadModule.pm"};
  my @exceptions;
  eval {
    plugin 'Mojolyst' => {
      controllers => 'MyApp::Controller', 
      errors => sub { push @exceptions, shift },
    }
  };
  is($@,'');
  is(0+@exceptions, 1, "want a single call");
  like($exceptions[0], $LOADING_FAIL, "BadModule produced desired callback: " . $exceptions[0]) or diag explain \@exceptions;
};

done_testing();
