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


p checkDatabase(user: "rikard", pass: "word")