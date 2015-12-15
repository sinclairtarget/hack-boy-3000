$(document).ready ->
  $("#start-btn").click ->
    words = []
    for input in $(".password-entry")
      words.push $(input).val()

    possible_words = ["hello", "mello", "shell"]
    past_picks = []
    [pick, is_certain] = WordPicker.pick_word possible_words, past_picks
    console.log pick
    console.log is_certain
    WordPicker.set_likeness pick, 1, possible_words, past_picks
    console.log possible_words
