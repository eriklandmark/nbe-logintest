require 'sinatra'
require 'digest'
require 'vine'
require_relative  'functions'

get '/' do
  erb :index
end

post '/login' do
  if checkDatabase(user: params["user"], pass: params["password"])
    p "Logged in user: " + params["user"].to_s
    params["password"] = "haha"
    erb :login_page
  else
    erb :fail
  end
end

get '/logout' do
  params["user"] = ""
  params["password"] = ""
  erb :index
end

get '/post' do
  erb :info
end

post '/upload' do
  p params["fileInput"][:type]
  temp_file = params.access("fileInput.tempfile")
  puts temp_file
  tf = temp_file.to_s
  p tf

  erb :login_page
end