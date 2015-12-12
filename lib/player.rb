require_relative 'word_picker'

module Player
  def self.play_game(words, password: nil)
    if password == nil
      play_human_game words
    else
      play_auto_game words, password
    end
  end

  private
  def self.play_human_game(words)
    picker = WordPicker.new(words)

    begin
      puts "Potential passwords: #{picker}"
      pick, done, is_certain = picker.pick_word
      if is_certain
        puts "The password is '#{pick}'."
      else
        puts "Try '#{pick}'."
        puts "What was the likeness?"
        likeness = $stdin.gets.chomp.to_i
        picker.set_likeness pick, likeness
      end
    end while not done
  end
  
  def self.play_auto_game(words, password)
    puts "Playing auto game with words:\n#{words}\npassword:\n#{password}"
  end
end
