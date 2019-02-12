# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


#nathankw notes
# The user can add a barcode (for single-index sequencing) or an index1 and index2 barcode pair for dual-indexed-end sequencing.
# In the former case, the barcode selector will be available when the dual_indexed input is not checked. If it is checked, 
# then only the paired_end barcode selector will be available. In either case, neither selector will be available if the 
# sequencing_library_prep_kit input isn't set. 

$ ->

  #Refresh the antibodies list in the form when the refresh fa-icon is clicked:                   
  $(document).on "click", ".library_antibody i.refresh", (event) ->                      
    $.get "/antibodies/select_options", (responseText,status,jqXHR) ->                            
      $(".library_antibody select").html(responseText)  

  #Refresh the biosamples list in the form when the refresh fa-icon is clicked:                   
  $(document).on "click", ".library_biosample i.refresh", (event) ->                      
    $.get "/biosamples/select_options", (responseText,status,jqXHR) ->                            
      $(".library_biosample select").html(responseText)  

  #Refresh the documents list in the form when the refresh fa-icon is clicked:                         
  $(document).on "click", ".library_documents i.refresh", (event) ->                                 
    $.get "/documents/select_options", (responseText,status,jqXHR) ->                                  
      $(".library_documents select").html(responseText) 

  ###
  #The following code is used with the Library form partial:
  ###


  #$.get "/sequencing_library_prep_kits/get_pe_kits", (responseText,status,jqXHR) ->
    
  $kit_selector = $("#library_sequencing_library_prep_kit_id")
  $dual_indexed_checkbox = $("#library_dual_indexed")
  $dual_indexed_checkbox.closest("div").hide()

  $barcode_selector = $("#barcode_selector")
  # Function to hide barcode selector if the SequencingLibraryPrepKit isn't yet selected:
  hide_barcode_selector = ->
    if ( ! $kit_selector.val() )
      $barcode_selector.hide()
    
  load_barcode_selection = -> 
    hide_barcode_selector()
    kit_id = parseInt($kit_selector.val())
    # Get a list of all kits that support dual-indexing
    $.get "/sequencing_library_prep_kits/dual_indexing_kits", (responseText,status,jqXHR) ->
      #responseText is JSON, i.e { "sequencing_library_prep_kits": [ 5 ] }
      pe_kit_ids = responseText.sequencing_library_prep_kits
      #alert($.type(pe_kit_ids)) #array
      if $.inArray(kit_id, pe_kit_ids) >= 0
        $dual_indexed_checkbox.closest("div").show()
      else
        $dual_indexed_checkbox.attr("checked",false)
        $dual_indexed_checkbox.closest("div").hide()
      if isNaN(kit_id)
        return
      if ( $dual_indexed_checkbox.is(":checked") )
        $.get "/libraries/select_paired_barcode", $kit_selector.serialize(), (responseText,status,jqXHR) ->
          $barcode_selector.html(responseText)
          $barcode_selector.fadeIn()
      else if ( ! $dual_indexed_checkbox.is(":checked") )
        $.get "/libraries/select_barcode", $kit_selector.serialize(), (responseText,status,jqXHR) ->
          $barcode_selector.html(responseText)
          $barcode_selector.fadeIn()

  $kit_selector.change (event) -> 
    load_barcode_selection()

  $dual_indexed_checkbox.click (event) ->
    load_barcode_selection()

  load_barcode_selection() # For page load incase there is a default value for $kit_selector set.
  #$kit_selector.change()
