possible_words = []
past_picks = []
last_pick = null

$(document).ready ->
  $("#start-btn").click ->
    possible_words = []
    past_picks = []

    for input in $(".password-entry")
      word = $(input).val()
      possible_words.push word if word.length > 0

    console.log possible_words
    $("#password-entry").addClass("hidden")
    $("#main-dialogue").removeClass("hidden")

    make_pick()

  $("#continue-btn").click ->
    likeness = parseInt($("#likeness_entry").val(), 10)
    WordPicker.set_likeness last_pick, likeness, possible_words, past_picks 
    make_pick()

make_pick = () ->
  [pick, is_certain] = WordPicker.pick_word possible_words, past_picks
  last_pick = pick

  if is_certain
    $("#main-dialogue").addClass("hidden")
    $("#end-dialogue").removeClass("hidden")

  $(".word-pick").text(pick)
