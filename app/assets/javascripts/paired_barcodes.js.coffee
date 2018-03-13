# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->                                                                                                   
  #Refresh the sequencing_library_prep_kits list in the form when the refresh fa-icon is clicked:                   
  $(document).on "click", ".paired_barcode_sequencing_library_prep_kit i.refresh", (event) ->                           
    $.get "/sequencing_library_prep_kits/select_options", (responseText,status,jqXHR) ->                            
      $(".paired_barcode_sequencing_library_prep_kit select").html(responseText) 
