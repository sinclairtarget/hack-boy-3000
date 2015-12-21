possible_words = []
past_picks = []
last_pick = null

$(document).ready ->
  $("button").click ->
    $(this).blur()

  $("#add-btn").click ->
    add_possible_word()

  $("#start-btn").click ->
    $("#password-entry-container").addClass("hidden")
    $("#likeness-dialogue-container").removeClass("hidden")

    $("#possible-words").text(format_str_array(possible_words))
    make_pick()

  $("#likeness-btn-prototype").click ->
    $btn = $(this)
    likeness = $btn.data("likeness")
    WordPicker.set_likeness last_pick, likeness, possible_words, past_picks 
    $("#possible-words").text(format_str_array(possible_words))
    make_pick()

  $("#restart-btn").click ->
    restart()

  $("#password-entry").keydown (e) ->
    if e.keyCode == 13
      add_possible_word()


add_possible_word = () ->
  $pass_entry = $("#password-entry")
  word = $pass_entry.val().toUpperCase()
  if word.length == 0 or not is_correct_length(word) or word in possible_words
    return

  $pass_entry.val("")
  possible_words.push word
  $("#possible-words").text(format_str_array(possible_words))
  $pass_entry.focus()

  if possible_words.length == 1
    $("#start-btn").removeClass("hidden")
    $("#restart-btn-container").removeClass("hidden")


is_correct_length = (word) ->
  if possible_words.length > 0
    word.length == possible_words[0].length
  else
    true


make_pick = () ->
  [pick, is_certain, likenesses] = WordPicker.pick_word possible_words, past_picks
  last_pick = pick

  if is_certain
    $("#likeness-dialogue-container").addClass("hidden")
    $("#end-dialogue-container").removeClass("hidden")

  $(".word-pick").text(pick.toUpperCase())

  if likenesses.length > 0
    likenesses.push pick.length # for if the word is the correct word
    likenesses.sort()
    clear_likeness_buttons()
    add_likeness_buttons(likenesses)


restart = () ->
  possible_words = []
  past_picks = []

  $("#password-entry-container").removeClass("hidden")
  $("#likeness-dialogue-container").addClass("hidden")
  $("#end-dialogue-container").addClass("hidden")
  $("#restart-btn-container").addClass("hidden")
  $("#start-btn").addClass("hidden")
  $("#password-entry").val("")
  $("#possible-words").text("-")


clear_likeness_buttons = () ->
  $("#likeness-btns").empty()


add_likeness_buttons = (likenesses) ->
  $buttons = $("#likeness-btns")
  for likeness in likenesses
    $new_button = $("#likeness-btn-prototype").clone(true)
    $new_button.text(likeness)
    $new_button.data("likeness", likeness)
    $new_button.removeClass("hidden")
    $buttons.append($new_button)


format_str_array = (str_array) ->
  ret_str = ""
  for str, i in str_array
    ret_str += str
    if i < str_array.length - 1
      ret_str += ", "

  ret_str

