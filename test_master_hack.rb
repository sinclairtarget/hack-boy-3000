require_relative 'lib/player'

if ARGV.length != 1
  $stderr.puts "usage: test_master_hack <games_file>"
  exit(1)
end

test_number = 0
words = []
password = nil
File.foreach(ARGV[0]) do |line| 
  next if line.to_s.chomp == ""

  if line.include? "-"
    if password == nil
      fail("no password given for test number #{test_number}")
    end

    Player.play_game words, password: password
    words = []
    password = nil
    test_number += 1
  elsif line[0] == "*"
    password = line.chomp
    password = password[1..password.length].strip
  else
    words << line.chomp
  end
end
