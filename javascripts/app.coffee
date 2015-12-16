possible_words = []
past_picks = []
last_pick = null

$(document).ready ->
  $("button").click ->
    $(this).blur()

  $("#add-btn").click ->
    add_possible_word()

  $("#start-btn").click ->
    console.log possible_words
    $("#password-entry-container").addClass("hidden")
    $("#likeness-dialogue-container").removeClass("hidden")

    $("#possible-words").text(format_str_array(possible_words))
    make_pick()

  $("#continue-btn").click ->
    $likeness_input = $("#likeness-entry")
    likeness = parseInt($likeness_input.val(), 10)
    WordPicker.set_likeness last_pick, likeness, possible_words, past_picks 
    $("#possible-words").text(format_str_array(possible_words))
    make_pick()
    $likeness_input.val("")

  $("#restart-btn").click ->
    restart()

  $("#password-entry").keydown (e) ->
    console.log "key down!"
    if e.keyCode == 13
      add_possible_word()


add_possible_word = () ->
  $pass_entry = $("#password-entry")
  word = $pass_entry.val()
  if word.length == 0 or not is_correct_length(word)
    return

  $pass_entry.val("")
  possible_words.push word
  $("#possible-words").text(format_str_array(possible_words))
  $pass_entry.focus()

  if possible_words.length == 1
    $("#start-btn").removeClass("hidden")


is_correct_length = (word) ->
  if possible_words.length > 0
    word.length == possible_words[0].length
  else
    true


make_pick = () ->
  [pick, is_certain] = WordPicker.pick_word possible_words, past_picks
  last_pick = pick

  if is_certain
    $("#likeness-dialogue-container").addClass("hidden")
    $("#end-dialogue").removeClass("hidden")

  $(".word-pick").text(pick.toUpperCase())


restart = () ->
  possible_words = []
  past_picks = []

  $("#password-entry-container").removeClass("hidden")
  $("#likeness-dialogue-container").addClass("hidden")
  $("#end-dialogue").addClass("hidden")
  $("#start-btn").addClass("hidden")
  $("#password-entry").val("")
  $("#possible-words").text("-")


format_str_array = (str_array) ->
  ret_str = ""
  for str, i in str_array
    ret_str += str.toUpperCase()
    if i < str_array.length - 1
      ret_str += ", "

  ret_str

