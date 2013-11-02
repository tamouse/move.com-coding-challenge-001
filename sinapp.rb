require 'sinatra'
require 'sinatra/json'
enable :sessions
set :haml, :format => :html5

get '/' do
  haml :index
end

get '/javascript/photoapp.js' do
  STDERR.puts "in /javascript/photoapp.js"
  coffee :photoapp
end
