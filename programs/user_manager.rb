require 'tk'
require 'digest'

root = TkRoot.new do
  title "User Manager"
  minsize(300, 170)
  maxsize(300, 170)
end


TkLabel.new(root) do
  text 'Email:'
  place('height' => 25, 'x'=> 30, 'y' => 7)

end

TkLabel.new(root) do
  text 'Lösenord:'
  place('height' => 25, 'x'=> 30, 'y' => 57)
end

user = TkEntry.new(root) do
  place('height' => 25, 'width' => 240, 'x'=> 30, 'y' => 30)
end

password = TkEntry.new(root) do
  place('height' => 25, 'width' => 240, 'x'=> 30, 'y' => 80)
  show '*'
end

TkButton.new do
  text "Lägg till"
  command do
    if user.get != "" && password.get != ""
      ok_button(user: user, password: password)
      user.delete(0, user.get.length)
      password.delete(0, password.get.length)
    else
      p "Missing email or password!"
    end
  end
  place('height' => 30, 'width' => 80, 'x'=> 160, 'y' => 120)
end

TkButton.new do
  text "Radera"
  command do
    if user.get != ""
      delete_button(user: user)
      user.delete(0, user.get.length)
      password.delete(0, password.get.length)
    else
      p "Missing email!"
    end
  end
  place('height' => 30, 'width' => 80, 'x'=> 60, 'y' => 120)
end

def encode(msg:)
  return Digest::SHA256.hexdigest msg
end

def ok_button(user:, password:)
  hash = Hash.new
  email = user.get
  hash_pass = encode(msg: password.get)

  File.open("../database/database.txt", 'r') do |file|
    lines = []
    file.readlines.each do |line|
      lines << line.chomp
    end

    lines.each do |line|
      hash[line[0, line.index(':')]] = line[line.index(':') + 1, line.length]
    end
  end

  if hash.has_key?(email)
    p "User alreaddy exists! Changing password of User: " + email.to_s
    hash[email] = hash_pass

    File.open("../database/database.txt", 'w') do |file|
      hash.each do |key, value|
        s = key.to_s + ":" + value.to_s
        file.write(s + "\n")
      end
    end
  else
    p "Adding User: " + email.to_s + " to the database!"
    File.open("../database/database.txt", 'a') do |file|
      file.write(email + ":" + hash_pass + "\n")
    end
  end
end

def delete_button(user:)
  hash = Hash.new
  email = user.get

  File.open("../database/database.txt", 'r') do |file|
    lines = []
    file.readlines.each do |line|
      lines << line.chomp
    end

    lines.each do |line|
      hash[line[0, line.index(':')]] = line[line.index(':') + 1, line.length]
    end
  end

  if hash.has_key?(email)
    hash.delete(email)

    File.open("../database/database.txt", 'w') do |file|
      hash.each do |key, value|
        s = key.to_s + ":" + value.to_s
        file.write(s + "\n")
      end
    end
    p "Deleted User: " + email
  else
    p "User doesn't exist!"
  end
end

Tk.mainloop