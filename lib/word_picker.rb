class WordPicker
  def initialize(words)
    @possible_words = words
    @choices = []
    @last_pick = ""
  end

  def pick_word
    return @last_pick, true if @possible_words.length == 0

    @last_pick = pick = @possible_words.delete(@possible_words.first)
    is_certain = (@possible_words.length == 0)
    return pick, is_certain
  end

  def set_likeness(word, likeness)
    @choices << { word: word, likeness: likeness }
    cull_possible_words
  end

  def to_s
    @possible_words.inspect 
  end

  def self.likeness(w1, w2)
    likeness = 0

    w1.chars.each_with_index do |c, index|
      likeness += 1 if c == w2[index]
    end

    likeness
  end

  private
  def cull_possible_words
    @possible_words.delete_if do |word|
      @choices.any? do |choice|
        WordPicker.likeness(word, choice[:word]) != choice[:likeness]
      end
    end
  end
end
