# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->

  load_biosampel_term_name_selection = -> 
    $.get "/biosamples/select_biosample_term_name", $("#biosample_biosample_type_id").serialize(), (responseText,status,jqXHR) ->
      $(".biosample_term_name").html(responseText)

  if $("#biosample_biosample_type_id").val()
    load_biosampel_term_name_selection()
    #set when page loads to, because if the _form.html.erb refreshed with a validation error, the 
    # biosample_type_id may already have been set, but no change event will fire.

  #use event delegation (see jQuery in Action 3rd ed., p. 154 on "event delegation").
  $(document).change "#biosample_biosample_type_id", (event) -> 
    load_biosampel_term_name_selection()
