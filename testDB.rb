require 'rubygems'
require 'data_mapper'
require 'dm-migrations'
require 'sqlite3'
require 'digest'

DataMapper::Logger.new($stdout, :debug)

DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/database/users.db")

DataMapper::Property::String.length(100)

class UserDB
  include DataMapper::Resource

  property :id, Serial
  property :email, String
  property :password, String
end

DataMapper.finalize.auto_upgrade!

def encode(msg:)
	return Digest::SHA256.hexdigest  msg
end

def createUser(user:, pass:)
	u = {
		:email => user,
		:password => encode(msg: pass)
	}
	
	alreadyUser = UserDB.all(:email => user)
	
	if !alreadyUser.empty?
		p "User already exists!"
	else
		testDB = UserDB.create(u)
		if testDB.save
			p "Created user: " + user
		end
	end
end

def deleteUser(user:, pass:)
	u = UserDB.first(:email => user)
	if u != nil
		if u.password == encode(msg: pass)
			u.destroy
			p "Deleted User: " + user
		end
	else
		p "User doesn't exist"
	end
end

def changePass(user:, pass:)
	u = UserDB.all(:email => user)
	if !u.empty?
		p = encode(msg: pass)
		u.update(:password => p)
		if u.save
			p "Updated passowrd for User: " + user
		else
			p "Couldn't save"
		end
	else
		p "User doesn't exist"
	end
end


if ARGV[0] ==  "create"
	ARGV.clear
	print "Email: "
	u = gets.chomp
	print "Password: "
	p = gets.chomp
	createUser(user: u, pass: p)
elsif ARGV[0] == "list"
	UserDB.all().each do |user|
    p user
  end
elsif ARGV[0] == "delete"
	ARGV.clear
	print "Email: "
	u = gets.chomp
	print "Password: "
	p = gets.chomp
	deleteUser(user: u, pass: p)
elsif ARGV[0] == "password"
	ARGV.clear
	print "Email: "
	u = gets.chomp
	print "New Password: "
	p = gets.chomp
	changePass(user: u, pass: p)
elsif ARGV[0] == "getpassword"
	ARGV.clear
	print "Email: "
	u = gets.chomp
	user = UserDB.first(:email => u)
	if user != nil
    p user.password
  else
    p "User doens't exist!"
  end
end





