require_relative 'lib/word_picker'

words = []
system("clear")

begin
  puts "Enter a potential password: [EOF to finish]"
  next_word = gets.to_s.chomp
  received_valid_input = next_word != ''
  words << next_word.chomp if received_valid_input
end while received_valid_input

exit(0) if words.length == 0

picker = WordPicker.new(words)

begin
  system("clear")
  puts "Potential passwords: #{picker}"
  pick, done, is_certain = picker.pick_word
  if is_certain
    puts "The password is '#{pick}'."
  else
    puts "Try '#{pick}'."
    puts "What was the likeness?"
    likeness = gets.chomp.to_i
    picker.set_likeness pick, likeness
  end
end while not done
