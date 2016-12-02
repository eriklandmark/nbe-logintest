require 'sinatra'

def checkDatabase(user:, pass:)
  hash = Hash.new

  File.open("database/info.txt", 'r') do |file|
    lines = []
    file.readlines().each do |line|
      lines << line.chomp
    end

    p lines

    lines.each do |line|
      hash[line[0, line.index(':')]] = line[line.index(':') + 1, line.length]
    end
  end

  p hash

  if hash.has_key?(user) && hash[user] == pass
    return true
  else
    return false
  end
end

get '/' do
  erb :index
end

post '/login' do
    if checkDatabase(user: params["user"], pass: params["password"])
        params["password"] = "haha"
        erb :login_page
    else
        erb :fail
    end
end