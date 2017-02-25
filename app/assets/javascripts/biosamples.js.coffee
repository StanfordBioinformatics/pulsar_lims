# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $("#biosample_biosample_type_id").change (event) -> 
    $.get "/biosamples/select_biosample_term_name", $("#biosample_biosample_type_id").serialize(), (responseText,status,jqXHR) ->
      $("#biosample_biosample_term_name_id").closest("div").replaceWith responseText
