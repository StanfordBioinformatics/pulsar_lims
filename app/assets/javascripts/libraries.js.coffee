# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


#nathankw notes
# The user can add a barcode (for single-index sequencing) or an index1 and index2 barcode pair for paired-end sequencing.
# In the former case, the barcode selector will be available when the paired_end input is not checked. If it is checked, 
# then only the paired_end barcode selector will be available. In either case, neither selector will be available if the 
# sequencing_library_prep_kit input isn't set. 

# I've created the Library object such that it can have either multiple barcoes or multiple paired_end indices, but not both. 
# In the Library form, however, a user can only specify one barcode or pair of indices. 
$ ->

  ###
  #The following code is used with the Library form partial:
  ###

  $kit_selector = $("#library_sequencing_library_prep_kit_id")
  $paired_end_checkbox = $("#library_paired_end")

  $paired_barcode_selector = $("#paired_barcode_selector")
  $barcode_selector = $("#barcode_selector")

  hide_select_barcode = ->
    $barcode_selector.hide()
    
  hide_select_paired_barcode = -> 
    $paired_barcode_selector.hide()

  load_barcode_selection = -> 
    if ( ! $kit_selector.val() )
      hide_select_barcode()
      hide_select_paired_barcode()
    else if ( $paired_end_checkbox.is(":checked") )
      $barcode_selector.fadeOut()
      $.get "/libraries/select_paired_barcode", $kit_selector.serialize(), (responseText,status,jqXHR) ->
        $paired_barcode_selector.html(responseText)
        $paired_barcode_selector.fadeIn()
    else if ( ! $paired_end_checkbox.is(":checked") )
      $paired_barcode_selector.fadeOut()
      $.get "/libraries/select_barcode", $kit_selector.serialize(), (responseText,status,jqXHR) ->
        $barcode_selector.html(responseText)
        $barcode_selector.fadeIn()

  load_barcode_selection()
    #set when page loads to, because if the _form.html.erb refreshed with a validation error, the 
    # biosample_type_id may already have been set, but no change event will fire.

  $kit_selector.change (event) -> 
    load_barcode_selection()
  $paired_end_checkbox.click (event) ->
    load_barcode_selection()
