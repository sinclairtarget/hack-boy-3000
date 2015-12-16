possible_words = []
past_picks = []
last_pick = null

$(document).ready ->
  $("#start-btn").click ->
    for input in $(".password-entry")
      word = $(input).val()
      possible_words.push word if word.length > 0

    console.log possible_words
    $("#password-entry").addClass("hidden")
    $("#main-dialogue").removeClass("hidden")

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


make_pick = () ->
  [pick, is_certain] = WordPicker.pick_word possible_words, past_picks
  last_pick = pick

  if is_certain
    $("#main-dialogue").addClass("hidden")
    $("#end-dialogue").removeClass("hidden")

  $(".word-pick").text(pick)


restart = () ->
  possible_words = []
  past_picks = []

  $("#password-entry").removeClass("hidden")
  $("#main-dialogue").addClass("hidden")
  $("#end-dialogue").addClass("hidden")

  for input in $(".password-entry")
    $(input).val("")


format_str_array = (str_array) ->
  ret_str = ""
  for str, i in str_array
    ret_str += str
    if i < str_array.length - 1
      ret_str += ", "

  ret_str

