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


  #$.get "/sequencing_library_prep_kits/get_pe_kits", (responseText,status,jqXHR) ->
    
  $kit_selector = $("#library_sequencing_library_prep_kit_id")
  $paired_end_checkbox = $("#library_paired_end")
  $paired_end_checkbox.closest("div").hide()

  $barcode_selector = $("#barcode_selector")

  hide_barcode_selector = ->
    if ( ! $kit_selector.val() )
      $barcode_selector.hide()
    
  load_barcode_selection = -> 
    hide_barcode_selector()
    if ( $paired_end_checkbox.is(":checked") )
      $barcode_selector.contents().fadeOut()
      $.get "/libraries/select_paired_barcode", $kit_selector.serialize(), (responseText,status,jqXHR) ->
        $barcode_selector.html(responseText)
        $barcode_selector.contents().fadeIn()
    else if ( ! $paired_end_checkbox.is(":checked") )
      $barcode_selector.contents().fadeOut()
      $.get "/libraries/select_barcode", $kit_selector.serialize(), (responseText,status,jqXHR) ->
        $barcode_selector.html(responseText)
        $barcode_selector.contents().fadeIn()

  $kit_selector.change (event) -> 
    kit_id = parseInt($kit_selector.val())
    $.get "/sequencing_library_prep_kits/paired_end_kits", (responseText,status,jqXHR) ->
      #responseText is JSON, i.e { "sequencing_library_prep_kits": [ 5 ] }
      pe_kit_ids = responseText.sequencing_library_prep_kits
      #alert($.type(pe_kit_ids)) #array
      if $.inArray(parseInt($kit_selector.val()),pe_kit_ids) >= 0
        $paired_end_checkbox.closest("div").show()
      else
        $paired_end_checkbox.attr("checked",false)
        $paired_end_checkbox.closest("div").hide()
      load_barcode_selection()

  $paired_end_checkbox.click (event) ->
    load_barcode_selection()
  $kit_selector.change()
