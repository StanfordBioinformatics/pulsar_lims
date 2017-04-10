# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->

  load_barcode_selection = -> 
    if ( ! $("#library_sequencing_library_prep_kit_id").val() || $("#library_paired_end").is(":checked") )
      $("#library_barcode_ids").attr("disabled","disabled")
    else
      $.get "/libraries/select_barcode", $("#library_sequencing_library_prep_kit_id").serialize(), (responseText,status,jqXHR) ->
        $("#library_barcode_ids").closest("div").replaceWith responseText

  load_barcode_selection()
    #set when page loads to, because if the _form.html.erb refreshed with a validation error, the 
    # biosample_type_id may already have been set, but no change event will fire.

  $("#library_sequencing_library_prep_kit_id").change (event) -> 
    load_barcode_selection()
  $("#library_paired_end").change (event) ->
    load_barcode_selection()
