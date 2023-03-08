require 'active_support/all'
require 'date'
require 'time'
require 'sinatra'
require 'sidekiq'
require 'sidekiq/web'

require File.expand_path('config', __dir__)
require File.expand_path('app/services/market_history', __dir__)
require File.expand_path('app/workers/market_history_worker', __dir__)

class AlbionServer < Sinatra::Base
  configure do
    set :sessions, false
    set :logging, true
    set :show_exceptions, true
    set :run, false
    set bind: "0.0.0.0"
    set port: 3000
    set server: "puma"
  end

  def initialize
    super
    # @redis = Redis.new(url: "redis://#{ENV['REDIS_HOST']}:#{ENV['REDIS_PORT']}/#{ENV['REDIS_DB']}")
  end

  get '/health' do
    return "OK"
  end
end
