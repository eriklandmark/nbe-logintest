require 'sinatra'
require 'sinatra/base'
require 'digest'
require 'vine'
require_relative  'functions'


enable :sessions

get '/' do
  if session[:user] != ""
    erb :login_page
  else
    erb :index
  end
end

get '/login' do
  erb :index
end

post '/login' do
  user = params["user"].to_s

  if checkDatabase(user: user, pass: params["password"])
    p "Logged in user: " + user
    params["user"] = ""
    params["password"] = ""
    session[:user] = user
    erb :login_page
  else
    erb :fail
  end
end

get '/logout' do
  p "Logged out Uer: " + session[:user]
  session[:user] = ""
  erb :index
end

get '/post' do
  erb :info
end

post '/upload' do
  p "Uploading file..."
  if !Dir.exists?("database/files/private/"+session[:user])
    Dir.mkdir("database/files/private/"+ session[:user])
  end
  File.open("database/files/private/"+ session[:user] + "/" + params["fileInput"][:filename], "w") do |f|
    f.write(params["fileInput"][:tempfile].read)
  end
  redirect "/post"
end