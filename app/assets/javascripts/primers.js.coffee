# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ -> 
  $("#primer_direction").on "change", () -> 
    $.get "/primers/mate_primer_selection", {direction: $("#primer_direction").val()}, (responseText,status,jqXHR) ->
      selection = $(responseText).find("select")[0]
      $("#primer_mate_primer_ids").replaceWith(selection)
