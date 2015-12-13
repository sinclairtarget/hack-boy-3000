class WordPicker
  def initialize(words)
    @possible_words = words
    @choices = []
    @last_pick = ""
  end

  def pick_word
    return @last_pick, true if @possible_words.length == 0

    @last_pick = pick = next_pick()
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
  def next_pick
    max_score = -1
    pick = nil
    @possible_words.each do |word|
      word_score = score(word)
      
      if word_score > max_score
        pick = word
        max_score = word_score
      end
    end

    @possible_words.delete pick
  end

  def score(word)
    other_words_count = @possible_words.length - 1
    return 0 if other_words_count == 0

    likeness_hash = Hash.new(0)
    @possible_words.each do |other_word|
      next if other_word == word

      likeness = WordPicker.likeness(word, other_word)
      likeness_hash[likeness] += 1
    end

    likenesses_count = likeness_hash.values.length
    (likeness_hash.values.inject(0) do |sum, el|
      sum + (other_words_count - el)
    end).to_f / likenesses_count
  end

  def cull_possible_words
    @possible_words.delete_if do |word|
      @choices.any? do |choice|
        WordPicker.likeness(word, choice[:word]) != choice[:likeness]
      end
    end
  end
end
