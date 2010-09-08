require "rubygems"
require "bundler/setup"
Bundler.require(:default) if defined?(Bundler)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/lib/actions/*.rb'].each {|file| require file }

class Hubsucker < Sinatra::Base
  #get "/" do
  #  erb :index
  #end
  
  get "/" do
    #push = JSON.parse(params[:payload])
    push = JSON.parse(IO.read("spec/fixtures/payload.js"))
    
    dispatcher = PayloadDispatcher.new(push)
    @result = dispatcher.dispatch!.first
    
    #@result  = "I got some JSON: #{push.inspect}"
    #@result = "The branch is #{dispatcher.branch}"
    
    erb :index
  end
end