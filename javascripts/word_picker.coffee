window.WordPicker or= {}


WordPicker.pick_word = (possible_words, past_picks) ->
  pick = next_pick possible_words, past_picks
  is_certain = possible_words.length is 0
  [pick, is_certain]


WordPicker.set_likeness = (word, likeness, possible_words, past_picks) ->
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
  for word in possible_words
    word_score = score(word, possible_words)
    console.log "assigning " + word_score + " to " + word

    if word_score > max_score
      pick = word
      max_score = word_score

  word_index = possible_words.indexOf pick
  possible_words.splice word_index, 1
  pick


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
  likenesses_count = Object.keys(likeness_hash).length
  for key, val of likeness_hash
    sum += other_words_count - val

  console.log likeness_hash
  console.log "Likenesses count: " + likenesses_count
  sum / likenesses_count


cull = (possible_words, past_picks) ->
  indices_to_delete = []
  for word, i in possible_words
    for past_pick in past_picks
      if WordPicker.likeness(word, past_pick["word"]) != past_pick["likeness"]
        indices_to_delete.push i

  for index in indices_to_delete
    possible_words.splice index, 1
