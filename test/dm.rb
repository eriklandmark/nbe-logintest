def dm(n:)
  list = [n]
  continue = true
  i = n
  while continue do
    i == 1 ? break :
    if (i % 2) == 0
      list << i / 2
      i = i / 2
    else
      list << i * 3 + 1
      i = i * 3 + 1
    end
  end
  return list
end
p dm(n: gets.chomp.to_i)