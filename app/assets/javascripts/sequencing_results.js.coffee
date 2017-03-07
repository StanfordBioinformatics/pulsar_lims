# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$ ->  

  if $("#hide_new_barcode_result").length == 1 
    $("#new_barcode_result").attr("disabled", "disabled")

  $("#new_barcode_result").click (event) -> 
    if ($("#new_barcode_result").attr("disabled") == "disabled")
      event.preventDefault()
    else
      $(@).hide()


  $("#new_barcode_result").on "ajax:success", (event,data) ->  
    $("#barcode_results").after(data)
    #this appends a form with id new_barcode_result_form.
    $("#new_barcode_result_form").hide().fadeIn("fast")
    $("#rm_new_barcode_result_form").click (event) -> 
      event.preventDefault()
      $("#new_barcode_result_form").slideUp("fast")
      $("#new_barcode_result").show()
