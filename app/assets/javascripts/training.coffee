# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#

$(document).ready ->
  $("#hide").click  ->
    $("#all_actions_div").hide()
    $("#hide").hide()
    $("#show").show()

  $("#show").click  ->
    $("#all_actions_div").show()
    $("#show").hide()
    $("#hide").show()
