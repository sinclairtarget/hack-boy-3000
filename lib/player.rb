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
      pick, done = picker.pick_word
      if done
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
    picker = WordPicker.new(words)


  end
end
