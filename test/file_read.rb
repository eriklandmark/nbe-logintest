def checkDatabase(user:, pass:)
  hash = Hash.new
  path = Dir.getwd
  File.open(path + "/encode.rb", 'r') do |file|
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

def ls()
  p Dir.getwd
  p Dir.glob("*")
end


p checkDatabase(user: "rikard.sjostedt@itggot.se", pass: "word")