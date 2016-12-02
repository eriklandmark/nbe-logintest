require 'sinatra'

get '/' do
  erb :index
end

get '/omg' do
  erb :view
end
