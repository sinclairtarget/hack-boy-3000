require_relative 'lib/player'

if ARGV.length != 1 and ARGV.length != 2
  $stderr.puts "usage: test_master_hack [OPTIONS...] <games_file>"
  exit(1)
end

verbose = false
if ARGV[0] == "-v"
  verbose = true
  ARGV.shift
end

attempt_counts = []
words = []
password = nil
File.foreach(ARGV[0]) do |line| 
  next if line.to_s.chomp == ""

  if line.include? "-"
    if password == nil
      fail("no password given for test number #{attempt_counts.length}")
    end

    test_num = attempt_counts.length
    puts "Beginning test #{test_num}." if verbose
    attempts = Player.play_game(words, password: password, verbose: verbose)
    puts "Finished test #{test_num} in #{attempts} attempts.\n\n" if verbose

    attempt_counts << attempts
    words = []
    password = nil
  elsif line[0] == "*"
    password = line.chomp
    password = password[1..password.length].strip
  else
    words << line.chomp
  end
end

def median(array)
  sorted = array.sort
  len = sorted.length
  (sorted[(len - 1) / 2] + sorted[len / 2]) / 2.0
end

def average(array)
  array.inject { |sum, e| sum + e }.to_f / array.length
end

puts "#{attempt_counts.length} tests completed."
puts "Median attempts to win: #{median(attempt_counts)}"
puts "Average attempts to win: #{median(attempt_counts)}"
puts "Max attempts to win: #{attempt_counts.max}"
