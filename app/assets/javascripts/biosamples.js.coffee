# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->

  load_biosampel_term_name_selection = -> 
    $.get "/biosamples/select_biosample_term_name", $("#biosample_biosample_type_id").serialize(), (responseText,status,jqXHR) ->
      $("#biosample_biosample_term_name_id").closest("div").replaceWith responseText

  if not ($("#biosample_biosample_type_id").val())
    $("#biosample_biosample_term_name_id").attr("disabled","disabled")
  else
    load_biosampel_term_name_selection()
		#set when page loads to, because if the _form.html.erb refreshed with a validation error, the 
		# biosample_type_id may already have been set, but not change event will fire.

  $("#biosample_biosample_type_id").change (event) -> 
    load_biosampel_term_name_selection()
