require 'sinatra'
require 'sinatra/base'
require 'digest'
require 'vine'
require 'data_mapper'
require 'dm-migrations'
require 'sqlite3'

#DataMapper::Logger.new($stdout, :debug)
DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/database/users.db")
DataMapper::Property::String.length(100)

enable :sessions

class User
  include DataMapper::Resource

  property :id, Serial
  property :email, String
  property :password, String
  property :clearence_level, Integer
end

DataMapper.finalize.auto_upgrade!

get '/' do
  erb :index
end

get '/login' do
  erb :index
end

post '/login' do
  if checkDatabase(user: params["user"], pass: params["password"])
    p "Logged in user: " + params["user"]
    session[:user] = params["user"]
    params["user"] = ""
    params["password"] = ""
    erb :login_page2
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

get '/download/:filename' do |filename|

  path = "/database/files/private/"+ session[:user] + "/" + filename
  if File.exists?(path)
    send_file path, :filename => filename, :type => 'Application/octet-stream'
  end
end

post '/upload-public' do
  p "Uploading file to public db..."
  File.open("database/files/public/" + params["fileInput"][:filename], "w") do |f|
    f.write(params["fileInput"][:tempfile].read)
  end
  erb :login_page2
end

post '/upload-private' do
  p "Uploading file to private db..."
  if !Dir.exists?("/database/files/private/" + session[:user])
    Dir.mkdir("database/files/private/"+ session[:user])
  end
  File.open("/database/files/private/"+ session[:user] + "/" + params["fileInput"][:filename], "w") do |f|
    f.write(params["fileInput"][:tempfile].read)
  end
  erb :login_page2
end

def checkDatabase(user:, pass:)
  u = UserDB.first(:email => user)
  if u != nil
    if u.password == encode(msg: pass)
      return true;
    else
      p "Wrong password"
      return false
    end
  else
    p "User doesn't exist"
    return false
  end
end

def encode(msg:)
  return Digest::SHA256.hexdigest  msg
end