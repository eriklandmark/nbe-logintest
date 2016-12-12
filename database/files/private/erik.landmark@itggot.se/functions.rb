def checkDatabase(user:, pass:)
  hash = Hash.new
  hashPass = encode(msg: pass)

  if File.exists?("database/database.txt")
    File.open("database/database.txt", 'r') do |file|
      lines = []
      file.readlines().each do |line|
        lines << line.chomp
      end

      lines.each do |line|
        hash[line[0, line.index(':')]] = line[line.index(':') + 1, line.length]
      end
    end
  else
    p "Couldn't find database file!"
    return false
  end

  if hash.has_key?(user) && hash[user] == hashPass
    return true
  else
    return false
  end
end

def encode(msg:)
  return Digest::SHA256.hexdigest  msg
end