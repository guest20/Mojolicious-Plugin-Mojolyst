package # paused
  MyApp::Controller::Example;
use Mojolicious::Lite;

get '/' => sub { 
  my ($c) = @_;
  $c->render(template => 'index');
};

1
__DATA__

@@ index.html.ep
%% layout 'default';
%% title 'Welcome';
<h1>Welcome to the Mojolicious real-time web framework!</h1>

@@ layouts/default.html.ep
<!DOCTYPE html>
<html>
  <head><title><%%= title %></title></head>
  <body><%%= content %></body>
</html>
