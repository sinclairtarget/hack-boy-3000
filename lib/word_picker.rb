class WordPicker
  def initialize(words, attempts: 4)
    @possible_words = words
    @choices = []
    @attempts_left = 4
    @last_pick = ""
  end

  def pick_word
    return @last_pick, true, true if @possible_words.length == 0

    @attempts_left -= 1

    @last_pick = pick = @possible_words.delete(@possible_words.first)
    is_last_pick = (@attempts_left == 0)
    is_certain = (@possible_words.length == 0)
    return pick, is_last_pick, is_certain
  end

  def set_likeness(word, likeness)
    @choices << { word: word, likeness: likeness }
    cull_possible_words
  end

  def to_s
    @possible_words.inspect 
  end

  private
  def cull_possible_words
    @possible_words.delete_if do |word|
      @choices.any? do |choice|
        likeness(word, choice[:word]) != choice[:likeness]
      end
    end
  end

  def likeness(w1, w2)
    likeness = 0

    w1.chars.each_with_index do |c, index|
      likeness += 1 if c == w2[index]
    end

    likeness
  end
  # Looking to exclude words until there is only one
  # word - likeness hash
  # constraint satisfaction problem
  # when you get back a likeness value, what does it tell you?
  # the number of correctly filled blanks
  # Wp contains L letters from Wg at their positions
  # (|Wg| choose L) possiblities
  #
  # Wp = Warm
  # Wg = Wood, Gosh, Ball, Wrap, Warn
  #       1     0     1     1     3
  # Wg = Gnat
end
