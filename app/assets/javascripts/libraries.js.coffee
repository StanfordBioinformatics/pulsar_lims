# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


#nathankw notes
# The user can add a barcode (for single-index sequencing) or an index1 and index2 barcode pair for paired-end sequencing.
# In the former case, the barcode selector will be available when the paired_end input is not checked. If it is checked, 
# then only the paired_end barcode selector will be available. In either case, neither selector will be available if the 
# sequencing_library_prep_kit input isn't set. 

# I've created the Library object such that it can have either multiple barcoes or multiple paired_end indices, but not both. 
# In the Library form, however, a user can only specify one barcode or pair of indices. If the user has a multiplexed library, 
# then the user can add them after the Library object has been created by clicking on a button on the show view. This is the
# simplest way to set multiple barcodes both for the user and the backend. 
$ ->

  ###
  #The following code is used with the Library form partial:
  ###

  $kit_selector = $("#library_sequencing_library_prep_kit_id")
  $paired_end_checkbox = $("#library_paired_end")
  $paired_barcode_selector = $("#library_paired_barcode_ids")

  hide_select_barcode = ->
    $("#library_barcode_ids").attr("disabled","disabled")
    
  hide_select_paired_barcode = -> 
    $("#library_paired_barcode_ids").attr("disabled","disabled")

  load_barcode_selection = -> 
    if ( ! $kit_selector.val() )
      hide_select_barcode()
      hide_select_paired_barcode()
    else if ( $paired_end_checkbox.is(":checked") )
      hide_select_barcode()
      $("#library_barcode_ids").closest("div").fadeOut()
      $.get "/libraries/select_paired_barcode", $kit_selector.serialize(), (responseText,status,jqXHR) ->
        $("#library_paired_barcode_ids").closest("div").replaceWith responseText
    else if ( ! $paired_end_checkbox.is(":checked") )
      hide_select_paired_barcode()
      $("#library_paired_barcode_ids").closest("div").fadeOut()
      $.get "/libraries/select_barcode", $kit_selector.serialize(), (responseText,status,jqXHR) ->
        $("#library_barcode_ids").closest("div").replaceWith responseText

  load_barcode_selection()
    #set when page loads to, because if the _form.html.erb refreshed with a validation error, the 
    # biosample_type_id may already have been set, but no change event will fire.

  $kit_selector.change (event) -> 
    load_barcode_selection()
  $paired_end_checkbox.click (event) ->
    load_barcode_selection()

  ###
  #The following code is used with the Library show partial:
  ###
  $bc_submit = $('div.add_barcodes input[type="submit"]')
  $add_paired_barcodes = $("#library_add_paired_barcodes")
  $add_barcodes = $("#library_add_barcodes")
  hide_bc_submit = -> 
    alert("howdy")
    if ( $add_barcodes.length == 1 && ! $add_barcodes.val() )
      $bc_submit.attr("disabled","disabled")
    else if ( $add_paired_barcodes.length == 1 && ! $add_paired_barcodes.val())
      $bc_submit.attr("disabled","disabled")
    else
      $bc_submit.attr("disabled",false)
      
  hide_bc_submit()
  $add_paired_barcodes.focus (event) ->
    $bc_submit.attr("disabled",false)
  $add_barcodes.focus (event) ->
    $bc_submit.attr("disabled",false)
  $add_paired_barcodes.blur (event) ->
    hide_bc_submit()
  $add_barcodes.blur (event) ->
    hide_bc_submit()
  
