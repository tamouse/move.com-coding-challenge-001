require 'sinatra'
require 'sinatra/json'
require 'json'

enable :sessions
set :haml, :format => :html5

get '/' do
  haml :index
end

get '/javascript/photoapp.js' do
  STDERR.puts "in /javascript/photoapp.js"
  coffee :photoapp
end

get '/api/property/:id' do
  STDERR.puts "in /api/property/#{params[:id]}"
  data = JSON.parse(File.read("data/listing_photos.json"))
  json data
end
