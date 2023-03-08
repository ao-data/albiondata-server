require File.expand_path('albion_server', __dir__)

use Rack::Session::Cookie, secret: ENV['RACK_SESSION_SECRET'], same_site: true, max_age: 86400
run Rack::URLMap.new('/' => AlbionServer, '/sidekiq' => Sidekiq::Web)
