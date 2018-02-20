# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$ ->  

  #The following code is for the show view.

  $new_bc_res_btn = $("#new_sequencing_result") #the button
  $seqresult_table_btns = $(".seqresult-table-btns")

  if $("#hide_new_sequencing_result").length == 1 
    $new_bc_res_btn.attr("disabled", "disabled")

  $new_bc_res_btn.click (event) -> 
    if ($new_bc_res_btn.attr("disabled") == "disabled")
      event.preventDefault()
    else
      $seqresult_table_btns.hide()

  $new_bc_res_btn.on "ajax:success", (event,data) ->  
    $("#sequencing_result_form").append(data)
    #this appends a form with id new_sequencing_result_form after the div with ID sequencing_result_form.
    $("#new_sequencing_result_form").hide().fadeIn("fast")

  $(document).on "change","#sequencing_result_library_id", (event) -> 
    #use event delegation above
    get_path = window.location.pathname + "/sequencing_results/get_barcode_selector"
    $.get get_path, {library_id: $("#sequencing_result_library_id").val()}, (responseText,status,jqXHR) ->
      $("#sequencing_result_barcode_id").val(responseText)

  $(document).on "change", "#sequencing_result_barcode_id", (event) ->
    #use event delegation above
    get_path = window.location.pathname + "/sequencing_results/get_library_selector"
    $.get get_path, {barcode_id: $("#sequencing_result_barcode_id").val()}, (responseText,status,jqXHR) ->
      $("#sequencing_result_library_id").val(responseText)
        
  $(document).on "click", "#rm_new_sequencing_result_form", (event) -> 
    #use event delegation above
    event.preventDefault()
    $("#new_sequencing_result_form").fadeOut "normal", ->  
      $("#new_sequencing_result_form").remove()
      $seqresult_table_btns.show()

  
