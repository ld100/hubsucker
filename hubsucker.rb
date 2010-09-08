require "rubygems"
require "bundler/setup"
Bundler.require(:default) if defined?(Bundler)

class Hubsucker < Sinatra::Base
  get "/" do
    erb :index
  end
end