require_relative 'word_picker'

module Player
  def self.play_game(words, password: nil, verbose: false)
    if password == nil
      play_human_game words, verbose
    else
      play_auto_game words, password, verbose
    end
  end

  private
  def self.play_human_game(words, verbose)
    attempt_count = 0
    picker = WordPicker.new(words)

    begin
      puts "Potential passwords: #{picker}" if verbose
      pick, done = picker.pick_word
      if done
        puts "The password is '#{pick}'."
      else
        puts "Try '#{pick}'."
        puts "What was the likeness?"
        likeness = $stdin.gets.chomp.to_i
        picker.set_likeness pick, likeness
        attempt_count += 1
      end
    end while not done

    attempt_count
  end
  
  def self.play_auto_game(words, password, verbose)
    attempt_count = 0
    picker = WordPicker.new(words)

    begin
      puts "Potential passwords: #{picker}" if verbose
      pick, done = picker.pick_word
      
      if done
        puts "The password is '#{pick}'." if verbose
      else
        puts "Try '#{pick}'." if verbose
        likeness = WordPicker.likeness pick, password
        picker.set_likeness pick, likeness
        attempt_count += 1
      end
    end while not done

    attempt_count
  end
end
