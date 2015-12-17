window.WordPicker or= {}


WordPicker.pick_word = (possible_words, past_picks) ->
  if possible_words.length is 1
    return [possible_words[0], true, []]

  [pick, likenesses] = next_pick possible_words, past_picks
  [pick, false, likenesses]


WordPicker.set_likeness = (word, likeness, possible_words, past_picks) ->
  if likeness < word.length
    word_index = possible_words.indexOf word
    possible_words.splice word_index, 1

  past_picks.push { word: word, likeness: likeness }
  cull possible_words, past_picks


WordPicker.likeness = (w1, w2) ->
  likeness = 0

  for char, i in w1
    likeness += 1 if w1[i] == w2[i]

  likeness


next_pick = (possible_words, past_picks) ->
  max_score = -1
  pick = null
  likenesses = null
  for word in possible_words
    [word_score, word_likenesses] = score(word, possible_words)

    if word_score > max_score
      pick = word
      max_score = word_score
      likenesses = word_likenesses

  [pick, likenesses]


score = (word, possible_words) ->
  other_words_count = possible_words.length - 1
  return 0 if other_words_count is 0

  likeness_hash = {}
  for other_word in possible_words
    if other_word != word
      likeness = WordPicker.likeness(word, other_word)
      if likeness_hash[likeness]?
        likeness_hash[likeness] += 1
      else
        likeness_hash[likeness] = 1

  sum = 0
  likenesses = Object.keys(likeness_hash).map((e) -> parseInt(e))
  likenesses_count = likenesses.length
  for key, val of likeness_hash
    sum += other_words_count - val

  [sum / likenesses_count, likenesses]


cull = (possible_words, past_picks) ->
  for word, i in possible_words by -1
    for past_pick in past_picks
      if WordPicker.likeness(word, past_pick["word"]) != past_pick["likeness"]
        possible_words.splice(i, 1)
