# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$ ->  
  #### The following code is for the form view.
  $("#sres-data-storage-select, #sres-data-storage-new").on "ajax:success", (event, data) ->
    event.stopPropagation()
    event.preventDefault()
    $("#sres-data-storage-btns").fadeOut().after(data)

  $(document).on "click", ".sres-undo-data-storage", (event) ->
    event.preventDefault()
    event.stopPropagation()
    $(this).closest("div").fadeOut("fast").remove()
    $("#sres-data-storage-btns").fadeIn()

  # When the user fills in a value for forward_read_len, check the value of reverse_read_len and if
  # blank, set to same value. Likewise for the other way around. This is done because normally 
  # the R1 and R2 have the same number of cycles. 
  $r1_cycles = $("#sequencing_run_forward_read_len")
  $r2_cycles = $("#sequencing_run_reverse_read_len")

  $r1_cycles.on "change", (event) -> 
    if $r2_cycles
      # $r2_cycles won't be present if it's a single-end sequencing run. 
      if not $r2_cycles.val()
        $r2_cycles.val($r1_cycles.val())
  $r2_cycles.on "change", (event) -> 
    if not $r1_cycles.val()
      $r1_cycles.val($r2_cycles.val())
   

  #### The following code is for the show view.

  $new_bc_res_btn = $("#new_sequencing_result") #the button
  $seqresult_table_btns = $(".seqresult-table-btns")

  if $("#hide_new_sequencing_result").length == 1 
    # Present in view once each library has a SequencingResult. In that case, no use for a button
    # to add another SequencingResult.
    $new_bc_res_btn.attr("disabled", "disabled")

  $new_bc_res_btn.click (event) -> 
    if ($new_bc_res_btn.attr("disabled") == "disabled")
      event.preventDefault()
    else
      # Hide buttons while new SequencingResult form is shown.
      $seqresult_table_btns.hide()

  $new_bc_res_btn.on "ajax:success", (event,data) ->  
    $("#sequencing_result_form").append(data)
    #this appends a form with id new_sequencing_result_form after the div with ID sequencing_result_form.
    $("#new_sequencing_result_form").hide().fadeIn("fast")

  $(document).on "change","#sequencing_result_library_id", (event) -> 
    #use event delegation above to set the barcode, if any.
    get_path = window.location.pathname.split("sequencing_results")[0]
    # Split path above, since the event handling can be triggered if the user is editing a sequencing_result as well,
    # not just creating a new one from inside of a sequencing_run's show view. In each case, we can use
    # the same controller action.
    get_path = get_path + "/sequencing_results/get_barcode_selector"
    $.get get_path, {library_id: $("#sequencing_result_library_id").val()}, (responseText,status,jqXHR) ->
      $("#sequencing_result_barcode_id").val(responseText)

  $(document).on "change", "#sequencing_result_barcode_id", (event) ->
    #use event delegation above to set the library.
    get_path = window.location.pathname.split("sequencing_results")[0]
    # Split path above, since the event handling can be triggered if the user is editing a sequencing_result as well,
    # not just creating a new one from inside of a sequencing_run's show view. In each case, we can use
    # the same controller action.
    get_path = get_path + "/sequencing_results/get_library_selector"
    $.get get_path, {barcode_id: $("#sequencing_result_barcode_id").val()}, (responseText,status,jqXHR) ->
      $("#sequencing_result_library_id").val(responseText)
        
  $(document).on "click", "#rm_new_sequencing_result_form", (event) -> 
    #use event delegation above
    event.preventDefault()
    $("#new_sequencing_result_form").fadeOut "normal", ->  
      $("#new_sequencing_result_form").remove()
      $seqresult_table_btns.show()

  
