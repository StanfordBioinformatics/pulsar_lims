# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$ ->  

  if $("#hide_new_library_result").length == 1 
    $("#new_library_result").attr("disabled", "disabled")

  $("#new_library_result").click (event) -> 
    if ($("#new_library_result").attr("disabled") == "disabled")
      event.preventDefault()
    else
      $(@).hide()


  $("#new_library_result").on "ajax:success", (event,data) ->  
    $("#library_results").after(data)
    #this appends a form with id new_library_result_form.
    $("#new_library_result_form").hide().fadeIn("fast")
    $("#rm_new_library_result_form").click (event) -> 
      event.preventDefault()
      $("#new_library_result_form").slideUp("fast")
      $("#new_library_result").show()
