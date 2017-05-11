# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$ ->  

  #The following code is for the show view.

  $new_bc_res_btn = $("#new_barcode_result")

  if $("#hide_new_barcode_result").length == 1 
    $new_bc_res_btn.attr("disabled", "disabled")

  $new_bc_res_btn.click (event) -> 
    if ($new_bc_res_btn.attr("disabled") == "disabled")
      event.preventDefault()
    else
      $(@).hide()


  $new_bc_res_btn.on "ajax:success", (event,data) ->  
    $("#barcode_result_form").append(data)
    #this appends a form with id new_barcode_result_form after the div with ID barcode_result_form.
    $("#new_barcode_result_form").hide().fadeIn("fast")
    $library_input = $("#barcode_sequencing_result_library_id")
    $library_input.change (event) -> 
      get_path = window.location.pathname + "/barcode_sequencing_results/get_barcode_selector"
      $.get get_path, $library_input.serialize(), (responseText,status,jqXHR) ->
        $barcode_input = $("#barcode_sequencing_result_barcode_id")
        $paired_barcode_input = $("#barcode_sequencing_result_paired_barcode_id")
        if ($barcode_input.length == 1)
          $barcode_input.html("<option>yep</option>")
          $barcode_input.html(responseText)
          $barcode_input.attr("disabled",false)
        else
          $paired_barcode_input.html(responseText)
          $paired_barcode_input.attr("disabled",false)
          
    $("#rm_new_barcode_result_form").click (event) -> 
      event.preventDefault()
      $("#new_barcode_result_form").slideUp("fast")
      $new_bc_res_btn.show()
