# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$ ->  

  #The following code is for the show view.

  $new_bc_res_btn = $("#new_sequencing_result") #the button

  if $("#hide_new_sequencing_result").length == 1 
    $new_bc_res_btn.attr("disabled", "disabled")

  $new_bc_res_btn.click (event) -> 
    if ($new_bc_res_btn.attr("disabled") == "disabled")
      event.preventDefault()
    else
      $(@).hide()


  $new_bc_res_btn.on "ajax:success", (event,data) ->  
    $("#sequencing_result_form").append(data)
    #this appends a form with id new_sequencing_result_form after the div with ID sequencing_result_form.
    $("#new_sequencing_result_form").hide().fadeIn("fast")
    $library_input = $("#sequencing_result_library_id")
    $library_input.change (event) -> 
      get_path = window.location.pathname + "/sequencing_results/get_barcode_selector"
      $.get get_path, $library_input.serialize(), (responseText,status,jqXHR) ->
        $barcode_input = $("#sequencing_result_barcode_id")
        $barcode_input.html(responseText)
        $barcode_input.attr("disabled",false)

    $("#sequencing_result_barcode_id").change (event) -> 
      get_path = window.location.pathname + "/sequencing_results/get_library_selector"
      $.get get_path, $("#sequencing_result_barcode_id").serialize(), (responseText,status,jqXHR) ->
        alert(responseText)
        $library_input.html(responseText)
          
    $("#rm_new_sequencing_result_form").click (event) -> 
      event.preventDefault()
      $("#new_sequencing_result_form").slideUp "normal", ->  
        $("#new_sequencing_result_form").remove()
        $new_bc_res_btn.show()
