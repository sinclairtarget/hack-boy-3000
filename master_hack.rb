require_relative 'lib/player'

words = []

begin
  puts "Enter a potential password: [EOF to finish]"
  next_word = gets.to_s.chomp
  received_valid_input = next_word != ''
  words << next_word.chomp if received_valid_input
end while received_valid_input

fail("no words given") if words.length == 0

Player.play_game words
