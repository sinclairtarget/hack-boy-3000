require_relative 'lib/player'

verbose = false
if ARGV.length >= 1 and ARGV[0] == "-v"
  verbose = true
  ARGV.shift
end

words = []

begin
  puts "Enter a potential password: [EOF to finish]"
  next_word = $stdin.gets.to_s.chomp
  received_valid_input = (next_word != '')
  words << next_word.chomp if received_valid_input
end while received_valid_input

fail("no words given") if words.length == 0

Player.play_game words, verbose: verbose
