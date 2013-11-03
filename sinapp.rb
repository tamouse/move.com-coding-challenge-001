#!/usr/bin/env ruby
require 'rubygems'
require 'bundler/setup'

require 'sinatra'
require 'sinatra/json'
require 'json'
require 'haml'
require 'redcarpet'
require 'coffee_script'

enable :sessions
set :haml, :format => :html5
set :port, 9201

get '/' do
  haml :index, :locals => { :style => "vertical"}
end

get "/2" do
  haml :index2, :locals => { :style => ""}
end

get "/readme" do
  text = markdown(File.read("README.md"))
  haml :readme, :locals => { :text => text , :style => ""}
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
