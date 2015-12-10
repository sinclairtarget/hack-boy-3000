words = []

begin
  puts "Enter the next available word: [EOF to finish]"
  next_word = gets.to_s.chomp
  received_valid_input = next_word != ''
  words << next_word.chomp if received_valid_input
end while received_valid_input

exit(0) if words.length == 0

puts words.inspect
